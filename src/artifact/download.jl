###############################################################################
#
# Download the artifacts manually to avoid slow downloading from julia server
#
###############################################################################
"""
Artifacts stored on FTP cannot be installed directly for Windows using Julia
    1.5. This problem may be fixed in future Julia versions. To address the
    problem for lower Julia versions, `PkgUtility` provides function
    `predownload_artifact` to download and unpack the artifact manually for
    Windows:

$(METHODLIST)

"""
function predownload_artifact end




"""
What `predownload_artifact` does are
- determine if the artifact exists already
- if `true`, skip the artifact installation
- if `false`
  - install the artifact using the `download_artifact` from `Pkg.Artifacts`
  - if the installation fails (e.g., for Windows)
    - download the `.tar.gz` manually
    - unpack the  `.tar.gz` manually

Method for this function is

    predownload_artifact(art_name::String, artifact_toml::String)

Download the artifact from given server if it does not exist, given
- `art_name` Artifact name to install
- `artifact_toml` `Artifacts.toml` file location

---
Examples
```julia
predownload_artifact("test_artifact", "Artifacts.toml");
```
"""
predownload_artifact(art_name::String, artifact_toml::String) =
(
    _meta = artifact_meta(art_name, artifact_toml);
    _hash = Base.SHA1(_meta["git-tree-sha1"]);

    # if artifact exists already, skip it
    if artifact_exists(_hash)
        return nothing;
    end;

    # try to download the artifact from all entries if it does not exist
    for _entry in _meta["download"]
        _url          = _entry["url"];
        _tarball_hash = _entry["sha256"];
        _succeeded    = download_artifact(_hash, _url, _tarball_hash);
        if _succeeded
            break;
        end;
    end;

    # if artifact is installed successfully, skip it
    if artifact_exists(_hash)
        return nothing;
    end;

    # download and unpack the artifact manually if above fails
    @info "Install the artifact manually...";
    for _entry in _meta["download"]
        _dest_dir  = artifact_path(_hash; honor_overrides=false);
        _url       = _entry["url"];
        _succeeded = download(_url, "temp_artifact.tar.gz");
        if _succeeded == "temp_artifact.tar.gz"
            unpack("temp_artifact.tar.gz", _dest_dir);
            rm("temp_artifact.tar.gz");
            break;
        end;
    end;

    return nothing;
)
