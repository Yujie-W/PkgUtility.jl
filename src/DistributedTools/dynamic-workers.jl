"""

    dynamic_workers!(threads::Int; exeflags::String = "--project")

Add processors to run code in multiple threadings, given
- `threads` Number of threads
- `exeflags` Flags for the Julia executable

"""
function dynamic_workers!(threads::Int; exeflags::String = "--project")
    max_threads = Sys.CPU_THREADS;

    # if there is not yet any worker, hire at most max_threads
    if workers() == [1]
        addprocs(min(max_threads, threads); exeflags = exeflags);

        return nothing
    end;

    # if there are already some workers, hire more
    if min(max_threads, threads) > length(workers())
        addprocs(min(max_threads, threads) - length(workers()); exeflags = exeflags);

        return nothing
    end;

    # if there are too many workers, remove the extra
    if length(workers()) > min(max_threads, threads)
        to_remove = workers()[(min(max_threads, threads) + 1):end];
        rmprocs(to_remove...);

        return nothing
    end;

    return nothing
end;
