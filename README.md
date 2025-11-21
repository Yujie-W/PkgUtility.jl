# EmeraldUtilities.jl


<!-- Links and shortcuts -->
[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://silicormosia.github.io/EmeraldUtilities.jl/dev/

[rel-img]: https://img.shields.io/badge/docs-stable-blue.svg
[rel-url]: https://silicormosia.github.io/EmeraldUtilities.jl/stable/

[st-img]: https://github.com/silicormosia/EmeraldUtilities.jl/workflows/JuliaStable/badge.svg?branch=main
[st-url]: https://github.com/silicormosia/EmeraldUtilities.jl/actions?query=branch%3A"main"++workflow%3A"JuliaStable"

[cov-img]: https://codecov.io/gh/silicormosia/EmeraldUtilities.jl/branch/main/graph/badge.svg
[cov-url]: https://codecov.io/gh/silicormosia/EmeraldUtilities.jl


A collection of utility functions used for Emerald Land model. The module used to be a sub-module of the under-developing Emerald Land model, and reusing the functions is more or less inconvenient as one would need to import the entire land model to use a very small tool. Therefore, I tease apart the functions that require minimum dependencies and move them to a new package. There are a number of submodules (and utility functions) for different purposes, and they are listed here in an alphabetical order. For example, the use cases below
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

Please refer to the [documentation](https://silicormosia.github.io/EmeraldUtilities.jl/) for more details...

| Documentation                                   | CI Status             | Code Coverage           |
|:------------------------------------------------|:----------------------|:------------------------|
| [![][dev-img]][dev-url] [![][rel-img]][rel-url] | [![][st-img]][st-url] | [![][cov-img]][cov-url] |
