module PkgUtility

using Dates
using Pkg.Artifacts
using Pkg.PlatformEngines




# export public functions --- artifact
export deploy_artifact,
       predownload_artifact

# export public functions --- date
export doy_to_int,
       int_to_doy

# export public functions --- display
export pretty_display

# export public functions --- test
export FT_test,
       NaN_test




include("artifact/deploy.jl"  )
include("artifact/download.jl")

include("date/doy.jl")

include("display/recursive.jl")

include("test/recursive.jl")




end