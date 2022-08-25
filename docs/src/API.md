# API
```@meta
CurrentModule = PkgUtility
```


## Artifacts

```@docs
deploy_artifact!
deploy_artifact!(art_toml::String, art_name::String, art_locf::String, art_file::Vector{String}, art_tarf::String, art_urls::Vector{String}; new_file::Vector{String} = art_file)
deploy_artifact!(art_toml::String, art_name::String, art_locf::String, art_tarf::String, art_urls::Vector{String})
```


## Date
```@docs
parse_timestamp
parse_timestamp(time_stamp::Union{Int,String}; in_format::String="YYYYMMDD", out_format::String="DOY")
parse_timestamp(year::Int, doy::Int, sep::String="")
month_days
month_ind
terror
tinfo
twarn
```


## Display

```@docs
pretty_display!
pretty_display!(dict::Pair, max_len::Int, spaces="    ")
pretty_display!(dicts::Union{Vector{Pair{String,String}}, Vector{Pair{String,Any}}, Vector{Pair{Any,String}}, Vector{Pair{Any,Any}}}, spaces::String="    ")
```


## IO

### CSV

```@docs
read_csv
read_csv(file::String; skiprows::Int = 0)
save_csv!
save_csv!(df::DataFrame, file::String)
save_csv!(file::String, data::Vector, var_names::Vector{String}; per_row::Bool=true)
save_csv!(file::String, data::Vector; per_row::Bool=true)
```

### DataFrame
```@docs
dataframe
dataframe()
dataframe(v_data::Vector, v_name::Vector{String})
```

### Email

```@docs
send_email!
send_email!(subject::String, from_email::String, to_email::String, body::String)
```


## Math

### Integral

```@docs
numerical∫
numerical∫(f::Array{Float64,1}, Δx::Array{Float64,1})
numerical∫(f::Array{Float64,1}, Δx::Float64)
numerical∫(f::Function, x_min::Float64, x_max::Float64, n::Int)
numerical∫(f::Function, x_min::Float64, x_max::Float64, x_tol::Float64=sqrt(eps(Float64)), y_tol::Float64=sqrt(eps(Float64)))
```

### Quadratic solver

```@docs
lower_quadratic
upper_quadratic
```

### Statistics extensions

```@docs
nanmax
nanmean
nanmedian
nanmin
nanpercentile
nanstd
mae
mape
mase
rmse
```


## Recursive test

```@docs
FT_test
FT_test(para::Array, Float64)
FT_test(para::Number, Float64)
FT_test(para::Union{Function,Module,Symbol})
FT_test(para::Any, Float64)
NaN_test
NaN_test(para::Array)
NaN_test(para::Number)
NaN_test(para::Union{Function,Module,Symbol})
NaN_test(para::Any)
```
