using OrderedCollections: OrderedDict
import PkgUtility.ArtifactTools as AT


@testset "ArtifactTools" verbose = true begin
    @testset "Save the library" begin
        normal_dict = Dict(
            "ExampleArtifact" => Dict(
                "url" => "https://example.com/artifact.tar.gz",
                "hash" => "sha256:abcdef1234567890",
                "platforms" => ["x86_64-linux", "aarch64-linux"]
            ),
            "AnotherArtifact" => Dict(
                "url" => "https://example.com/another_artifact.tar.gz",
                "hash" => "sha256:1234567890abcdef",
                "platforms" => ["x86_64-windows", "x86_64-macos"]
            ),
        );
        ordered_dict = OrderedDict(
            "ExampleArtifact" => OrderedDict(
                "url" => "https://example.com/artifact.tar.gz",
                "hash" => "sha256:abcdef1234567890",
                "platforms" => ["x86_64-linux", "aarch64-linux"]
            ),
            "AnotherArtifact" => OrderedDict(
                "url" => "https://example.com/another_artifact.tar.gz",
                "hash" => "sha256:1234567890abcdef",
                "platforms" => ["x86_64-windows", "x86_64-macos"]
            ),
        );
        # save the files
        AT.save_library!("test_artifacts_11.toml", normal_dict); @test true;
        AT.save_library!(normal_dict, "test_artifacts_12.toml"); @test true;
        AT.save_library!("test_artifacts_21.yaml", ordered_dict); @test true;
        AT.save_library!(ordered_dict, "test_artifacts_22.yaml"); @test true;

        # try the case with error
        try
            AT.save_library!("test_artifacts.txt", normal_dict);
        catch e
            @test isa(e, ErrorException);
        end;
    end;

    @testset "Read the library" begin
        # read the files and make sure they are the same
        lib1 = AT.read_library("test_artifacts_11.toml"); @test isa(lib1, Dict); @test true;
        lib2 = AT.read_library("test_artifacts_12.toml"); @test isa(lib2, Dict); @test true;
        lib3 = AT.read_library("test_artifacts_21.yaml"); @test isa(lib3, Dict); @test true;
        lib4 = AT.read_library("test_artifacts_22.yaml"); @test isa(lib4, Dict); @test true;
        @test lib1 == lib2 == lib3 == lib4;

        # try the case with error
        try
            AT.read_library("test_artifacts.txt");
        catch e
            @test isa(e, ErrorException);
        end;

        # remove the test files
        rm("test_artifacts_11.toml"; force = true);
        rm("test_artifacts_12.toml"; force = true);
        rm("test_artifacts_21.yaml"; force = true);
        rm("test_artifacts_22.yaml"; force = true);
    end;
end;
