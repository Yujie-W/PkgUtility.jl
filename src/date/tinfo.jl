###############################################################################
#
# A macro to display time in @info
#
###############################################################################
"""

    macro tinfo(info::String)
    @tinfo info::String

A macro to display the info with date and time before the given
- `info` A string to display using `@info` macro
"""
macro tinfo(info::String)
    @info "$(format(now(),"yyyy-mm-dd HH:MM:SS"))  $(info)";
end
