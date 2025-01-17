data {
  int<lower=1> K; // num categories
  int<lower=1> V; // num words
  int<lower=0> T; // num instances
  array[T] int<lower=1, upper=V> w; // words
  array[T] int<lower=1, upper=K> z; // categories
  vector<lower=0>[K] alpha; // transit prior
  vector<lower=0>[V] beta; // emit prior
}
transformed data {
  array[K] vector<lower=0>[K] alpha_post;
  array[K] vector<lower=0>[V] beta_post;
  for (k in 1 : K) {
    alpha_post[k] = alpha;
  }
  for (t in 2 : T) {
    alpha_post[z[t - 1], z[t]] = alpha_post[z[t - 1], z[t]] + 1;
  }
  for (k in 1 : K) {
    beta_post[k] = beta;
  }
  for (t in 1 : T) {
    beta_post[z[t], w[t]] = beta_post[z[t], w[t]] + 1;
  }
}
parameters {
  array[K] simplex[K] theta; // transit probs
  array[K] simplex[V] phi; // emit probs
}
model {
  for (k in 1 : K) {
    theta[k] ~ dirichlet(alpha_post[k]);
  }
  for (k in 1 : K) {
    phi[k] ~ dirichlet(beta_post[k]);
  }
}

