###############################################################################
#
# Function to deploy artifact
#
###############################################################################
"""
    deploy_artifact(
                art_toml::String,
                art_name::String,
                art_locf::String,
                art_file::Array{String,1},
                art_tarf::String,
                art_urls::Array{String,1};
                new_file::Array{String,1} = art_file)
    deploy_artifact(
                art_toml::String,
                art_name::String,
                art_locf::String,
                art_tarf::String,
                art_urls::Array{String,1})

Deploy the artifact, given
- `art_toml` Artifact TOML file location
- `art_name` Artifact name identitfier
- `art_locf` Local folder that stores artifact files
- `art_file` Array of artifact file names
- `art_tarf` Folder location to store artifact TAR file
- `art_urls` Array of urls to upload the Artifact to
- `new_file` Optional. New file names (same as art_file by default)
"""
function deploy_artifact(
            art_toml::String,
            art_name::String,
            art_locf::String,
            art_file::Array{String,1},
            art_tarf::String,
            art_urls::Array{String,1};
            new_file::Array{String,1} = art_file
)
    # querry whether the artifact exists
    art_hash = artifact_hash(art_name, art_toml);

    # create artifact
    if isnothing(art_hash) || !artifact_exists(art_hash)
        @info "Artifact $(art_name) not found, deploy it now...";

        # copy files to artifact folder
        @info "Copying files into artifact folder...";
        art_hash = create_artifact() do artifact_dir
            for i in eachindex(art_file)
                _in   = art_file[i];
                _out  = new_file[i];
                _path = joinpath(art_locf, _in);
                @info "Copying file $(_in)...";
                cp(_path, joinpath(artifact_dir, _out));
            end
        end
        #@show art_hash;

        # compress artifact
        @info "Compressing artifact $(art_name)...";
        tar_loc  = "$(art_tarf)/$(art_name).tar.gz";
        tar_hash = archive_artifact(art_hash, tar_loc);
        #@show tar_hash;

        # bind artifact to download information
        download_info = [("$(_url)/$(art_name).tar.gz", tar_hash)
                         for _url in art_urls];
        #@show typeof(download_info);
        bind_artifact!(art_toml, art_name, art_hash;
                       download_info=download_info,
                       lazy=true,
                       force=true);
    else
        @info "Artifact $(art_name) already exists, skip it";
    end

    return nothing
end




function deploy_artifact(
            art_toml::String,
            art_name::String,
            art_locf::String,
            art_tarf::String,
            art_urls::Array{String,1}
)
    # querry all the files in the folder
    art_file = String[];
    for _file in readdir(art_locf)
        push!(art_file, _file);
    end

    # deploy the artifact
    deploy_artifact(art_toml, art_name, art_locf,
                    art_file, art_tarf, art_urls);

    return nothing
end
