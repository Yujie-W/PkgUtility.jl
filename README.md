# PkgUtility.jl


<!-- Links and shortcuts -->
[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://Yujie-W.github.io/PkgUtility.jl/dev/

[rel-img]: https://img.shields.io/badge/docs-stable-blue.svg
[rel-url]: https://Yujie-W.github.io/PkgUtility.jl/stable/

[st-img]: https://github.com/Yujie-W/PkgUtility.jl/workflows/JuliaStable/badge.svg?branch=main
[st-url]: https://github.com/Yujie-W/PkgUtility.jl/actions?query=branch%3A"main"++workflow%3A"JuliaStable"

[cov-img]: https://codecov.io/gh/Yujie-W/PkgUtility.jl/branch/main/graph/badge.svg
[cov-url]: https://codecov.io/gh/Yujie-W/PkgUtility.jl

[`PkgUtility.jl`][ju-url] includes a collection of utility functions used for Emerald Land model. The module used to be a sub-module of the under-developing Emerald Land model, and reusing the functions is more or less inconvenient as one would need to import the entire land model to use a very small tool. Therefore, I tease apart the functions that require minimum dependencies and move them to a new package. There are a number of submodules (and utility functions) for different purposes, and they are listed here in an alphabetical order. For example, the use cases below
- ArtifactTools: to read and write the database for GriddingMachine
- DistributedTools: to allocate cores dynamically based on the number of CPU cores
- EarthGeometry: to compute the sun and viewer angles to use with remote sensing
- MathTools: to compute the statistics omitting nans and find solutions and maximum
- PhysicalChemistry: to compute the physical chemistry properties of a number of trace gas and liquid
- PrettyDisplay: to display the information in a blocked manner
- RecursiveTools: to compare and sync struct recursively
- TerminalInputs: to force users inputting numbers, bools, etc
- TimeParser: to convert time string to various formats
- UniversalConstants: to provide universal constants and unit conversion

Note that support to Netcdf has been moved to [`NetcdfIO.jl`](https://github.com/Yujie-W/NetcdfIO.jl) since version v0.1.14. Please refer to the [documentation][dev-url] for more details...

| Documentation                                   | CI Status             | Code Coverage           |
|:------------------------------------------------|:----------------------|:------------------------|
| [![][dev-img]][dev-url] [![][rel-img]][rel-url] | [![][st-img]][st-url] | [![][cov-img]][cov-url] |
