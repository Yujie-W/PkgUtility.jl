module PkgUtility


# submodules
include("ArtifactTools/ArtifactTools.jl");
include("DistributedTools/DistributedTools.jl");
include("PrettyDisplay/PrettyDisplay.jl");
include("RecursiveTools/RecursiveTools.jl");
include("TerminalInputs/TerminalInputs.jl");
include("TimeParser/TimeParser.jl");
include("UniversalConstants/UniversalConstants.jl");

# with internal dependencies
include("EarthGeometry/EarthGeometry.jl");
include("MathTools/MathTools.jl");
include("PhysicalChemistry/PhysicalChemistry.jl");


end; # module
