#######################################################################################################################################################################################################
#
# Changes to this function
# General
#     2022-Aug-24: move function outside of the folder
#     2022-Aug-24: add support to the case if the value is a vector but not a vector of pairs
#
#######################################################################################################################################################################################################
"""

    pretty_display!(pvec::Union{Vector{Pair{String,String}}, Vector{Pair{String,Any}}, Vector{Pair{Any,String}}, Vector{Pair{Any,Any}}}, spaces::String = "    ")

Display the pairs in a pretty way, given
- `pvec` Vector of pairs to display
- `spaces` Leading spaces before displaying the pair key

---
Examples
```julia
_pairs = ["A" => "b", "d" => "A", "rr" => ["ra" => "rB", "rD" => "ra"]];
pretty_display!(_pairs);
pretty_display!(_pairs, "  ");
```

"""
function pretty_display! end

pretty_display!(pair::Pair, max_len::Int, spaces = "    ") = (
    # print leading spaces
    print(spaces);

    # print the key
    printstyled(string(pair[1]); color = :light_magenta);

    # print spaces after key and arrow
    print(repeat(" ", max_len - length(string(pair[1]))) * " ⇨ ");

    # if the value is a vector of pairs, recursive display
    if typeof(pair[2]) <: Vector && typeof(pair[2][1]) <: Pair
        # display [ and line break
        print("[\n");
        pretty_display!(pair[2], spaces * repeat(" ", max_len + 5));

        # display a ] and the next line
        print(spaces * repeat(" ", max_len + 4) * "],\n");

        return nothing;
    end;

    # if the value is not array of pair, display it
    printstyled(string(pair[2]); color = :cyan);
    print(",\n");

    return nothing;
);

pretty_display!(pvec::Union{Vector{Pair{String,String}}, Vector{Pair{String,Any}}, Vector{Pair{Any,String}}, Vector{Pair{Any,Any}}}, spaces::String = "    ") = (
    # determine the length of the keys
    _max_len = maximum(length.([string(_p[1]) for _p in pvec]));

    # display the elements
    pretty_display!.(pvec, _max_len, spaces);

    return nothing
);
