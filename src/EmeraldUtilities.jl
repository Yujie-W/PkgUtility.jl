module EmeraldUtilities


# submodules
include("ArtifactTools/ArtifactTools.jl");
include("DistributedTools/DistributedTools.jl");
include("PrettyDisplay/PrettyDisplay.jl");
include("RecursiveTools/RecursiveTools.jl");
include("TimeParser/TimeParser.jl");
include("UniversalConstants/UniversalConstants.jl");

# with internal dependencies
include("EarthGeometry/EarthGeometry.jl");
include("MathTools/MathTools.jl");


end; # module
