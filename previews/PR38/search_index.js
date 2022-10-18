var documenterSearchIndex = {"docs":
[{"location":"#PkgUtility.jl","page":"Home","title":"PkgUtility.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Utility functions for Julia.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg;\njulia> Pkg.add(\"PkgUtility\");","category":"page"},{"location":"API/#API","page":"API","title":"API","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"CurrentModule = PkgUtility","category":"page"},{"location":"API/#Artifacts","page":"API","title":"Artifacts","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"deploy_artifact!","category":"page"},{"location":"API/#PkgUtility.deploy_artifact!","page":"API","title":"PkgUtility.deploy_artifact!","text":"What deploy_artifact! function does are\n\ndetermine if the artifact already exists in the art_toml file\nif true, skip the deployment\nif false\ncopy the file(s) to ~/.julia/artifacts/ARTIFACT_SHA/\ncompress the artifact file(s) to a .tar.gz file\ncalculate the hash value of the compressed tar.gz file\nbind the artifact file to the .toml file\n\nMethod for this deployment is\n\ndeploy_artifact!(art_toml::String, art_name::String, art_locf::String, art_file::Vector{String}, art_tarf::String, art_urls::Vector{String}; new_file::Vector{String} = art_file)\n\nDeploy the artifact, given\n\nart_toml Artifact .toml file location\nart_name Artifact name identitfier\nart_locf Local folder that stores the source files\nart_file Vector of the source file names\nart_tarf Folder location to store the compressed .tar.gz file\nart_urls Vector of public urls, where the compressed files are to be uploaded (user need to upload the file manually)\nnew_file Optional. New file names of the copied files (same as art_file by default)\n\n\n\nExamples\n\n# deploy art_1.txt and art_2.txt as test_art artifact\ndeploy_artifact!(\"Artifacts.toml\", \"test_art\", \"./\", [\"art_1.txt\", \"art_2.txt], \"./\", [\"https://public.server.url\"]);\n\n# deploy art_1.txt and art_2.txt as test_art artifact with new names\ndeploy_artifact!(\"Artifacts.toml\", \"test_art\", \"./\", [\"art_1.txt\", \"art_2.txt], \"./\", [\"https://public.server.url\"]; new_files=[\"new_1.txt\", \"new_2.txt\"]);\n\nIn many cases, one might want to copy all the files in a folder to the target artifact, and iterate the file names is not convenient at all. Thus, a     readily usable method is provided for this purpose:\n\ndeploy_artifact!(art_toml::String, art_name::String, art_locf::String, art_tarf::String, art_urls::Vector{String})\n\nDeploy the artifact, given\n\nart_toml Artifact .toml file location\nart_name Artifact name identitfier\nart_locf Local folder that stores the source files (all files will be copied into the artifact)\nart_tarf Folder location to store the compressed .tar.gz file\nart_urls Vector of public urls, where the compressed files are to be uploaded (user need to upload the file manually)\n\n\n\nExamples\n\n# deploy all files in target folder\ndeploy_artifact!(\"Artifacts.toml\", \"test_art\", \"./folder\", \"./\", [\"https://public.server.url\"]);\n\n\n\n\n\n","category":"function"},{"location":"API/#DateTime","page":"API","title":"DateTime","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"parse_timestamp\nmonth_days\nmonth_ind\nterror\ntinfo\ntwarn","category":"page"},{"location":"API/#PkgUtility.parse_timestamp","page":"API","title":"PkgUtility.parse_timestamp","text":"parse_timestamp(timestamp::Union{Int,String}; in_format::String = \"YYYYMMDD\", out_format::String = \"DOY\")\nparse_timestamp(year::Int, doy::Int; out_format::String = \"DOY\")\nparse_timestamp(year::Int, doy::AbstractFloat; out_format::String = \"DOY\")\n\nConvert timestamp, given\n\ntimestamp Time stamp\nin_format Format of timestamp, default is YYYYMMDD\nout_format Output format, default is DOY\nyear Year (in this case, the function will convert year and day to timestamp first)\ndoy Day of year (typically 1-365, 1-366 for leap years)\n\nThe input format (string or integer) supports YYYYMMDD, YYYYMMDDhh, YYYYMMDDhhmm, and YYYYMMDDhhmmss, where the labels are\n\nYYYY Year number\nMM Month number\nDD Day number\nhh Hour number\nmm Minute number\nss second number\n\nThe supported outputs are\n\nDATE A Dates.Date type variable\nDATETIME A Dates.DateTime type variable\nDOY A day of year integer\nFDOY A day of year float\n\n\n\nExamples\n\ntime = parse_timestamp(20200130; in_format=\"YYYYMMDD\", out_format=\"FDOY\");\ntime = parse_timestamp(\"20200130\"; in_format=\"YYYYMMDD\", out_format=\"FDOY\");\ntime = parse_timestamp(2020, 100);\ntime = parse_timestamp(2020, 100.23435436);\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.month_days","page":"API","title":"PkgUtility.month_days","text":"month_days(year::Int, month::Int)\n\nReturn the number of days per month, given\n\nyear Year\nmonth Month\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.month_ind","page":"API","title":"PkgUtility.month_ind","text":"month_ind(year::Int, doy::Int)\nmonth_ind(year::Int, doy::AbstractFloat)\n\nReturn the month index, given\n\nyear Year\ndoy Day of year (typically 1-365, 1-366 for leap years)\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.terror","page":"API","title":"PkgUtility.terror","text":"terror(info::String)\n\nAdd a time tag to logging string, given\n\ninfo Infomation to display with @error\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.tinfo","page":"API","title":"PkgUtility.tinfo","text":"tinfo(info::String)\n\nAdd a time tag to logging string, given\n\ninfo Infomation to display with @info\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.twarn","page":"API","title":"PkgUtility.twarn","text":"twarn(info::String)\n\nAdd a time tag to logging string, given\n\ninfo Infomation to display with @warn\n\n\n\n\n\n","category":"function"},{"location":"API/#Display","page":"API","title":"Display","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"pretty_display!","category":"page"},{"location":"API/#PkgUtility.pretty_display!","page":"API","title":"PkgUtility.pretty_display!","text":"pretty_display!(pvec::Union{Vector{Pair{String,String}}, Vector{Pair{String,Any}}, Vector{Pair{Any,String}}, Vector{Pair{Any,Any}}}, spaces::String = \"    \")\n\nDisplay the pairs in a pretty way, given\n\npvec Vector of pairs to display\nspaces Leading spaces before displaying the pair key\n\n\n\nExamples\n\n_pairs = [\"A\" => \"b\", \"d\" => \"A\", \"rr\" => [\"ra\" => \"rB\", \"rD\" => \"ra\"]];\npretty_display!(_pairs);\npretty_display!(_pairs, \"  \");\n\n\n\n\n\n","category":"function"},{"location":"API/#Email","page":"API","title":"Email","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"send_email!","category":"page"},{"location":"API/#PkgUtility.send_email!","page":"API","title":"PkgUtility.send_email!","text":"send_email!(subject::String, from_email::String, to_email::String, body::String)\n\nSend out email, given\n\nsubject Email subject\nfrom_email The outgoing email address\nto_email Email address to send out\nbody Main body of the email\n\n\n\n\n\n","category":"function"},{"location":"API/#Recursive-tests","page":"API","title":"Recursive tests","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"FT_test\nNaN_test","category":"page"},{"location":"API/#PkgUtility.FT_test","page":"API","title":"PkgUtility.FT_test","text":"FT_test(para::Array, FT)\nFT_test(para::Number, FT)\nFT_test(para::Union{Function, Module, String, Symbol}, FT)\nFT_test(para::Any, FT)\n\nReturn true or false to determine if the FT is consistent, given\n\npara Parameter to run FT control\nFT Float type\n\nIf the testing variable is an array, the function will test if element type is float number:\n\nIf true, the function tests if the element type is the same as given FT\nIf false, the function tests each element recursively\n\nThe variable to test maybe a struct, but FT_test does not know the struct type name a priori. Thus, we try to read out the fields of the variable:\n\nIf succeeds, the function test the fields recursively\nIf fails, then do nothing\n\n\n\nExample\n\nstruct SA\n    a\n    b\nend\nsa = SA(1, 2.0);\n\nft_1 = FT_test([1, 2, 3], Float64);\nft_2 = FT_test(Any[1, 1.0f0, 1.0e0], Float64);\nft_3 = FT_test([1, 2.0, \"a\"], Float64);\nft_4 = FT_test(sa, Float64);\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.NaN_test","page":"API","title":"PkgUtility.NaN_test","text":"Like FT_test, same logic is used to test if all the elements within the tested variable are not NaN:\n\nNaN_test(para::Array)\nNaN_test(para::Number)\nNaN_test(para::Union{Function, Module, String, Symbol})\nNaN_test(para::Any)\n\nTest if the variable is not NaN, given\n\npara Parameter to test\n\n\n\nExample\n\nstruct SA\n    a\n    b\nend\n\nnan_1 = NaN_test(SA(1,2));\nnan_2 = NaN_test(SA(1,NaN));\nnan_3 = NaN_test([1,2,NaN]);\nnan_4 = NaN_test([1,3,4]);\nnan_5 = NaN_test([1,2,\"a\"]);\n\n\n\n\n\n","category":"function"},{"location":"API/#Numerical-methods","page":"API","title":"Numerical methods","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"numerical∫\nlower_quadratic\nupper_quadratic","category":"page"},{"location":"API/#PkgUtility.numerical∫","page":"API","title":"PkgUtility.numerical∫","text":"numerical∫(f::Vector{FT}, Δx::Vector{FT}) where {FT<:AbstractFloat}\nnumerical∫(f::Vector{FT}, Δx::FT) where {FT<:AbstractFloat}\n\nReturn the intergal of given\n\nf f(x) for each x\nΔx Δx for x\nnumerical∫(f::Function, xmin::FT, xmax::FT, n::Int) where {FT<:AbstractFloat}   numerical∫(f::Function, xmin::FT, xmax::FT, xtol::FT = sqrt(eps(FT)), ytol::FT = sqrt(eps(FT))) where {FT<:AbstractFloat}\n\nReturn the integral of given\n\nf A function\nx_min Minimum limit of x\nx_max Maximum limit of x\nn Number of points in the x range (evenly stepped)\nx_tol Tolerance of Δx (x/N)\ny_tol Tolerance of the integral solution\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.lower_quadratic","page":"API","title":"PkgUtility.lower_quadratic","text":"lower_quadratic(a::FT, b::FT, c::FT) where {FT<:AbstractFloat}\n\nReturn the lower quadratic solution or NaN, given\n\na Parameter in a*x^2 + b*x + c = 0\nb Parameter in a*x^2 + b*x + c = 0\nc Parameter in a*x^2 + b*x + c = 0\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.upper_quadratic","page":"API","title":"PkgUtility.upper_quadratic","text":"upper_quadratic(a::FT, b::FT, c::FT) where {FT<:AbstractFloat}\n\nReturn the upper quadratic solution or NaN, given\n\na Parameter in a*x^2 + b*x + c = 0\nb Parameter in a*x^2 + b*x + c = 0\nc Parameter in a*x^2 + b*x + c = 0\n\n\n\n\n\n","category":"function"},{"location":"API/#Statistics","page":"API","title":"Statistics","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"nanmax\nnanmean\nnanmedian\nnanmin\nnanpercentile\nnanstd\nmae\nmape\nmase\nrmse","category":"page"},{"location":"API/#PkgUtility.nanmax","page":"API","title":"PkgUtility.nanmax","text":"nanmax(x::Array)\n\nReturn the maximum of array ommiting the NaN, given\n\nx Array of numbers, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.nanmean","page":"API","title":"PkgUtility.nanmean","text":"nanmean(x::Array)\n\nReturn the mean of array by ommiting the NaN, given\n\nx Array of numbers, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.nanmedian","page":"API","title":"PkgUtility.nanmedian","text":"nanmedian(x::Array)\n\nReturn the median of array by ommiting the NaN, given\n\nx Array of numbers, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.nanmin","page":"API","title":"PkgUtility.nanmin","text":"nanmin(x::Array)\n\nReturn the maximum of array ommiting the NaN, given\n\nx Array of numbers, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.nanpercentile","page":"API","title":"PkgUtility.nanpercentile","text":"nanpercentile(x::Array, p::Number)\n\nReturn the percentile by excluding the NaN of given\n\nx Array of data\np Percentile in [%]\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.nanstd","page":"API","title":"PkgUtility.nanstd","text":"nanstd(x::Array)\n\nReturn the std of array by ommiting the NaN, given\n\nx Array of numbers, can be NaN\n\n```\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.mae","page":"API","title":"PkgUtility.mae","text":"mae(y::Array, pred::Array)\n\nReturn the mean absolute error by ommiting the NaN, given\n\ny Array of numbers, can be NaN\npred Array of predictions, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.mape","page":"API","title":"PkgUtility.mape","text":"mape(y::Array, pred::Array)\n\nReturn the mean absolute percentage error by ommiting the NaN, given\n\ny Array of numbers, can be NaN\npred Array of predictions, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.mase","page":"API","title":"PkgUtility.mase","text":"mase(y::Array, pred::Array)\n\nReturn the mean absolute standardized error by ommiting the NaN, given\n\ny Array of numbers, can be NaN\npred Array of predictions, can be NaN\n\n\n\n\n\n","category":"function"},{"location":"API/#PkgUtility.rmse","page":"API","title":"PkgUtility.rmse","text":"rmse(y::Array, pred::Array)\n\nReturn the root mean square error by ommiting the NaN, given\n\ny Array of numbers, can be NaN\npred Array of predictions, can be NaN\n\n\n\n\n\n","category":"function"}]
}
