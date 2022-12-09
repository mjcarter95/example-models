library("rstan")
library(jsonlite)
library("stringi")

stan_models = list.files(path=paste0(getwd(), "/Projects/stan_example_models"), pattern = "*.stan$", recursive = TRUE)
stan_models

for (stan_model in stan_models) {
  data_path = paste0(getwd(), "/Projects/stan_example_models/", gsub(".stan", ".data.R", stan_model))
  output_path = paste0(getwd(), "/Projects/stan_example_models/", gsub(".stan", ".json", stan_model))
  if (file.exists(data_path) && !file.exists(output_path)) {
    print(paste0("Processing model ", stan_model))
    data = read_rdump(data_path)
    json_data = toJSON(data)
    write(json_data, output_path)
  }
}
