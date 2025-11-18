using EmeraldUtilities
using Test


@testset "EmeraldUtilities" verbose = true begin
    include("ArtifactTools.jl");
    include("DistributedTools.jl");
end;
