data {
  int<lower=0> N;
  vector[N] kid_score;
  vector[N] mom_hs;
  vector[N] mom_iq;
  real<lower=0, upper=1> phi;
}
transformed data {
  // standardizing
  vector[N] z_mom_hs;
  vector[N] z_mom_iq;
  vector[N] inter;
  z_mom_hs = (mom_hs - mean(mom_hs)) / (2 * sd(mom_hs));
  z_mom_iq = (mom_iq - mean(mom_iq)) / (2 * sd(mom_iq));
  inter = z_mom_hs .* z_mom_iq;
}
parameters {
  vector[4] beta;
  real<lower=0> sigma;
}
model {
  //kid_score ~ normal(beta[1] + beta[2] * z_mom_hs + beta[3] * z_mom_iq 
  //                   + beta[4] * inter, sigma);
  target += phi
            * normal_lpdf(kid_score | beta[1] + beta[2] * z_mom_hs
                                      + beta[3] * z_mom_iq + beta[4] * inter, sigma);
}

