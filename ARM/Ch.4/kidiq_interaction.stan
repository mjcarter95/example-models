data {
  int<lower=0> N;
  vector[N] kid_score;
  vector[N] mom_hs;
  vector[N] mom_iq;
  real<lower=0, upper=1> phi;
}
transformed data {
  // interaction
  vector[N] inter;
  inter = mom_hs .* mom_iq;
}
parameters {
  vector[4] beta;
  real<lower=0> sigma;
}
model {
  //kid_score ~ normal(beta[1] + beta[2] * mom_hs + beta[3] * mom_iq 
  //                   + beta[4] * inter, sigma);
  
  target += phi
            * normal_lpdf(kid_score | beta[1] + beta[2] * mom_hs
                                      + beta[3] * mom_iq + beta[4] * inter, sigma);
}

