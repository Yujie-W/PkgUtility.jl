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
int_to_doy
month_days
month_ind
parse_date
```




## Display

```@docs
pretty_display
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
