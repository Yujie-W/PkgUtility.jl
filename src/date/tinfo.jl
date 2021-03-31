###############################################################################
#
# Functions to display time in @error @info, and @warn
#
###############################################################################
"""
A function to covert information to time + information

    terror(info::String)

Display the error info with date and time before the given
- `info` Infomation to display

---
Examples
```julia
terror("This is an error with time stamp at the beginning!");
```
"""
function terror(info::String)
    return "$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n       $(info)"
end




"""
A function to covert information to time + information

    tinfo(info::String)

Display the error info with date and time before the given
- `info` Infomation to display

---
Examples
```julia
tinfo("This is an info with time stamp at the beginning!");
```
"""
function tinfo(info::String)
    return "$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n      $(info)"
end




"""
A function to covert information to time + information

    twarn(info::String)

Display the error info with date and time before the given
- `info` Infomation to display

---
Examples
```julia
twarn("This is an info with time stamp at the beginning!");
```
"""
function twarn(info::String)
    return "$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n         $(info)"
end
