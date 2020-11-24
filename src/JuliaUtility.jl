module JuliaUtility

using Pkg.Artifacts




# export public functions --- artifact
export predownload_artifact

# export public functions --- display
export pretty_display

# export public functions --- test
export FT_test,
       NaN_test




include("artifact/download.jl")

include("display/recursive.jl")

include("test/recursive.jl")




end