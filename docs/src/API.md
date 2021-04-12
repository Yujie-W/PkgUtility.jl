# API
```@meta
CurrentModule = PkgUtility
```




## Artifacts

```@docs
deploy_artifact!
deploy_artifact!(art_toml::String, art_name::String, art_locf::String,
    art_file::Vector{String}, art_tarf::String, art_urls::Vector{String};
    new_file::Vector{String} = art_file)
deploy_artifact!(art_toml::String, art_name::String, art_locf::String,
    art_tarf::String, art_urls::Vector{String})
predownload_artifact!
predownload_artifact!(art_name::String, artifact_toml::String)
```




## Date
```@docs
parse_timestamp
parse_timestamp(time_stamp::Union{Int,String}; in_format::String = "YYYYMMDD",
    out_format::String = "DOY")
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
pretty_display!(dict::Pair, max_len::Int, spaces = "    ")
pretty_display!(dicts::Union{Vector{Pair{String,String}},
    Vector{Pair{String,Any}}, Vector{Pair{Any,String}}, Vector{Pair{Any,Any}}},
    spaces::String = "    ")
```




## IO

### CSV

```@docs
read_csv
read_csv(file::String; skiprows::Int = 0)
save_csv!
save_csv!(df::DataFrame, file::String)
save_csv!(file::String, data::Vector, var_names::Vector{String};
    per_row::Bool=true)
save_csv!(file::String, data::Vector; per_row::Bool=true)
```

### Email

```@docs
send_email!
send_email!(subject::String, from_email::String, to_email::String,
    body::String)
```

### NetCDF

```@docs
read_nc
read_nc(file::String, var::String)
read_nc(Float64, file::String, var::String)
read_nc(file::String, var::String, indz::Int)
read_nc(Float64, file::String, var::String, indz::Int)
read_nc(file::String, var::String, indx::Int, indy::Int)
read_nc(Float64, file::String, var::String, indx::Int, indy::Int)
save_nc!
save_nc!(file::String, var_name::String, var_attr::Dict{String,String},
    var_data::Array{Float64,2}, atts_name::Vector{String},
    atts_attr::Vector{Dict{String,String}}, atts_data::Vector,
    notes::Dict{String,String})
save_nc!(file::String, var_name::String, var_attr::Dict{String,String},
    var_data::Array{Float64,2})
```




## Land Wrapper

```@docs
AVOGADRO
CP_D
CP_D_MOL
CP_L
CP_V
GAS_R
GRAVITY
H_PLANCK
K_BOLTZMANN
K_STEFAN
K_VON_KARMAN
LH_V0
LIGHT_SPEED
M_DRYAIR
M_H₂O
P_ATM
PRESS_TRIPLE
R_V
RT_25
T_0
T_25
T_TRIPLE
V_H₂O
YEAR_D
ρ_H₂O
ρg_MPa
```




## Math

### Integral

```@docs
numerical∫
numerical∫(f::Array{Float64,1}, Δx::Array{Float64,1})
numerical∫(f::Array{Float64,1}, Δx::Float64)
numerical∫(f::Function, x_min::Float64, x_max::Float64, n::Int)
numerical∫(f::Function, x_min::Float64, x_max::Float64, x_tol::Float64 =
    sqrt(eps(Float64)), y_tol::Float64 = sqrt(eps(Float64)))
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
