using Pkg.Artifacts
using PkgUtility
using Test




# function and struct used to test
function f(x)
    x^2
end

struct TestStruct
    a::Any
    b::Any
end




@testset "PkgUtility --- Artifact" begin
    # deploy an artifact
    mkdir("temp");
    cp("example.toml", "temp/test_1.txt"; force=true);
    cp("example.toml", "temp/test_2.txt"; force=true);
    deploy_artifact("temp/TempArtifacts.toml",
                    "example_artifact",
                    "$(pwd())/temp",
                    "$(pwd())",
                    ["url_1", "url_2"]);
    deploy_artifact("temp/TempArtifacts.toml",
                    "example_artifact",
                    "$(pwd())/temp",
                    ["test_1.txt", "test_2.txt"],
                    "$(pwd())",
                    ["url_1", "url_2"]);

    # remove temp files
    meta = artifact_meta("example_artifact", "temp/TempArtifacts.toml");
    hash = meta["git-tree-sha1"];
    rm("$(homedir())/.julia/artifacts/$(hash)"; recursive=true);
    rm("temp"; recursive=true);
    rm("example_artifact.tar.gz");
    @test true;

    # predownload the artifact directly from the given URL
    predownload_artifact("CI_PFT_2X_1Y_V1", "example.toml");
    @test true;
end




println();
@testset "PkgUtility --- Date" begin
    @test parse_date(2000, 100) == "20000409";
    @test parse_date(2001, 100) == "20010410";
    @test int_to_doy("20000401") == 92;
    @test int_to_doy("20010401") == 91;
end




println();
@testset "PkgUtility --- Display" begin
    xxx = [
        "a"    => "a",
        "asa"  => "asdasda",
        "haha" => [
                   "a"    => "a",
                   "asa"  => "asdasda",
                   "haha" => [
                              1   => "a",
                              "a" => "asdasda",
                             ],
                  ],
    ];
    pretty_display(xxx);
    @test true;
end




println();
@testset "PkgUtility --- Math" begin
    # test integral function
    numerical∫(rand(5), rand(5));
    @info "Expecting dimension mismatch warning here...";
    numerical∫(rand(5), rand(6));
    numerical∫(rand(5), 0.1);
    @test true;

    # test quadratic solvers
    for FT in [Float32, Float64]
        @test lower_quadratic(FT( 1), FT(-3), FT( 2)) == FT(1);
        @test lower_quadratic(FT(-1), FT( 3), FT(-2)) == FT(1);
        @test isnan(lower_quadratic(FT( 1), FT(-3), FT(10)));
        @test upper_quadratic(FT( 1), FT(-3), FT( 2)) == FT(2);
        @test upper_quadratic(FT(-1), FT( 3), FT(-2)) == FT(2);
        @test isnan(upper_quadratic(FT( 1), FT(-3), FT(10)));
    end

    # test statistics
    xx = rand(10); xx[1]=NaN;
    yy = rand(10);
    nanmax(xx);
    nanmean(xx);
    nanmin(xx);
    nanstd(xx);
    mae(xx, yy);
    mape(xx, yy);
    mase(xx, yy);
    rmse(xx, yy);
    @test true;
end




println();
@testset "PkgUtility --- NetCDF" begin
    # test the ncread
    path = artifact_path(artifact_hash("CI_PFT_2X_1Y_V1", "example.toml"));
    file = path * "/CI_PFT_2X_1Y_V1.nc";
    data = ncread(Float32, file, "clump");
    @test true;
end




println();
@testset "PkgUtility --- FT test" begin
    for FT in [Float32, Float64]
        sa = TestStruct(ones(FT,5), 2);
        @test FT_test(ones(FT,5), FT);
        @test FT_test(f, FT);
        @test FT_test(Test, FT);
        @test FT_test(FT, FT);
        @test FT_test(1, FT);
        @test FT_test(FT(1), FT);
        @test FT_test("a", FT);
        @test FT_test(sa, FT);
    end
    @test FT_test([1f0,2f0], Float64) == false;
    @test FT_test([[1,2],2f0], Float64) == false;
end




println();
@testset "PkgUtility --- NaN test" begin
    for FT in [Float32, Float64]
        sa = TestStruct(ones(FT,5), 2);
        sb = TestStruct(ones(FT,5), NaN);
        @test NaN_test(ones(FT,5));
        @test NaN_test(f);
        @test NaN_test(Test);
        @test NaN_test(FT);
        @test NaN_test(1);
        @test NaN_test("a");
        @test NaN_test(sa);
        @test NaN_test(NaN) == false;
        @test NaN_test([1,2,NaN]) == false;
        @test NaN_test([[1,2,NaN], 2]) == false;
        @test NaN_test(sb) == false;
    end
end




println();
@testset "PkgUtility --- Deprecation warnings" begin
    # deprecated function
    @info "Expecting deprecation warnings here";
    @test doy_to_int(2001, 100) == "20010410";
end
