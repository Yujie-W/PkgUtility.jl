using JuliaUtility
using Test




# function and struct used to test
function f(x)
    x^2
end

struct TestStruct
    a::Any
    b::Any
end




println("\nRecursive FT test");
@testset "JuliaUtility --- FT test" begin
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




println("\nRecursive NaN test");
@testset "JuliaUtility --- NaN test" begin
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
