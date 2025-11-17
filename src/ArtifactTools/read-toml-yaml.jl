"""

    read_library(filename::String)

Read an Artifact library file in either `TOML` or `YAML` format, given
- `filename` File name of the library file

"""
function read_library(filename::String)
    # if toml file
    if endswith(lowercase(filename), ".toml")
        return TOML.parsefile(filename)
    end;

    # if yaml file
    if endswith(lowercase(filename), "yml") || endswith(lowercase(filename), ".yaml")
        return YAML.load_file(filename)
    end;

    return error("Unsupported file format: $filename")
end;
