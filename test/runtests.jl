using Dates
using LazyArtifacts
using PkgUtility
using Test


# function and struct used to test
f(x) = x^2;

struct TestStruct
    a::Any
    b::Any
end


# Test the Package
@testset verbose = true "PkgUtility Test" begin
    @testset "Artifacts" begin
        # deploy an artifact per file
        mkdir("temp");
        cp("example.toml", "temp/test_1.txt"; force=true);
        cp("example.toml", "temp/test_2.txt"; force=true);
        PkgUtility.deploy_artifact!("temp/TempArtifacts.toml", "example_artifact", "$(pwd())/temp", "$(pwd())", ["url_1", "url_2"]);
        PkgUtility.deploy_artifact!("temp/TempArtifacts.toml", "example_artifact", "$(pwd())/temp", "$(pwd())", ["url_1", "url_2"]);
        @test true;

        # remove temp files
        meta = artifact_meta("example_artifact", "temp/TempArtifacts.toml");
        hash = meta["git-tree-sha1"];
        rm("$(homedir())/.julia/artifacts/$(hash)"; recursive=true);
        rm("temp"; recursive=true);
        rm("example_artifact.tar.gz");
        @test true;

        # deploy an artifact per folder
        mkdir("temp");
        cp("example.toml", "temp/test_1.txt"; force=true);
        cp("example.toml", "temp/test_2.txt"; force=true);
        PkgUtility.deploy_artifact!("temp/TempArtifacts.toml", "example_artifact", "$(pwd())/temp", ["test_1.txt", "test_2.txt"], "$(pwd())", ["url_1", "url_2"]);
        @test true;

        # remove temp files
        meta = artifact_meta("example_artifact", "temp/TempArtifacts.toml");
        hash = meta["git-tree-sha1"];
        rm("$(homedir())/.julia/artifacts/$(hash)"; recursive=true);
        rm("temp"; recursive=true);
        rm("example_artifact.tar.gz");
        @test true;
    end;

    @testset "DateTime" begin
        @test PkgUtility.parse_timestamp("20000401"; out_format="DOY") == 92;
        @test PkgUtility.parse_timestamp("20010401"; out_format="DOY") == 91;
        @test PkgUtility.parse_timestamp("20010401000000"; in_format="YYYYMMDDhhmmss", out_format="FDOY") == 91;
        @test PkgUtility.parse_timestamp("20010401"; out_format="DATE") == Date("2001-04-01");
        @test PkgUtility.parse_timestamp("20010401"; out_format="DATETIME") == DateTime("2001-04-01T00:00:00");
        @test PkgUtility.parse_timestamp(2000, 100) == 100;
        @test PkgUtility.parse_timestamp(2001, 100.1) == 100;
        @test PkgUtility.month_days(2019, 2) == 28;
        @test PkgUtility.month_days(2020, 2) == 29;
        @test PkgUtility.month_ind(2019, 60) == 3;
        @test PkgUtility.month_ind(2020, 60) == 2;

        # some time labeled information
        err_info = PkgUtility.terror("This is an error!");
        err_info = PkgUtility.tinfo("This is an info!");
        err_info = PkgUtility.twarn("This is a warning!");
        @test true;
    end;

    @testset "Display" begin
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
        @info PkgUtility.tinfo("Display the dict in a pretty way:");
        PkgUtility.pretty_display!(xxx);
        @test true;
    end;

    @testset "Numerics" begin
        for FT in [Float32, Float64]
            f(x) = x ^ 2;
            xx = rand(FT, 5);
            fx = f.(xx);
            x  = FT(0.1);
            for result in [
                        PkgUtility.numerical∫(fx, xx),
                        PkgUtility.numerical∫(fx, xx[1:4]),
                        PkgUtility.numerical∫(fx, x),
                        PkgUtility.numerical∫(f, FT(1), FT(3), 10),
                        PkgUtility.numerical∫(f, FT(1), FT(3)),
                        PkgUtility.lower_quadratic(FT(1), FT(3), FT(8)),
                        PkgUtility.lower_quadratic(FT(-1), FT(3), FT(8)),
                        PkgUtility.upper_quadratic(FT(1), FT(3), FT(8)),
                        PkgUtility.upper_quadratic(FT(-1), FT(3), FT(8))]
                @test true;
            end;
        end;
    end;

    @testset "Statistics" begin
        for FT in [Float32, Float64]
            xn = FT[1, 2, 3, 4, NaN];
            yn = FT[2, 2, 3, 4, NaN];
            for result in [
                        PkgUtility.nanmax(xn),
                        PkgUtility.nanmean(xn),
                        PkgUtility.nanmedian(xn),
                        PkgUtility.nanmin(xn),
                        PkgUtility.nanpercentile(xn, 90),
                        PkgUtility.nanstd(xn),
                        PkgUtility.mae(xn, yn),
                        PkgUtility.mape(xn, yn),
                        PkgUtility.mase(xn, yn),
                        PkgUtility.rmse(xn, yn)]
                @test true;
            end;
        end;
    end;

    @testset "NaN" begin
        for FT in [Float32, Float64]
            sa = TestStruct(ones(FT,5), 2);
            sb = TestStruct(ones(FT,5), NaN);
            @test PkgUtility.NaN_test(ones(FT,5));
            @test PkgUtility.NaN_test(f);
            @test PkgUtility.NaN_test(Test);
            @test PkgUtility.NaN_test(FT);
            @test PkgUtility.NaN_test(1);
            @test PkgUtility.NaN_test("a");
            @test PkgUtility.NaN_test(sa);
            @test !PkgUtility.NaN_test(NaN);
            @test !PkgUtility.NaN_test([1,2,NaN]);
            @test !PkgUtility.NaN_test([[1,2,NaN], 2]);
            @test !PkgUtility.NaN_test(sb);
        end;
    end;

    @testset "Type" begin
        for FT in [Float32, Float64]
            sa = TestStruct(ones(FT,5), 2);
            @test PkgUtility.FT_test(ones(FT,5), FT);
            @test PkgUtility.FT_test(f, FT);
            @test PkgUtility.FT_test(Test, FT);
            @test PkgUtility.FT_test(FT, FT);
            @test PkgUtility.FT_test(1, FT);
            @test PkgUtility.FT_test(FT(1), FT);
            @test PkgUtility.FT_test("a", FT);
            @test PkgUtility.FT_test(sa, FT);
        end;
        @test !PkgUtility.FT_test([1f0,2f0], Float64);
        @test !PkgUtility.FT_test([[1,2],2f0], Float64);
    end;
end;
