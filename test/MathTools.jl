import PkgUtility.MathTools as MT


@testset "MathTools" verbose = true begin
    @testset "Resample Vector" begin
        reso_ins = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        reso_outs = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        len_ins = [365 * 24, 365, 52, 46, 12, 1];
        years = [2021, 2020];
        len_resamples = [];
        len_expected = [];
        for y in years
            len_ins = y == 2021 ? [365 * 24, 365, 53, 46, 12, 1] : [366 * 24, 366, 53, 46, 12, 1];
            for (reso_in, len_in) in zip(reso_ins, len_ins)
                data_raw = rand(len_in);
                for reso_out in reso_outs
                    resampled = MT.resample(data_raw, reso_in, reso_out, y);
                    push!(len_resamples, length(resampled));
                end;
                push!(len_expected, len_ins...);
            end;
        end;
        @test all(len_resamples .== len_expected);
    end;

    @testset "Resample 3D Array" begin
        reso_ins = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        reso_outs = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        len_ins = [365 * 24, 365, 52, 46, 12, 1];
        years = [2021, 2020];
        len_resamples = [];
        len_expected = [];
        for y in years
            len_ins = y == 2021 ? [365 * 24, 365, 53, 46, 12, 1] : [366 * 24, 366, 53, 46, 12, 1];
            for (reso_in, len_in) in zip(reso_ins, len_ins)
                data_raw = rand(2,3,len_in);
                for reso_out in reso_outs
                    resampled = MT.resample(data_raw, reso_in, reso_out, y);
                    push!(len_resamples, size(resampled,3));
                end;
                push!(len_expected, len_ins...);
            end;
        end;
        @test all(len_resamples .== len_expected);
    end;
end;
