data {
  int<lower=0> N;
  int<lower=0> N_edges;
  array[N_edges] int<lower=1, upper=N> node1; // node1[i] adjacent to node2[i]
  array[N_edges] int<lower=1, upper=N> node2; // and node1[i] < node2[i]
  
  array[N] int<lower=0> y; // count outcomes
  vector[N] x; // predictor
}
parameters {
  real beta0; // intercept
  real beta1; // slope
  
  real<lower=0> tau_theta; // precision of heterogeneous effects
  real<lower=0> tau_phi; // precision of spatial effects
  
  vector[N] theta_std; // standardized heterogeneous effects
  vector[N - 1] phi_std_raw; // raw, standardized spatial effects
}
transformed parameters {
  real<lower=0> sigma_theta = inv(sqrt(tau_theta)); // convert precision to sigma
  vector[N] theta = theta_std * sigma_theta; // non-centered parameterization
  
  real<lower=0> sigma_phi = inv(sqrt(tau_phi)); // convert precision to sigma
  vector[N] phi;
  phi[1 : N - 1] = phi_std_raw;
  phi[N] = -sum(phi_std_raw);
  phi = phi * sigma_phi; // non-centered parameterization
}
model {
  y ~ poisson_log(beta0 + beta1 * x + theta + phi);
  
  target += -0.5 * dot_self(phi[node1] - phi[node2]);
  
  beta0 ~ normal(0, 10);
  beta1 ~ normal(0, 5);
  theta_std ~ normal(0, 1);
  tau_theta ~ gamma(3.2761, 1.81); // Carlin WinBUGS priors
  tau_phi ~ gamma(1, 1); // Carlin WinBUGS priors
}
generated quantities {
  vector[N] mu = exp(beta0 + beta1 * x + phi + theta);
  real psi = sd(phi) / (sd(theta) + sd(phi)); // proportion spatial variation
}

