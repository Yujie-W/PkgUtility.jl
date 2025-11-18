module PrettyDisplay

using Dates: format, now


##########################################################################################################################################################################################################
#
# Changes to this function
# General
#     2022-Aug-24: move function outside of the folder
#     2022-Aug-24: add support to the case if the value is a vector but not a vector of pairs
#     2025-Nov-17: add a general call to display messages based on message level
#
##########################################################################################################################################################################################################
"""
#
    pretty_display!(msg::String, func_type::String)

Display the message based on the message level, given
- `msg` message to display
- `func_type` message level for displaying

## Examples
```julia
    pretty_display!("This is an entire timed info message", "tinfo");
    pretty_display!("This is the first line of a set of timed info messages", "tinfo_pre");
    pretty_display!("This is the middle line of a set of timed info messages", "tinfo_mid");
    pretty_display!("This is the last line of a set of timed info messages", "tinfo_end");
```

#
    pretty_display!(pvec::Vector{<:Pair})

Display the pairs in a pretty way, given
- `pvec` Vector of pairs to display

---
Examples
```julia
    pvec = ["A" => "b", "d" => "A", "rr" => ["ra" => "rB", "rD" => "ra"]];
    pretty_display!(pvec);
```


"""
function pretty_display! end;

pretty_display!(msg::String, func_type::String) = (
    @assert occursin("tinfo", func_type) || occursin("twarn", func_type) || occursin("terror", func_type);

    # parse the function name to call
    f = if occursin("tinfo", func_type)
        display_timed_info!
    elseif occursin("twarn", func_type)
        display_timed_warning!
    elseif occursin("terror", func_type)
        display_timed_error!
    end;

    # parse the message level extension
    msg_lvl = if occursin("pre", func_type)
        "pre"
    elseif occursin("mid", func_type)
        "mid"
    elseif occursin("end", func_type)
        "end"
    else
        ""
    end;

    # call the display function
    f(msg, msg_lvl);

    return nothing
);

pretty_display!(pvec::Vector{<:Pair}) = (
    display_timed_info!("Displaying a vector of pairs:", "pre");

    # display the elements
    maxlen = maximum(length.([string(_p[1]) for _p in pvec]));
    pretty_display!.(pvec, maxlen, 4);

    display_timed_info!("", "end");

    return nothing
);

pretty_display!(pvec::Vector{<:Pair}, recursed_space::Int) = (
    # display the elements
    maxlen = maximum(length.([string(_p[1]) for _p in pvec]));
    pretty_display!.(pvec, maxlen, recursed_space+4);

    return nothing
);


#
#
# sub functions to display messages for pretty_display!(msg::String, func_type::String)
#
#
display_timed_info!(msg::String, msg_level::String) = (
    @assert msg_level in ["", "pre", "mid", "end"];

    if msg_level == ""
        printstyled("┌ Info: "; bold = true, color = :cyan);
        printstyled("$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n"; bold = false, color = :white);
        printstyled("└       "; bold = true, color = :cyan);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "pre"
        printstyled("┌ Info: "; bold = true, color = :cyan);
        printstyled("$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n"; bold = false, color = :white);
        printstyled("│       "; bold = true, color = :cyan);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "mid"
        printstyled("│       "; bold = true, color = :cyan);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "end"
        printstyled("└       "; bold = true, color = :cyan);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    return nothing
);

display_timed_warning!(msg::String, msg_level::String) = (
    @assert msg_level in ["", "pre", "mid", "end"];

    if msg_level == ""
        printstyled("┌ Warning: "; bold = true, color = :yellow);
        printstyled("$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n"; bold = false, color = :white);
        printstyled("└          "; bold = true, color = :yellow);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "pre"
        printstyled("┌ Warning: "; bold = true, color = :yellow);
        printstyled("$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n"; bold = false, color = :white);
        printstyled("│          "; bold = true, color = :yellow);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "mid"
        printstyled("│          "; bold = true, color = :yellow);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "end"
        printstyled("└          "; bold = true, color = :yellow);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    return nothing
);

display_timed_error!(msg::String, msg_level::String) = (
    @assert msg_level in ["", "pre", "mid", "end"];

    if msg_level == ""
        printstyled("┌ Error: "; bold = true, color = :red);
        printstyled("$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n"; bold = false, color = :white);
        printstyled("└        "; bold = true, color = :red);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "pre"
        printstyled("┌ Error: "; bold = true, color = :red);
        printstyled("$(format(now(),"yyyy-mm-dd HH:MM:SS"))\n"; bold = false, color = :white);
        printstyled("│        "; bold = true, color = :red);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "mid"
        printstyled("│        "; bold = true, color = :red);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    if msg_level == "end"
        printstyled("└        "; bold = true, color = :red);
        printstyled(msg; bold = false, color = :white);
        print("\n");
    end;

    return nothing
);

#
#
# sub functions to display messages for pretty_display!(pvec::Vector{<:Pair})
#
#
pretty_display!(pair::Pair, max_len::Int, recursed_space::Int) = (
    # print leading spaces
    printstyled("│       "; bold = true, color = :cyan);
    print(repeat(" ", recursed_space));

    # print the key
    printstyled(string(pair[1]); color = :light_magenta);

    # print spaces after key and arrow
    print(repeat(" ", max_len - length(string(pair[1]))) * " => ");

    # if the value is a vector of pairs, recursive display
    if typeof(pair[2]) <: Vector && typeof(pair[2][1]) <: Pair
        # display [ and line break
        print("[\n");
        pretty_display!(pair[2], max_len + 5);

        # display a ] and the next line
        printstyled("│       "; bold = true, color = :cyan);
        print(repeat(" ", max_len + recursed_space + 4) * "],\n");

        return nothing;
    end;

    # if the value is not array of pair, display it
    printstyled(string(pair[2]); color = :green);
    print(",\n");

    return nothing;
);


end; # module
