module PkgUtility

using Dates
using NCDatasets
using Pkg.Artifacts
using Pkg.PlatformEngines
using Statistics




# global constants
const MDAYS_LEAP = [0,31,60,91,121,152,182,213,244,274,305,335,366];
const MDAYS      = [0,31,59,90,120,151,181,212,243,273,304,334,365];
const NDAYS_LEAP = [31,29,31,30,31,30,31,31,30,31,30,31];
const NDAYS      = [31,28,31,30,31,30,31,31,30,31,30,31];




# export public functions --- artifact
export deploy_artifact,
       predownload_artifact

# export public functions --- date
export MDAYS,
       MDAYS_LEAP,
       NDAYS,
       NDAYS_LEAP,
       parse_date,
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

include("deprecated.jl")




end