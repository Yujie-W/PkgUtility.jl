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
        deploy_artifact!("temp/TempArtifacts.toml", "example_artifact", "$(pwd())/temp", "$(pwd())", ["url_1", "url_2"]);
        deploy_artifact!("temp/TempArtifacts.toml", "example_artifact", "$(pwd())/temp", "$(pwd())", ["url_1", "url_2"]);
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
        deploy_artifact!("temp/TempArtifacts.toml", "example_artifact", "$(pwd())/temp", ["test_1.txt", "test_2.txt"], "$(pwd())", ["url_1", "url_2"]);
        @test true;

        # remove temp files
        meta = artifact_meta("example_artifact", "temp/TempArtifacts.toml");
        hash = meta["git-tree-sha1"];
        rm("$(homedir())/.julia/artifacts/$(hash)"; recursive=true);
        rm("temp"; recursive=true);
        rm("example_artifact.tar.gz");
        @test true;
    end

    @testset "Date" begin
        @test parse_timestamp("20000401"; out_format="DOY") == 92;
        @test parse_timestamp("20010401"; out_format="DOY") == 91;
        @test parse_timestamp("20010401000000"; in_format="YYYYMMDDhhmmss", out_format="FDOY") == 91;
        @test parse_timestamp("20010401"; out_format="DATE") == Date("2001-04-01");
        @test parse_timestamp("20010401"; out_format="DATETIME") == DateTime("2001-04-01T00:00:00");
        @test parse_timestamp(2000, 100) == "20000409";
        @test parse_timestamp(2001, 100) == "20010410";
        @test month_days(2019, 2) == 28;
        @test month_days(2020, 2) == 29;
        @test month_ind(2019, 60) == 3;
        @test month_ind(2020, 60) == 2;

        # some time labeled information
        err_info = terror("This is an error!");
        err_info = tinfo("This is an info!");
        err_info = twarn("This is a warning!");
        @test true;
    end

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
        @info tinfo("Display the dict in a pretty way:");
        pretty_display!(xxx);
        @test true;
    end

    @testset "Math" begin
        # test integral function
        numerical∫(rand(5), rand(5));
        @info tinfo("Expecting dimension mismatch warning here...");
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
        nanmedian(xx);
        nanmin(xx);
        nanpercentile(xx, 50);
        nanstd(xx);
        mae(xx, yy);
        mape(xx, yy);
        mase(xx, yy);
        rmse(xx, yy);
        @test true;
    end

    @testset "IO" begin
        # test the dataframe
        df = dataframe();
        df = dataframe([rand(3), rand(3)], ["A","B"]);
        @test true;
    end

    @testset "NaN" begin
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

    @testset "Type" begin
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

    @testset "Deprecation" begin
        # deprecated function
        @info tinfo("Expecting deprecation warnings here");
        @test true;
    end
end
