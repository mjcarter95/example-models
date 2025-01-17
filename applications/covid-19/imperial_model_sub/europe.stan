data {
  int<lower=1> M; // number of countries
  int<lower=1> P; // number of covariates for full pooling (global effects)
  int<lower=1> P_partial_macro; // number of covariates for partial pooling (region-level effects)
  int<lower=1> P_partial_micro; // number of covariates for partial pooling (state-level effects)
  int<lower=1> N0; // number of days for which to impute infections
  array[M] int<lower=1> N; // days of observed data for country m. each entry must be <= N2
  int<lower=1> N2; // days of observed data + # of days to forecast
  array[N2, M] int deaths; // reported deaths -- the rows with i > N contain -1 and should be ignored
  matrix[N2, M] f; // ifr
  array[M] matrix[N2, P] X;
  array[M] matrix[N2, P_partial_macro] X_partial_macro;
  array[M] matrix[N2, P_partial_micro] X_partial_micro;
  array[M] int EpidemicStart;
  array[M] real pop;
  int W; // number of weeks for weekly effects
  int Q; // no.of regions
  array[M] int Region; // Macro region index for each state
  array[M, N2] int week_index;
  array[N2] real SI; // fixed SI using empirical data
}
transformed data {
  vector[N2] SI_rev; // SI in reverse order
  array[M] vector[N2] f_rev; // f in reversed order
  
  for (i in 1 : N2) {
    SI_rev[i] = SI[N2 - i + 1];
  }
  
  for (m in 1 : M) {
    for (i in 1 : N2) {
      f_rev[m, i] = f[N2 - i + 1, m];
    }
  }
}
parameters {
  array[M] real<lower=0> mu;
  vector[P] alpha;
  array[Q] vector[P_partial_macro] alpha_macro;
  array[M] vector[P_partial_micro] alpha_micro;
  real<lower=0> gamma_macro;
  real<lower=0> gamma_micro;
  real<lower=0> kappa;
  array[M] real<lower=0> y;
  real<lower=0> phi;
  real<lower=0> tau;
  array[M] real<lower=0> ifr_noise;
  // real<lower=0> NYtoCT;
  matrix[W + 1, M] weekly_effect;
  real<lower=0, upper=1> weekly_rho;
  real<lower=0, upper=1> weekly_rho1;
  // real<lower=0> iota;
  real<lower=0> weekly_sd;
}
transformed parameters {
  matrix[N2, M] prediction = rep_matrix(0, N2, M);
  matrix[N2, M] E_deaths = rep_matrix(0, N2, M);
  matrix[N2, M] Rt = rep_matrix(0, N2, M);
  matrix[N2, M] Rt_adj = Rt;
  matrix[N2, M] infectiousness = rep_matrix(0, N2, M);
  
  {
    matrix[N2, M] cumm_sum = rep_matrix(0, N2, M);
    
    for (m in 1 : M) {
      prediction[1 : N0, m] = rep_vector(y[m], N0); // learn the number of cases in the first N0 days
      cumm_sum[2 : N0, m] = cumulative_sum(prediction[2 : N0, m]);
      
      Rt[ : , m] = mu[m] * 2
                   * inv_logit(-X[m] * alpha
                               - X_partial_macro[m] * alpha_macro[Region[m]]
                               - X_partial_micro[m] * alpha_micro[m]
                               - weekly_effect[week_index[m], m]);
      Rt_adj[1 : N0, m] = Rt[1 : N0, m];
      
      for (i in 2 : N0) {
        real convolution = 0;
        for (j in 1 : (i - 1)) {
          convolution += prediction[j, m] * SI[i - j] / max(SI);
        }
        infectiousness[i, m] = convolution;
      }
      
      for (i in (N0 + 1) : N2) {
        real convolution = dot_product(sub_col(prediction, 1, m, i - 1),
                                       tail(SI_rev, i - 1));
        
        cumm_sum[i, m] = cumm_sum[i - 1, m] + prediction[i - 1, m];
        Rt_adj[i, m] = ((pop[m] - cumm_sum[i, m]) / pop[m]) * Rt[i, m];
        // prediction[i,m]=(pop[m]-cumm_sum[i,m])*(1-exp(-Rt[i,m]*convolution/pop[m]));
        prediction[i, m] = Rt_adj[i, m] * convolution;
        infectiousness[i, m] = convolution / max(SI);
      }
      E_deaths[1, m] = 1e-15 * prediction[1, m];
      for (i in 2 : N2) {
        E_deaths[i, m] = ifr_noise[m]
                         * dot_product(sub_col(prediction, 1, m, i - 1),
                                       tail(f_rev[m], i - 1));
      }
    }
  }
}
model {
  tau ~ exponential(0.03);
  gamma_macro ~ normal(0, .5);
  gamma_micro ~ normal(0, .5);
  weekly_sd ~ normal(0, 0.2);
  weekly_rho ~ normal(0.8, 0.05);
  weekly_rho1 ~ normal(0.1, 0.05);
  
  for (m in 1 : M) {
    y[m] ~ exponential(1 / tau);
    weekly_effect[3 : (W + 1), m] ~ normal(weekly_effect[2 : W, m]
                                           * weekly_rho
                                           + weekly_effect[1 : (W - 1), m]
                                             * weekly_rho1,
                                           weekly_sd
                                           * sqrt(1 - pow(weekly_rho, 2)
                                                  - pow(weekly_rho1, 2)
                                                  - 2 * pow(weekly_rho, 2)
                                                    * weekly_rho1
                                                    / (1 - weekly_rho1)));
  }
  weekly_effect[2,  : ] ~ normal(0,
                                 weekly_sd
                                 * sqrt(1 - pow(weekly_rho, 2)
                                        - pow(weekly_rho1, 2)
                                        - 2 * pow(weekly_rho, 2)
                                          * weekly_rho1 / (1 - weekly_rho1)));
  weekly_effect[1,  : ] ~ normal(0, 0.01);
  for (q in 1 : Q) {
    alpha_macro[q] ~ normal(0, gamma_macro);
  }
  for (q in 1 : M) {
    alpha_micro[q] ~ normal(0, gamma_micro);
  }
  phi ~ normal(0, 5);
  kappa ~ normal(0, 0.5);
  mu ~ normal(3.28, kappa); // citation: https://academic.oup.com/jtm/article/27/2/taaa021/5735319
  alpha ~ normal(0, 0.5);
  ifr_noise ~ normal(1, 0.1);
  // NYtoCT ~ normal(0,.02);
  
  for (m in 1 : M) {
    deaths[EpidemicStart[m] : N[m], m] ~ neg_binomial_2(E_deaths[EpidemicStart[m] : N[m], m],
                                                        phi);
  }
}
// generated quantities {
//   matrix[N2,M] deaths_predicted = rep_matrix(0, N2, M); // actual predicted deaths, accounting for the noise from the negbin likelihood
// 
//   for (m in 1:M){
//      for(i in (EpidemicStart[m]):N2) {
//       deaths_predicted[i,m] = neg_binomial_2_rng(E_deaths[i,m], phi);
//     }
//   }
// }
