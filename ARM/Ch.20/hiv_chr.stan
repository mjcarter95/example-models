data {
  int<lower=0> J; 
  int<lower=0> N;
  int<lower=1,upper=J> person[N];
  vector[N] time;
  vector[N] y;
  real<lower=0, upper=1> phi; //tempering constant
} 
parameters {
  vector[J] eta1;
  vector[J] eta2;
  real mu_a1;
  real mu_a2;
  real<lower=0,upper=100> sigma_a1;
  real<lower=0,upper=100> sigma_a2;
  real<lower=0,upper=100> sigma_y;
}
transformed parameters {
  vector[J] a1;
  vector[J] a2;
  vector[N] y_hat;

  a1 = mu_a1 + sigma_a1 * eta1;
  a2 = 0.1 * mu_a2 + sigma_a2 * eta2;

  for (i in 1:N)
    y_hat[i] = a1[person[i]] + a2[person[i]] * time[i];
} 
model {
  //mu_a1 ~ normal(0, 1);
  //mu_a2 ~ normal(0, 1);
  //eta1 ~ normal (0,1);
  //eta2 ~ normal (0,1);

  // Rewrite priors
  target += normal_lpdf(mu_a1 | 0, 1);
  target += normal_lpdf(mu_a2 | 0, 1);
  target += normal_lpdf(eta1 | 0, 1);
  target += normal_lpdf(eta2 | 0, 1);

  // y ~ normal(y_hat, sigma_y);

  // rewrite log likehood
  target += phi * normal_lpdf(y | y_hat, sigma_y);

}
