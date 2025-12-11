import PkgUtility.MathTools as MT


@testset "MathTools" verbose = true begin
    @testset "Resample Vector" begin
        reso_ins = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        reso_outs = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        years = [2021, 2020];
        len_resamples = [];
        len_expected = [];
        for y in years
            len_ins = y == 2021 ? [365 * 24, 365, 53, 46, 12, 1] : [366 * 24, 366, 53, 46, 12, 1];
            for (reso_in, len_in) in zip(reso_ins, len_ins)
                data_raw = rand(len_in);
                for i_reso in eachindex(reso_outs)
                    reso_out = reso_outs[i_reso];
                    resampled = MT.resample(data_raw, reso_in, reso_out, y);
                    @test length(resampled) == len_ins[i_reso];
                end;
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
                for i_reso in eachindex(reso_outs)
                    reso_out = reso_outs[i_reso];
                    resampled = MT.resample(data_raw, reso_in, reso_out, y);
                    @test  size(resampled,3) == len_ins[i_reso];
                end;
            end;
        end;
    end;

    @testset "Auto Reso Detection" begin
        resos = ["1H", "1D", "7D", "8D", "1M", "1Y"];
        lengs = [[365 * 24, 365, 53, 46, 12, 1], [366 * 24, 366, 53, 46, 12, 1]];
        years = [2021, 2020];
        for i_year in eachindex(years)
            y = years[i_year];
            lens = lengs[i_year];
            for len in lens
                data1 = rand(len);
                data3 = rand(2,3,len);
                for i_reso in eachindex(resos)
                    reso = resos[i_reso];
                    data_resampled_1 = MT.resample(data1, reso, y);
                    data_resampled_3 = MT.resample(data3, reso, y);
                    @test length(data_resampled_1) == lens[i_reso];
                    @test size(data_resampled_3,3) == lens[i_reso];
                end;
            end;
        end;
    end;
end;
