module DistributedTools

using Distributed: addprocs, rmprocs, workers


include("dynamic-workers.jl");


end; # module
