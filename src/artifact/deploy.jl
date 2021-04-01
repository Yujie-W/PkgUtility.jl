###############################################################################
#
# Function to deploy artifact
#
###############################################################################
"""
`PkgUtility` provides a convenient wrapper to deploy the artifact from a given
    list of files, for exmaple, `deploy_artifact` function is used to deploy
    the [`GirddingMachine`](https://github.com/CliMA/GriddingMachine.jl)
    artifacts.

$(METHODLIST)

"""
function deploy_artifact end




"""
What `deploy_artifact` function does are
- determine if the artifact already exists in the `art_toml` file
- if `true`, skip the deployment
- if `false`
  - copy the file(s) to `~/.julia/artifacts/ARTIFACT_SHA/`
  - compress the artifact file(s) to a `.tar.gz` file
  - calculate the hash value of the compressed `tar.gz` file
  - bind the artifact file to the `.toml` file

Method for this deployment is

    deploy_artifact(
                art_toml::String,
                art_name::String,
                art_locf::String,
                art_file::Vector{String},
                art_tarf::String,
                art_urls::Vector{String};
                new_file::Vector{String} = art_file)

Deploy the artifact, given
- `art_toml` Artifact `.toml` file location
- `art_name` Artifact name identitfier
- `art_locf` Local folder that stores the source files
- `art_file` Vector of the source file names
- `art_tarf` Folder location to store the compressed `.tar.gz` file
- `art_urls` Vector of public urls, where the compressed files are to be
    uploaded (user need to upload the file manually)
- `new_file` Optional. New file names of the copied files (same as `art_file`
    by default)

---
Examples
```julia
# deploy art_1.txt and art_2.txt as test_art artifact
deploy_artifact("Artifacts.toml", "test_art", "./", ["art_1.txt", "art_2.txt],
                "./", ["https://public.server.url"])
# deploy art_1.txt and art_2.txt as test_art artifact with new names
deploy_artifact("Artifacts.toml", "test_art", "./", ["art_1.txt", "art_2.txt],
                "./", ["https://public.server.url"];
                new_files=["new_1.txt", "new_2.txt"]);
```
"""
deploy_artifact(
            art_toml::String,
            art_name::String,
            art_locf::String,
            art_file::Vector{String},
            art_tarf::String,
            art_urls::Vector{String};
            new_file::Vector{String} = art_file) =
(
    # querry whether the artifact exists
    _art_hash = artifact_hash(art_name, art_toml);

    # if artifact exists already skip
    if !isnothing(_art_hash) && artifact_exists(_art_hash)
        @info tinfo("Artifact $(art_name) already exists, skip it");
        return nothing;
    end;

    # create artifact
    @info tinfo("Artifact $(art_name) not found, deploy it now...");
    @info tinfo("Copying files into artifact folder...");
    _art_hash = create_artifact() do artifact_dir
        for i in eachindex(art_file)
            _in   = art_file[i];
            _out  = new_file[i];
            _path = joinpath(art_locf, _in);
            @info tinfo("Copying file $(_in)...");
            cp(_path, joinpath(artifact_dir, _out));
        end;
    end;

    # compress artifact
    @info tinfo("Compressing artifact $(art_name)...");
    _tar_loc  = "$(art_tarf)/$(art_name).tar.gz";
    _tar_hash = archive_artifact(_art_hash, _tar_loc);

    # bind artifact to download information
    _download_info = [("$(_url)/$(art_name).tar.gz", _tar_hash)
                      for _url in art_urls];
    bind_artifact!(art_toml, art_name, _art_hash; download_info=_download_info,
                   lazy=true, force=true);

    return nothing;
)




"""
In many cases, one might want to copy all the files in a folder to the target
    artifact, and iterate the file names is not convenient at all. Thus,
    a readily usable method is provided for this purpose:

    deploy_artifact(
                art_toml::String,
                art_name::String,
                art_locf::String,
                art_tarf::String,
                art_urls::Vector{String})

Deploy the artifact, given
- `art_toml` Artifact `.toml` file location
- `art_name` Artifact name identitfier
- `art_locf` Local folder that stores the source files (all files will be
    copied into the artifact)
- `art_tarf` Folder location to store the compressed `.tar.gz` file
- `art_urls` Vector of public urls, where the compressed files are to be
    uploaded (user need to upload the file manually)

---
Examples
```julia
# deploy all files in target folder
deploy_artifact("Artifacts.toml", "test_art", "./folder", "./",
                ["https://public.server.url"])
```
"""
deploy_artifact(
            art_toml::String,
            art_name::String,
            art_locf::String,
            art_tarf::String,
            art_urls::Vector{String}) =
(
    # querry all the files in the folder
    _art_files = String[_file for _file in readdir(art_locf)];

    # deploy the artifact
    deploy_artifact(art_toml, art_name, art_locf, _art_files, art_tarf,
                    art_urls);

    return nothing;
)
