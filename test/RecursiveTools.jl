import PkgUtility.RecursiveTools as RT


@testset "RecursiveTools" verbose = true begin
    @testset "FT Test" begin
        # Int and FT matching : pass
        @test RT.FT_test(Float64[1.0, 2.0, 3.0], Float64) == true;
        @test RT.FT_test(Any[1, 2.0, 3], Float64) == true;
        @test RT.FT_test([1,2,3], Float64) == true;

        # FT not matching : fail
        @test RT.FT_test(Float32[1.0f0, 2.0f0, 3.0f0], Float64) == false;
        @test RT.FT_test(Any[1.0f0, 2.0, 3], Float64) == false;
        @test RT.FT_test([1.0f0, 2.0, 3.0], Float64) == true;

        # Other types : pass
        @test RT.FT_test(x -> x^2, Float64) == true;
        @test RT.FT_test(Module(), Float64) == true;
        @test RT.FT_test(:x, Float64) == true;
        @test RT.FT_test("x", Float64) == true;

        # case of struct
        struct SA
            a
            b
        end;
        sa_1 = SA(1, 2.0);
        sa_2 = SA(1.0f0, 2.0);
        @test RT.FT_test(sa_1, Float64) == true;
        @test RT.FT_test(sa_2, Float64) == false;

        # case of unspecified types
        @test RT.FT_test(Pair(1, 2.0), Float64) == true;
        @test RT.FT_test(Pair(1f0, 2.0), Float64) == false;
    end;

    @testset "NaN Test" begin
        # Int and FT matrching : pass
        @test RT.NaN_test([1, 2, 3]) == true;
        @test RT.NaN_test([1.0, 2.0, NaN]) == false;

        # Other types : pass
        @test RT.NaN_test(x -> x^2) == true;
        @test RT.NaN_test(Module()) == true;
        @test RT.NaN_test(:x) == true;
        @test RT.NaN_test("x") == true;

        # case of struct
        struct SB
            a
            b
        end;
        sb_1 = SB(1, 2.0);
        sb_2 = SB(1.0, NaN);
        @test RT.NaN_test(sb_1) == true;
        @test RT.NaN_test(sb_2) == false;

        # case of unspecified types
        @test RT.NaN_test(Pair(1, NaN)) == false;
        @test RT.NaN_test(Pair(1.0, 2.0)) == true;
    end;

    @testset "Compare Struct" begin
        struct SC
            a::Number
            b::Vector
            c::String
        end;
        sc_1 = SC(1.0, [1.0, 2.0, 3.0], "test");
        sc_2 = SC(1.0, [1.0, 2.0, 3.0], "test");
        sc_3 = SC(1.0, [1.0, 2.0, 4.0], "test");
        sc_4 = SC(1.0000001, [1.0, 2.0, 3.0], "test");
        sc_5 = SC(1.0, [1.0, 2.0, 3.0], "test2");
        @test RT.compare_struct!(sc_1, sc_2; show_diff_msg = true) == 0;
        @test RT.compare_struct!(sc_1, sc_3; show_diff_msg = true) == 1;
        @test RT.compare_struct!(sc_1, sc_4; show_diff_msg = true) == 1;
        @test RT.compare_struct!(sc_1, sc_5; show_diff_msg = true) == 1;
        @test RT.compare_struct!(sc_3, sc_5; show_diff_msg = true) == 2;
    end;

    @testset "Sync Struct" begin
        mutable struct SD
            a::Number
            b::Vector
            c::String
        end;
        sd_1 = SD(1.0, [1.0, 2.0, 3.0], "test");
        sd_2 = SD(2.0, [4.0, 5.0, 6.0], "test2");
        sd_3 = SD(3.0, [4.0, 5.0, 6.0], "test3");
        RT.sync_struct!(sd_1, sd_2);
        @test RT.compare_struct!(sd_1, sd_2; show_diff_msg = true) == 0;
        RT.sync_struct!(sd_3, sd_1);
        @test RT.compare_struct!(sd_1, sd_2; show_diff_msg = true) == 3;
    end;
end;
