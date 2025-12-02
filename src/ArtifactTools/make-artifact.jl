"""

    create_artifact!(files::Vector{String}, tarball_folder::String, tarball_name::String)

Create an artifact (tar.gz file), given
- `files` a vector of file paths to be included in the artifact
- `tarball_folder` the folder to save the tarball file
- `tarball_name` the name of the tarball file (with ot without .tar.gz extension)

"""
function create_artifact!(files::Vector{String}, tarball_folder::String, tarball_name::String)
    # make sure the files are not empty and all files exist
    @assert !isempty(files) "The files vector cannot be empty";
    @assert all(isfile, files) "All files must exist!";

    # the tarball file, path, and cache folder, etc.
    tarball_file = endswith(tarball_name, ".tar.gz") ? tarball_name : "$(tarball_name).tar.gz";
    tarball_path = joinpath(tarball_folder, tarball_file);
    cache_folder = joinpath(tarball_folder, "cache");

    # make sure the tarball file does not exist. If exists, skip the process
    if isfile(tarball_path)
        @info "The artifact file $(tarball_path) already exists. Skip the process...";
        return nothing
    end;

    # show the progress
    @info "Creating artifact for located at $(tarball_path)...";
    mkpath(cache_folder);

    # copy the empty file GRIDDINGMACHINE and netCDF file to the tmp_dir folder
    for f in files
        cp(f, joinpath(cache_folder, basename(f)); force = true);
    end;

    # compute the hash of the tmp_dir folder and rename it
    artifact_hash = Base.SHA1(tree_hash(cache_folder));
    artifact_hash_str = bytes2hex(artifact_hash.bytes);
    artifact_dir = joinpath(tarball_folder, artifact_hash_str);
    mv(cache_folder, artifact_dir; force = true);

    # package the artifact
    package(artifact_dir, tarball_file);

    return tarball_path
end;
