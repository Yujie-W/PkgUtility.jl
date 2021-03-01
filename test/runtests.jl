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
    predownload_artifact("clumping_index_2X_1Y_PFT", "example.toml");
    @test true;
end




println();
@testset "PkgUtility --- Date" begin
    @test typeof(doy_to_int(2000, 100)) == String;
    @test typeof(int_to_doy("20000201")) == Int;
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
    for FT in [Float32, Float64]
        # test quadratic solvers
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
end




println();
@testset "PkgUtility --- NaN test" begin
    for FT in [Float32, Float64]
        sa = TestStruct(ones(FT,5), 2);
        @test NaN_test(ones(FT,5));
        @test NaN_test(f);
        @test NaN_test(Test);
        @test NaN_test(FT);
        @test NaN_test(1);
        @test NaN_test("a");
        @test NaN_test(sa);
    end
end
