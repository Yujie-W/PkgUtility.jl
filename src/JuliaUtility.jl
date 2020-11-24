module JuliaUtility

using Pkg.Artifacts




# export public functions --- test
export predownload_artifact

# export public functions --- test
export FT_test,
       NaN_test




include("artifact/download.jl")

include("test/recursive.jl")




end