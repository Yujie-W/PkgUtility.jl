using Distributed
import PkgUtility.DistributedTools as DT


@testset "DistributedTools" verbose = true begin
    @testset "Add Processors" begin
        DT.dynamic_workers!(2);
        @test length(workers()) == 2;
        DT.dynamic_workers!(Sys.CPU_THREADS);
        @test length(workers()) == Sys.CPU_THREADS;
        DT.dynamic_workers!(Sys.CPU_THREADS + 2);
        @test length(workers()) == Sys.CPU_THREADS;
    end;

    @testset "Remove Processors" begin
        DT.dynamic_workers!(1);
        @test length(workers()) == 1;
        DT.dynamic_workers!(0);
        @test length(workers()) == 1;
    end;
end;
