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
  array[K, K] int<lower=0> trans;
  array[K, V] int<lower=0> emit;
  for (k1 in 1 : K) {
    for (k2 in 1 : K) {
      trans[k1, k2] = 0;
    }
  }
  for (t in 2 : T) {
    trans[z[t - 1], z[t]] = 1 + trans[z[t - 1], z[t]];
  }
  for (k in 1 : K) {
    for (v in 1 : V) {
      emit[k, v] = 0;
    }
  }
  for (t in 1 : T) {
    emit[z[t], w[t]] = 1 + emit[z[t], w[t]];
  }
}
parameters {
  array[K] simplex[K] theta; // transit probs
  array[K] simplex[V] phi; // emit probs
}
model {
  for (k in 1 : K) {
    theta[k] ~ dirichlet(alpha);
  }
  for (k in 1 : K) {
    phi[k] ~ dirichlet(beta);
  }
  
  for (k in 1 : K) {
    trans[k] ~ multinomial(theta[k]);
  }
  for (k in 1 : K) {
    emit[k] ~ multinomial(phi[k]);
  }
}

