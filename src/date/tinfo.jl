###############################################################################
#
# A macro to display time in @info
#
###############################################################################
"""
A macro to display time and info.

    macro tinfo(info::String)
    @tinfo info::String

Display the info with date and time before the given
- `info` A string to display using `@info` macro

---
Examples
```julia
@tinfo "This is a infomation with time stamp at the beginning!";
```
"""
macro tinfo(info::String)
    @info "$(format(now(),"yyyy-mm-dd HH:MM:SS"))  $(info)";
end
