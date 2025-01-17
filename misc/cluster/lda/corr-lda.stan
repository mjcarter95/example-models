data {
  int<lower=2> K; // num topics
  int<lower=2> V; // num words
  int<lower=1> M; // num docs
  int<lower=1> N; // total word instances
  array[N] int<lower=1, upper=V> w; // word n
  array[N] int<lower=1, upper=M> doc; // doc ID for word n
  vector<lower=0>[V] beta; // word prior
}
parameters {
  vector[K] mu; // topic mean
  corr_matrix[K] Omega; // correlation matrix
  vector<lower=0>[K] sigma; // scales
  array[M] vector[K] eta; // logit topic dist for doc m
  array[K] simplex[V] phi; // word dist for topic k
}
transformed parameters {
  array[M] simplex[K] theta; // simplex topic dist for doc m
  cov_matrix[K] Sigma; // covariance matrix
  for (m in 1 : M) {
    theta[m] = softmax(eta[m]);
  }
  for (m in 1 : K) {
    Sigma[m, m] = sigma[m] * sigma[m] * Omega[m, m];
    for (n in (m + 1) : K) {
      Sigma[m, n] = sigma[m] * sigma[n] * Omega[m, n];
      Sigma[n, m] = Sigma[m, n];
    }
  }
}
model {
  // priors
  for (k in 1 : K) {
    phi[k] ~ dirichlet(beta);
  }
  mu ~ normal(0, 5);
  Omega ~ lkj_corr(2.0);
  sigma ~ cauchy(0, 5);
  // topic distribution for docs
  for (m in 1 : M) {
    eta[m] ~ multi_normal(mu, Sigma);
  }
  // token probabilities
  for (n in 1 : N) {
    array[K] real gamma;
    for (k in 1 : K) {
      gamma[k] = log(theta[doc[n], k]) + log(phi[k, w[n]]);
    }
    target += log_sum_exp(gamma); // likelihood
  }
}

