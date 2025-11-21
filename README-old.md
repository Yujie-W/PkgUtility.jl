# PkgUtility.jl

<!-- Links and shortcuts -->
[ju-url]: https://github.com/Yujie-W/PkgUtility.jl
[ju-api]: https://yujie-w.github.io/PkgUtility.jl/stable/API/
[cp-url]: https://github.com/CliMA/CLIMAParameters.jl

[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://Yujie-W.github.io/PkgUtility.jl/dev/

[rel-img]: https://img.shields.io/badge/docs-stable-blue.svg
[rel-url]: https://Yujie-W.github.io/PkgUtility.jl/stable/

[st-img]: https://github.com/Yujie-W/PkgUtility.jl/workflows/JuliaStable/badge.svg?branch=main
[st-url]: https://github.com/Yujie-W/PkgUtility.jl/actions?query=branch%3A"main"++workflow%3A"JuliaStable"

[min-img]: https://github.com/Yujie-W/PkgUtility.jl/workflows/Julia-1.6/badge.svg?branch=main
[min-url]: https://github.com/Yujie-W/PkgUtility.jl/actions?query=branch%3A"main"++workflow%3A"Julia-1.6"

[cov-img]: https://codecov.io/gh/Yujie-W/PkgUtility.jl/branch/main/graph/badge.svg
[cov-url]: https://codecov.io/gh/Yujie-W/PkgUtility.jl


## About

[`PkgUtility.jl`][ju-url] includes a collection of utility functions. Note that support to Netcdf has been moved to [`NetcdfIO.jl`](https://github.com/Yujie-W/NetcdfIO.jl) since version v0.1.14,
    support to CliMA Land constants has been moved to `EmeraldConstants.jl` since v0.3.0, support to statistical tools has been moved to `ResearchStatistics.jl`, and supports to CSV and DataFrames
    have been moved to `TextIO.jl`.

| Documentation                                   | CI Status             | Compatibility           | Code Coverage           |
|:------------------------------------------------|:----------------------|:------------------------|:------------------------|
| [![][dev-img]][dev-url] [![][rel-img]][rel-url] | [![][st-img]][st-url] | [![][min-img]][min-url] | [![][cov-img]][cov-url] |


## Installation
```julia
using Pkg;
Pkg.add("PkgUtility");
```


## API
See [`API`][ju-api] for more detailed information about how to use [`PkgUtility.jl`][ju-url].
