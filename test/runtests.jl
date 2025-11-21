using EmeraldUtilities
using Test


@testset "EmeraldUtilities" verbose = true begin
    include("ArtifactTools.jl");
    include("DistributedTools.jl");
    include("MathTools.jl");
    include("PrettyDisplay.jl");
    include("RecursiveTools.jl");
    include("TimeParser.jl");
    include("UniversalConstants.jl");
end;
