// Code generated by stanc v2.32.2
#include <stan/model/model_header.hpp>
namespace earn_height_model_namespace {
using stan::model::model_base_crtp;
using namespace stan::math;
stan::math::profile_map profiles__;
static constexpr std::array<const char*, 10> locations_array__ =
  {" (found before start of program)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 8, column 2 to column 17)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 9, column 2 to column 22)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 13, column 2 to column 71)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 2, column 2 to column 17)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 3, column 9 to column 10)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 3, column 2 to column 17)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 4, column 9 to column 10)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 4, column 2 to column 19)",
  " (in '/mnt/c/Windows/System32/example-models-master/ARM/Ch.4/earn_height.stan', line 5, column 2 to column 29)"};
class earn_height_model final : public model_base_crtp<earn_height_model> {
 private:
  int N;
  Eigen::Matrix<double,-1,1> earn_data__;
  Eigen::Matrix<double,-1,1> height_data__;
  double phi;
  Eigen::Map<Eigen::Matrix<double,-1,1>> earn{nullptr, 0};
  Eigen::Map<Eigen::Matrix<double,-1,1>> height{nullptr, 0};
 public:
  ~earn_height_model() {}
  earn_height_model(stan::io::var_context& context__, unsigned int
                    random_seed__ = 0, std::ostream* pstream__ = nullptr)
      : model_base_crtp(0) {
    int current_statement__ = 0;
    using local_scalar_t__ = double;
    boost::ecuyer1988 base_rng__ =
      stan::services::util::create_rng(random_seed__, 0);
    // suppress unused var warning
    (void) base_rng__;
    static constexpr const char* function__ =
      "earn_height_model_namespace::earn_height_model";
    // suppress unused var warning
    (void) function__;
    local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
    // suppress unused var warning
    (void) DUMMY_VAR__;
    try {
      int pos__ = std::numeric_limits<int>::min();
      pos__ = 1;
      current_statement__ = 4;
      context__.validate_dims("data initialization", "N", "int",
        std::vector<size_t>{});
      N = std::numeric_limits<int>::min();
      current_statement__ = 4;
      N = context__.vals_i("N")[(1 - 1)];
      current_statement__ = 4;
      stan::math::check_greater_or_equal(function__, "N", N, 0);
      current_statement__ = 5;
      stan::math::validate_non_negative_index("earn", "N", N);
      current_statement__ = 6;
      context__.validate_dims("data initialization", "earn", "double",
        std::vector<size_t>{static_cast<size_t>(N)});
      earn_data__ = Eigen::Matrix<double,-1,1>::Constant(N,
                      std::numeric_limits<double>::quiet_NaN());
      new (&earn) Eigen::Map<Eigen::Matrix<double,-1,1>>(earn_data__.data(),
        N);
      {
        std::vector<local_scalar_t__> earn_flat__;
        current_statement__ = 6;
        earn_flat__ = context__.vals_r("earn");
        current_statement__ = 6;
        pos__ = 1;
        current_statement__ = 6;
        for (int sym1__ = 1; sym1__ <= N; ++sym1__) {
          current_statement__ = 6;
          stan::model::assign(earn, earn_flat__[(pos__ - 1)],
            "assigning variable earn", stan::model::index_uni(sym1__));
          current_statement__ = 6;
          pos__ = (pos__ + 1);
        }
      }
      current_statement__ = 7;
      stan::math::validate_non_negative_index("height", "N", N);
      current_statement__ = 8;
      context__.validate_dims("data initialization", "height", "double",
        std::vector<size_t>{static_cast<size_t>(N)});
      height_data__ = Eigen::Matrix<double,-1,1>::Constant(N,
                        std::numeric_limits<double>::quiet_NaN());
      new (&height)
        Eigen::Map<Eigen::Matrix<double,-1,1>>(height_data__.data(), N);
      {
        std::vector<local_scalar_t__> height_flat__;
        current_statement__ = 8;
        height_flat__ = context__.vals_r("height");
        current_statement__ = 8;
        pos__ = 1;
        current_statement__ = 8;
        for (int sym1__ = 1; sym1__ <= N; ++sym1__) {
          current_statement__ = 8;
          stan::model::assign(height, height_flat__[(pos__ - 1)],
            "assigning variable height", stan::model::index_uni(sym1__));
          current_statement__ = 8;
          pos__ = (pos__ + 1);
        }
      }
      current_statement__ = 9;
      context__.validate_dims("data initialization", "phi", "double",
        std::vector<size_t>{});
      phi = std::numeric_limits<double>::quiet_NaN();
      current_statement__ = 9;
      phi = context__.vals_r("phi")[(1 - 1)];
      current_statement__ = 9;
      stan::math::check_greater_or_equal(function__, "phi", phi, 0);
      current_statement__ = 9;
      stan::math::check_less_or_equal(function__, "phi", phi, 1);
    } catch (const std::exception& e) {
      stan::lang::rethrow_located(e, locations_array__[current_statement__]);
    }
    num_params_r__ = 2 + 1;
  }
  inline std::string model_name() const final {
    return "earn_height_model";
  }
  inline std::vector<std::string> model_compile_info() const noexcept {
    return std::vector<std::string>{"stanc_version = stanc3 v2.32.2",
             "stancflags = "};
  }
  template <bool propto__, bool jacobian__, typename VecR, typename VecI,
            stan::require_vector_like_t<VecR>* = nullptr,
            stan::require_vector_like_vt<std::is_integral, VecI>* = nullptr>
  inline stan::scalar_type_t<VecR>
  log_prob_impl(VecR& params_r__, VecI& params_i__, std::ostream*
                pstream__ = nullptr) const {
    using T__ = stan::scalar_type_t<VecR>;
    using local_scalar_t__ = T__;
    T__ lp__(0.0);
    stan::math::accumulator<T__> lp_accum__;
    stan::io::deserializer<local_scalar_t__> in__(params_r__, params_i__);
    int current_statement__ = 0;
    local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
    // suppress unused var warning
    (void) DUMMY_VAR__;
    static constexpr const char* function__ =
      "earn_height_model_namespace::log_prob";
    // suppress unused var warning
    (void) function__;
    try {
      Eigen::Matrix<local_scalar_t__,-1,1> beta =
        Eigen::Matrix<local_scalar_t__,-1,1>::Constant(2, DUMMY_VAR__);
      current_statement__ = 1;
      beta = in__.template read<Eigen::Matrix<local_scalar_t__,-1,1>>(2);
      local_scalar_t__ sigma = DUMMY_VAR__;
      current_statement__ = 2;
      sigma = in__.template read_constrain_lb<local_scalar_t__,
                jacobian__>(0, lp__);
      {
        current_statement__ = 3;
        lp_accum__.add((phi *
          stan::math::normal_lpdf<false>(earn,
            stan::math::add(
              stan::model::rvalue(beta, "beta", stan::model::index_uni(1)),
              stan::math::multiply(
                stan::model::rvalue(beta, "beta", stan::model::index_uni(2)),
                height)), sigma)));
      }
    } catch (const std::exception& e) {
      stan::lang::rethrow_located(e, locations_array__[current_statement__]);
    }
    lp_accum__.add(lp__);
    return lp_accum__.sum();
  }
  template <typename RNG, typename VecR, typename VecI, typename VecVar,
            stan::require_vector_like_vt<std::is_floating_point,
            VecR>* = nullptr, stan::require_vector_like_vt<std::is_integral,
            VecI>* = nullptr, stan::require_vector_vt<std::is_floating_point,
            VecVar>* = nullptr>
  inline void
  write_array_impl(RNG& base_rng__, VecR& params_r__, VecI& params_i__,
                   VecVar& vars__, const bool
                   emit_transformed_parameters__ = true, const bool
                   emit_generated_quantities__ = true, std::ostream*
                   pstream__ = nullptr) const {
    using local_scalar_t__ = double;
    stan::io::deserializer<local_scalar_t__> in__(params_r__, params_i__);
    stan::io::serializer<local_scalar_t__> out__(vars__);
    static constexpr bool propto__ = true;
    // suppress unused var warning
    (void) propto__;
    double lp__ = 0.0;
    // suppress unused var warning
    (void) lp__;
    int current_statement__ = 0;
    stan::math::accumulator<double> lp_accum__;
    local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
    // suppress unused var warning
    (void) DUMMY_VAR__;
    constexpr bool jacobian__ = false;
    static constexpr const char* function__ =
      "earn_height_model_namespace::write_array";
    // suppress unused var warning
    (void) function__;
    try {
      Eigen::Matrix<double,-1,1> beta =
        Eigen::Matrix<double,-1,1>::Constant(2,
          std::numeric_limits<double>::quiet_NaN());
      current_statement__ = 1;
      beta = in__.template read<Eigen::Matrix<local_scalar_t__,-1,1>>(2);
      double sigma = std::numeric_limits<double>::quiet_NaN();
      current_statement__ = 2;
      sigma = in__.template read_constrain_lb<local_scalar_t__,
                jacobian__>(0, lp__);
      out__.write(beta);
      out__.write(sigma);
      if (stan::math::logical_negation(
            (stan::math::primitive_value(emit_transformed_parameters__) ||
            stan::math::primitive_value(emit_generated_quantities__)))) {
        return ;
      }
      if (stan::math::logical_negation(emit_generated_quantities__)) {
        return ;
      }
    } catch (const std::exception& e) {
      stan::lang::rethrow_located(e, locations_array__[current_statement__]);
    }
  }
  template <typename VecVar, typename VecI,
            stan::require_vector_t<VecVar>* = nullptr,
            stan::require_vector_like_vt<std::is_integral, VecI>* = nullptr>
  inline void
  unconstrain_array_impl(const VecVar& params_r__, const VecI& params_i__,
                         VecVar& vars__, std::ostream* pstream__ = nullptr) const {
    using local_scalar_t__ = double;
    stan::io::deserializer<local_scalar_t__> in__(params_r__, params_i__);
    stan::io::serializer<local_scalar_t__> out__(vars__);
    int current_statement__ = 0;
    local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
    // suppress unused var warning
    (void) DUMMY_VAR__;
    try {
      int pos__ = std::numeric_limits<int>::min();
      pos__ = 1;
      Eigen::Matrix<local_scalar_t__,-1,1> beta =
        Eigen::Matrix<local_scalar_t__,-1,1>::Constant(2, DUMMY_VAR__);
      current_statement__ = 1;
      stan::model::assign(beta,
        in__.read<Eigen::Matrix<local_scalar_t__,-1,1>>(2),
        "assigning variable beta");
      out__.write(beta);
      local_scalar_t__ sigma = DUMMY_VAR__;
      current_statement__ = 2;
      sigma = in__.read<local_scalar_t__>();
      out__.write_free_lb(0, sigma);
    } catch (const std::exception& e) {
      stan::lang::rethrow_located(e, locations_array__[current_statement__]);
    }
  }
  template <typename VecVar, stan::require_vector_t<VecVar>* = nullptr>
  inline void
  transform_inits_impl(const stan::io::var_context& context__, VecVar&
                       vars__, std::ostream* pstream__ = nullptr) const {
    using local_scalar_t__ = double;
    stan::io::serializer<local_scalar_t__> out__(vars__);
    int current_statement__ = 0;
    local_scalar_t__ DUMMY_VAR__(std::numeric_limits<double>::quiet_NaN());
    // suppress unused var warning
    (void) DUMMY_VAR__;
    try {
      current_statement__ = 1;
      context__.validate_dims("parameter initialization", "beta", "double",
        std::vector<size_t>{static_cast<size_t>(2)});
      current_statement__ = 2;
      context__.validate_dims("parameter initialization", "sigma", "double",
        std::vector<size_t>{});
      int pos__ = std::numeric_limits<int>::min();
      pos__ = 1;
      Eigen::Matrix<local_scalar_t__,-1,1> beta =
        Eigen::Matrix<local_scalar_t__,-1,1>::Constant(2, DUMMY_VAR__);
      {
        std::vector<local_scalar_t__> beta_flat__;
        current_statement__ = 1;
        beta_flat__ = context__.vals_r("beta");
        current_statement__ = 1;
        pos__ = 1;
        current_statement__ = 1;
        for (int sym1__ = 1; sym1__ <= 2; ++sym1__) {
          current_statement__ = 1;
          stan::model::assign(beta, beta_flat__[(pos__ - 1)],
            "assigning variable beta", stan::model::index_uni(sym1__));
          current_statement__ = 1;
          pos__ = (pos__ + 1);
        }
      }
      out__.write(beta);
      local_scalar_t__ sigma = DUMMY_VAR__;
      current_statement__ = 2;
      sigma = context__.vals_r("sigma")[(1 - 1)];
      out__.write_free_lb(0, sigma);
    } catch (const std::exception& e) {
      stan::lang::rethrow_located(e, locations_array__[current_statement__]);
    }
  }
  inline void
  get_param_names(std::vector<std::string>& names__, const bool
                  emit_transformed_parameters__ = true, const bool
                  emit_generated_quantities__ = true) const {
    names__ = std::vector<std::string>{"beta", "sigma"};
    if (emit_transformed_parameters__) {}
    if (emit_generated_quantities__) {}
  }
  inline void
  get_dims(std::vector<std::vector<size_t>>& dimss__, const bool
           emit_transformed_parameters__ = true, const bool
           emit_generated_quantities__ = true) const {
    dimss__ = std::vector<std::vector<size_t>>{std::vector<size_t>{static_cast<
                                                                    size_t>(2)},
                std::vector<size_t>{}};
    if (emit_transformed_parameters__) {}
    if (emit_generated_quantities__) {}
  }
  inline void
  constrained_param_names(std::vector<std::string>& param_names__, bool
                          emit_transformed_parameters__ = true, bool
                          emit_generated_quantities__ = true) const final {
    for (int sym1__ = 1; sym1__ <= 2; ++sym1__) {
      param_names__.emplace_back(std::string() + "beta" + '.' +
        std::to_string(sym1__));
    }
    param_names__.emplace_back(std::string() + "sigma");
    if (emit_transformed_parameters__) {}
    if (emit_generated_quantities__) {}
  }
  inline void
  unconstrained_param_names(std::vector<std::string>& param_names__, bool
                            emit_transformed_parameters__ = true, bool
                            emit_generated_quantities__ = true) const final {
    for (int sym1__ = 1; sym1__ <= 2; ++sym1__) {
      param_names__.emplace_back(std::string() + "beta" + '.' +
        std::to_string(sym1__));
    }
    param_names__.emplace_back(std::string() + "sigma");
    if (emit_transformed_parameters__) {}
    if (emit_generated_quantities__) {}
  }
  inline std::string get_constrained_sizedtypes() const {
    return std::string("[{\"name\":\"beta\",\"type\":{\"name\":\"vector\",\"length\":" + std::to_string(2) + "},\"block\":\"parameters\"},{\"name\":\"sigma\",\"type\":{\"name\":\"real\"},\"block\":\"parameters\"}]");
  }
  inline std::string get_unconstrained_sizedtypes() const {
    return std::string("[{\"name\":\"beta\",\"type\":{\"name\":\"vector\",\"length\":" + std::to_string(2) + "},\"block\":\"parameters\"},{\"name\":\"sigma\",\"type\":{\"name\":\"real\"},\"block\":\"parameters\"}]");
  }
  // Begin method overload boilerplate
  template <typename RNG> inline void
  write_array(RNG& base_rng, Eigen::Matrix<double,-1,1>& params_r,
              Eigen::Matrix<double,-1,1>& vars, const bool
              emit_transformed_parameters = true, const bool
              emit_generated_quantities = true, std::ostream*
              pstream = nullptr) const {
    const size_t num_params__ = (2 + 1);
    const size_t num_transformed = emit_transformed_parameters * (0);
    const size_t num_gen_quantities = emit_generated_quantities * (0);
    const size_t num_to_write = num_params__ + num_transformed +
      num_gen_quantities;
    std::vector<int> params_i;
    vars = Eigen::Matrix<double,-1,1>::Constant(num_to_write,
             std::numeric_limits<double>::quiet_NaN());
    write_array_impl(base_rng, params_r, params_i, vars,
      emit_transformed_parameters, emit_generated_quantities, pstream);
  }
  template <typename RNG> inline void
  write_array(RNG& base_rng, std::vector<double>& params_r, std::vector<int>&
              params_i, std::vector<double>& vars, bool
              emit_transformed_parameters = true, bool
              emit_generated_quantities = true, std::ostream*
              pstream = nullptr) const {
    const size_t num_params__ = (2 + 1);
    const size_t num_transformed = emit_transformed_parameters * (0);
    const size_t num_gen_quantities = emit_generated_quantities * (0);
    const size_t num_to_write = num_params__ + num_transformed +
      num_gen_quantities;
    vars = std::vector<double>(num_to_write,
             std::numeric_limits<double>::quiet_NaN());
    write_array_impl(base_rng, params_r, params_i, vars,
      emit_transformed_parameters, emit_generated_quantities, pstream);
  }
  template <bool propto__, bool jacobian__, typename T_> inline T_
  log_prob(Eigen::Matrix<T_,-1,1>& params_r, std::ostream* pstream = nullptr) const {
    Eigen::Matrix<int,-1,1> params_i;
    return log_prob_impl<propto__, jacobian__>(params_r, params_i, pstream);
  }
  template <bool propto__, bool jacobian__, typename T_> inline T_
  log_prob(std::vector<T_>& params_r, std::vector<int>& params_i,
           std::ostream* pstream = nullptr) const {
    return log_prob_impl<propto__, jacobian__>(params_r, params_i, pstream);
  }
  inline void
  transform_inits(const stan::io::var_context& context,
                  Eigen::Matrix<double,-1,1>& params_r, std::ostream*
                  pstream = nullptr) const final {
    std::vector<double> params_r_vec(params_r.size());
    std::vector<int> params_i;
    transform_inits(context, params_i, params_r_vec, pstream);
    params_r = Eigen::Map<Eigen::Matrix<double,-1,1>>(params_r_vec.data(),
                 params_r_vec.size());
  }
  inline void
  transform_inits(const stan::io::var_context& context, std::vector<int>&
                  params_i, std::vector<double>& vars, std::ostream*
                  pstream__ = nullptr) const {
    vars.resize(num_params_r__);
    transform_inits_impl(context, vars, pstream__);
  }
  inline void
  unconstrain_array(const std::vector<double>& params_constrained,
                    std::vector<double>& params_unconstrained, std::ostream*
                    pstream = nullptr) const {
    const std::vector<int> params_i;
    params_unconstrained = std::vector<double>(num_params_r__,
                             std::numeric_limits<double>::quiet_NaN());
    unconstrain_array_impl(params_constrained, params_i,
      params_unconstrained, pstream);
  }
  inline void
  unconstrain_array(const Eigen::Matrix<double,-1,1>& params_constrained,
                    Eigen::Matrix<double,-1,1>& params_unconstrained,
                    std::ostream* pstream = nullptr) const {
    const std::vector<int> params_i;
    params_unconstrained = Eigen::Matrix<double,-1,1>::Constant(num_params_r__,
                             std::numeric_limits<double>::quiet_NaN());
    unconstrain_array_impl(params_constrained, params_i,
      params_unconstrained, pstream);
  }
};
}
using stan_model = earn_height_model_namespace::earn_height_model;
#ifndef USING_R
// Boilerplate
stan::model::model_base&
new_model(stan::io::var_context& data_context, unsigned int seed,
          std::ostream* msg_stream) {
  stan_model* m = new stan_model(data_context, seed, msg_stream);
  return *m;
}
stan::math::profile_map& get_stan_profile_data() {
  return earn_height_model_namespace::profiles__;
}
#endif