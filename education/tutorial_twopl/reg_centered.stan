data {
  int<lower=1> I; // # questions
  int<lower=1> J; // # persons
  int<lower=1> N; // # observations
  array[N] int<lower=1, upper=I> ii; // question for n
  array[N] int<lower=1, upper=J> jj; // person for n
  array[N] int<lower=0, upper=1> y; // correctness for n
  array[J] real x; // covariate for person j
}
parameters {
  vector<lower=0>[I] alpha; // discrimination for item i
  vector[I] beta; // difficulty for item i
  vector[J] theta; // ability for person j
  real gamma; // regression coefficient of x
}
model {
  vector[N] eta;
  alpha ~ lognormal(0.5, 1);
  beta ~ normal(0, 10);
  for (j in 1 : J) {
    theta[j] ~ normal(gamma * x[j], 1);
  }
  for (n in 1 : N) {
    eta[n] = alpha[ii[n]] * (theta[jj[n]] - beta[ii[n]]);
  }
  y ~ bernoulli_logit(eta);
}

