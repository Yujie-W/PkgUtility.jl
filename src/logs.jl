#######################################################################################################################################################################################################
#
# Changes to these functions
# General
#     2022-Aug-24: move function outside of the folder
#
#######################################################################################################################################################################################################
"""

    terror(info::String)

Add a time tag to logging string, given
- `info` Infomation to display with @error

"""
function terror(info::String)
    return "$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n       $(info)"
end


"""

    tinfo(info::String)

Add a time tag to logging string, given
- `info` Infomation to display with @info

"""
function tinfo(info::String)
    return "$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n      $(info)"
end


"""

    twarn(info::String)

Add a time tag to logging string, given
- `info` Infomation to display with @warn

"""
function twarn(info::String)
    return "$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n         $(info)"
end
