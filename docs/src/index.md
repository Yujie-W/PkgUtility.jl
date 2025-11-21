# EmeraldUtilities.jl

A collection of utility functions used for Emerald Land model. The module used to be a sub-module of the under-developing Emerald Land model (not registered), and reusing the functions is more or less inconvenient as one would need to import the entire mega land model to use a very small tool. Therefore, I tease apart the functions that require minimum dependencies and move them to a new package. There are a number of submodules (and utility functions) for different purposes, and they are listed here in an alphabetical order.


## ArtifactTools

Read and write toml and yaml files to use with GriddingMachine (and other general purposes)
```@docs
EmeraldUtilities.ArtifactTools.read_library
EmeraldUtilities.ArtifactTools.save_library!
```


## DistributedTools

Add and remove processors dynamically based on the maximum number of CPU cores and the requested number of threads. For example, if the requested number of threads exceeds the maximum CPU count, the maximum CPU wound be used; if the requested number of threads is fewer than existing workers, the extra ones would be removed.
```@docs
EmeraldUtilities.DistributedTools.dynamic_workers!
```


## PrettyDisplay

Display the information within an `@info` block (or `@warn` or `@error`), showing the time of the operation as well
```@docs
EmeraldUtilities.PrettyDisplay.pretty_display!
```


## RecursiveTools

Test and floating number type or if containing nan within a variable (number, vector, structure, etc) in a recursive manner
```@docs
EmeraldUtilities.RecursiveTools.FT_test
EmeraldUtilities.RecursiveTools.NaN_test
```

Compare and synchronize a structure in a recursive manner
```@docs
EmeraldUtilities.RecursiveTools.compare_struct!
EmeraldUtilities.RecursiveTools.sync_struct!
```


## TimeParser

Identify the month index with a known doy-of-year, or the range of doy-of-year of a known month
```@docs
EmeraldUtilities.TimeParser.which_month
EmeraldUtilities.TimeParser.month_doys
```

Parse number and string to different formats
```@docs
EmeraldUtilities.TimeParser.parse_timestamp
```
