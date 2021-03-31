# API
```@meta
CurrentModule = PkgUtility
```




## Artifacts

```@docs
deploy_artifact
deploy_artifact(art_toml::String, art_name::String, art_locf::String,
    art_file::Array{String,1}, art_tarf::String, art_urls::Array{String,1};
    new_file::Array{String,1} = art_file)
deploy_artifact(art_toml::String, art_name::String, art_locf::String,
    art_tarf::String, art_urls::Array{String,1})
predownload_artifact
predownload_artifact(art_name::String, artifact_toml::String)
```




## Date
```@docs
month_days
month_ind
parse_timestamp
parse_timestamp(time_stamp::Union{Int,String}; in_format::String="YYYYMMDD",
    out_format::String="DOY")
parse_timestamp(year::Int, doy::Int, sep::String="")
```




## Display

```@docs
pretty_display
pretty_display(dict::Pair, max_len::Int, spaces = "    ")
pretty_display(dicts::Union{Array{Pair{String,String},1},
    Array{Pair{String,Any},1}, Array{Pair{Any,String},1},
    Array{Pair{Any,Any},1}}, spaces::String = "    ")
```




## Math

### Integral function

```@docs
numerical∫
```

### Quadratic solver

```@docs
lower_quadratic
upper_quadratic
```

### Statistics extensions

```@docs
mae
mape
mase
nanmax
nanmean
nanmedian
nanmin
nanstd
rmse
```




## NetCDF extensions

```@docs
ncread
```




## Recursive test

```@docs
FT_test
NaN_test
```
