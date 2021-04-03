module PkgUtility

using CLIMAParameters
using CLIMAParameters: AbstractEarthParameterSet, avogad, gas_constant,
            h_Planck, k_Boltzmann, light_speed
using CLIMAParameters.Planet: LH_v0, MSLP, R_v, T_freeze, T_triple, cp_d, cp_l,
            cp_v, grav, molmass_dryair, molmass_water, press_triple,
            ρ_cloud_liq
using CLIMAParameters.SubgridScale: von_karman_const
using CSV: File, write
using DataFrames: DataFrame
using Dates: Date, DateTime, format, isleapyear, now
using DocStringExtensions: METHODLIST
using NCDatasets: Dataset, defDim, defVar
using Pkg.Artifacts: archive_artifact, artifact_exists, artifact_hash,
            artifact_meta, artifact_path, bind_artifact!, create_artifact,
            download_artifact
using Pkg.PlatformEngines: unpack
using Statistics: mean, median, std




# global constants
const MDAYS_LEAP  = [0,31,60,91,121,152,182,213,244,274,305,335,366];
const MDAYS       = [0,31,59,90,120,151,181,212,243,273,304,334,365];
const NDAYS_LEAP  = [31,29,31,30,31,30,31,31,30,31,30,31];
const NDAYS       = [31,28,31,30,31,30,31,31,30,31,30,31];
const TIME_FORMAT = ["YYYYMMDD", "YYYYMMDDhh", "YYYYMMDDhhmm",
                     "YYYYMMDDhhmmss"];
const TIME_OUTPUT = ["DATE", "DATETIME", "DOY", "FDOY"];




# export public functions --- artifact
export deploy_artifact, predownload_artifact

# export public functions --- date
export doy_to_int, int_to_doy, month_days, month_ind, parse_timestamp, terror,
            tinfo, twarn

# export public functions --- display
export pretty_display

# export public functions --- io
export read_csv, read_nc, save_csv!, save_nc!, send_email!

# export public functions --- math
export lower_quadratic, mae, mape, mase, nanmax, nanmean, nanmedian, nanmin,
            nanstd, numerical∫, rmse, upper_quadratic

# export public functions --- test
export FT_test, NaN_test




include("artifact/deploy.jl"  )
include("artifact/download.jl")

include("date/doy.jl"  )
include("date/tinfo.jl")

include("display/recursive.jl")

include("io/csv.jl"  )
include("io/email.jl")
include("io/nc.jl"   )

include("land/clima.jl")

include("math/integral.jl"  )
include("math/quadratic.jl" )
include("math/statistics.jl")

include("test/recursive.jl")

include("deprecated.jl")




end