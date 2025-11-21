module MathTools

using Dates: daysinmonth, isleapyear
using DocStringExtensions: TYPEDEF, TYPEDFIELDS
using Statistics: mean, median, std
using StatsBase: percentile

using ..TimeParser: month_doys


include("array/expand-array.jl");
include("array/regrid.jl");
include("array/resample.jl");
include("array/truncate-array.jl");

include("gapfill-data.jl");
include("integration.jl");
include("interpolate-data.jl");
include("nanmath.jl");
include("quadratic.jl");

include("solver/methods.jl");
include("solver/tolerance.jl");
include("solver/find-peak.jl");
include("solver/find-zero.jl");


end; # module
