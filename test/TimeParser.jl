using Dates
import EmeraldUtilities.TimeParser as TP


@testset "TimeParser" begin
    @testset "Which Month" begin
        @test TP.which_month(2019, 59) == 2;
        @test TP.which_month(2019, 60) == 3;
        @test TP.which_month(2020, 60) == 2;
    end;

    @testset "Month DOYs" begin
        @test TP.month_doys(2019,1) == 1:31;
        @test TP.month_doys(2019,2) == 32:59;
        @test TP.month_doys(2020,2) == 32:60;
    end;

    @testset "Parse Timestamp" begin
        @test TP.parse_timestamp("20230315", "YYYYMMDD", "DATE") == Date(2023,3,15);
        @test TP.parse_timestamp("202303151230", "YYYYMMDDhhmm", "DOY") == 74;
        @test TP.parse_timestamp("20230315123045", "YYYYMMDDhhmmss", "FDOY") ≈ 74.52135416666667;
        @test TP.parse_timestamp("20230315123045.123", "YYYYMMDDhhmmss.mmm", "DATETIME") == DateTime(2023,3,15,12,30,45,123);
    end;
end;
