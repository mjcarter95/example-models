data {
  int<lower=1> I; // # questions
  int<lower=1> J; // # persons
  int<lower=1> N; // # observations
  array[N] int<lower=1, upper=I> ii; // question for n
  array[N] int<lower=1, upper=J> jj; // person for n
  array[N] int<lower=0, upper=1> y; // correctness for n
  array[J] real x; // covariate for person j
  array[N] int<lower=0, upper=1> Ik; // Indicator for item k
}
parameters {
  vector<lower=0>[I] alpha; // discrimination for item i
  vector[I] beta; // difficulty for item i
  real gamma; // regression coefficient of x
  vector[J] epsilon; // error term in the regression model
  real delta; // DIF parameter for item k
}
model {
  vector[N] eta;
  vector[J] theta; // ability for person j
  alpha ~ lognormal(0.5, 1);
  beta ~ normal(0, 10);
  epsilon ~ normal(0, 1);
  for (j in 1 : J) {
    theta[j] = (gamma * x[j]) + epsilon[j];
  }
  for (n in 1 : N) {
    eta[n] = alpha[ii[n]]
             * (theta[jj[n]] - (beta[ii[n]] + delta * Ik[n] * x[jj[n]]));
  }
  y ~ bernoulli_logit(eta);
}

