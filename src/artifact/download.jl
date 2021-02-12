###############################################################################
#
# Download the artifacts manually to avoid slow downloading from julia server
#
###############################################################################
"""
    predownload_artifact(name::String, artifact_toml::String)

Download the artifact from given server if it does not exist, given
- `name` Artifact name
- `artifact_toml` Artifacts.toml file location
"""
function predownload_artifact(name::String, artifact_toml::String)
    meta = artifact_meta(name, artifact_toml);
    hash = Base.SHA1(meta["git-tree-sha1"]);

    # try to download the artifact from all entries if it does not exist
    if !artifact_exists(hash)
        for entry in meta["download"]
            url          = entry["url"];
            tarball_hash = entry["sha256"];
            succeeded    = download_artifact(hash, url, tarball_hash);
            if succeeded
                break
            end
        end
    end

    # download and unpack the artifact manually if above fails
    if !artifact_exists(hash)
        @info "Install the artifact manually...";
        for entry in meta["download"]
            dest_dir  = artifact_path(hash; honor_overrides=false);
            url       = entry["url"];
            succeeded = download(url, "temp_artifact.tar.gz");
            if succeeded == "temp_artifact.tar.gz"
                unpack("temp_artifact.tar.gz", dest_dir);
                rm("temp_artifact.tar.gz");
                break
            end
        end
    end

    return nothing
end
