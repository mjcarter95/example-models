/**
 * Bradley-Terry model for teams, where each team is made up of
 * players, and the ability of a team is the sum of the abilities of
 * its players.
 */
data {
  int<lower=0> K; // players
  int<lower=0> J; // players per team
  int<lower=0> N; // matches
  array[N, J] int<lower=1, upper=K> team0; // team 0 players
  array[N, J] int<lower=1, upper=K> team1; // team 1 players
  array[N] int<lower=0, upper=1> y; // winner
}
parameters {
  vector[K] alpha_std;
  real<lower=0> sigma;
}
transformed parameters {
  vector[K] alpha = sigma * alpha_std; // alpha ~ normal(0, sigma)
}
model {
  sigma ~ lognormal(0, 0.5); // zero avoiding, weakly informative
  alpha_std ~ normal(0, 1); // hierarchical, zero centered
  for (n in 1 : N) {
    // additive Bradley-Terry model
    y[n] ~ bernoulli_logit(sum(alpha[team1[n]]) - sum(alpha[team0[n]]));
  }
}
generated quantities {
  array[K] int<lower=1, upper=K> ranking; // rank of player ability
  {
    array[K] int ranked_index = sort_indices_desc(alpha);
    for (k in 1 : K) {
      ranking[ranked_index[k]] = k;
    }
  }
}

