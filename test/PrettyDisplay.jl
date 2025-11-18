import EmeraldUtilities.PrettyDisplay as PD


@testset "PrettyDisplay" verbose = true begin
    @testset "Timed Info Block" begin
        PD.pretty_display!("This is an entire timed info message", "tinfo");
        PD.pretty_display!("This is the first line of a set of timed info messages", "tinfo_pre");
        PD.pretty_display!("This is the middle line of a set of timed info messages", "tinfo_mid");
        PD.pretty_display!("This is the last line of a set of timed info messages", "tinfo_end");
        @test true;
    end;

    @testset "Timed Warning Block" begin
        PD.pretty_display!("This is an entire timed warning message", "twarn");
        PD.pretty_display!("This is the first line of a set of timed warning messages", "twarn_pre");
        PD.pretty_display!("This is the middle line of a set of timed warning messages", "twarn_mid");
        PD.pretty_display!("This is the last line of a set of timed warning messages", "twarn_end");
        @test true;
    end;

    @testset "Timed Error Block" begin
        PD.pretty_display!("This is an entire timed error message", "terror");
        PD.pretty_display!("This is the first line of a set of timed error messages", "terror_pre");
        PD.pretty_display!("This is the middle line of a set of timed error messages", "terror_mid");
        PD.pretty_display!("This is the last line of a set of timed error messages", "terror_end");
        @test true;
    end;

    @testset "Vector of Pair" begin
        pvec = ["A" => "b", "d" => "A", "rr" => ["ra" => "rB", "rD" => "ra"]];
        PD.pretty_display!(pvec);
        @test true;
    end;
end;
