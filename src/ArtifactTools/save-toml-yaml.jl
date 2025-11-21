"""

    save_library!(filename::String, data::Union{Dict, OrderedDict})
    save_library!(data::Union{Dict, OrderedDict}, filename::String)

Save a Dict as a TOML or YAML file, given
- `filename` File name of the library file
- `data` Data to be saved

"""
function save_library! end;

save_library!(filename::String, data::Union{Dict, OrderedDict}) = (
    # if toml file
    if endswith(lowercase(filename), ".toml")
        open(filename, "w") do fileio
            TOML.print(fileio, data; sorted = true)
        end;

        return nothing
    end;

    # if yaml file
    if endswith(lowercase(filename), "yml") || endswith(lowercase(filename), ".yaml")
        YAML.write_file(filename, data)

        return nothing
    end;

    return error("Unsupported file format: $filename")
);

save_library!(data::Union{Dict, OrderedDict}, filename::String) = save_library!(filename, data);
