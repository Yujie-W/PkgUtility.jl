module PkgUtility

using Dates
using NCDatasets
using Pkg.Artifacts
using Pkg.PlatformEngines
using Statistics




# export public functions --- artifact
export deploy_artifact,
       predownload_artifact

# export public functions --- date
export doy_to_int,
       int_to_doy

# export public functions --- display
export pretty_display

# export public functions --- math
export lower_quadratic,
       mae,
       mape,
       mase,
       nanmax,
       nanmean,
       nanmin,
       nanstd,
       numerical∫,
       rmse,
       upper_quadratic

# export public functions --- netcdf
export ncread

# export public functions --- test
export FT_test,
       NaN_test




include("artifact/deploy.jl"  )
include("artifact/download.jl")

include("date/doy.jl")

include("display/recursive.jl")

include("math/integral.jl"  )
include("math/quadratic.jl" )
include("math/statistics.jl")

include("netcdf/ncread.jl")

include("test/recursive.jl")




end