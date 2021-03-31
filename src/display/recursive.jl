###############################################################################
#
# Recursive display function
#
###############################################################################
"""
Display the parameters in a colored way.

$(METHODLIST)

"""
function pretty_display end




"""
When a dictionary (a pair of key and item) is passed to the `pretty_display`
    function, the dictionary will be displayed as `(LEADING_SPACE)key ⇨ item,`.
    However, if the dictionary item is an array of dictionaries, then the array
    will be displayed recursively.

    pretty_display(dict::Pair, max_len::Int, spaces = "    ")

Display the key and item in a dictionary (Pair), given
- `dict` Dictionary to display
- `max_len` Maximum length of dictionary key (in an array)
- `spaces` Leading spaces before displaying the dictionary key

---
Examples
```julia
# display the pair in a pretty way (automatic alignments)
pretty_display("a" => "b", 1);
pretty_display("a" => "b", 2, "  ");
```
"""
pretty_display(dict::Pair, max_len::Int, spaces = "    ") =
(
    # print leading spaces
    print(spaces);

    # print the key
    printstyled(string(dict[1]); color=:light_magenta);

    # print spaces after key and arrow
    print( repeat(" ", max_len-length(string(dict[1]))) * " ⇨ " );

    # if the value is a vetor of pairs, recursive display
    if typeof(dict[2]) <: Vector
        # display [ and line break
        print( "[\n" );
        pretty_display(dict[2], spaces*repeat(" ",max_len+5));

        # display a ] and the next line
        print(spaces * repeat(" ",max_len+4) * "],\n" );

    # if the value is not array of pair, display it
    else
        printstyled(string(dict[2]); color=:cyan);
        print(",\n" );
    end;

    return nothing;
)




"""
When an array of dictionaries is given, the `pretty_display` function computes
    the maximum length of the dictionary keys, and then display the
    dictionaries in a colored and pretty manner

    pretty_display(
                dicts::Union{Vector{Pair{String,String}},
                             Vector{Pair{String,Any}},
                             Vector{Pair{Any,String}},
                             Vector{Pair{Any,Any}}},
                spaces::String = "    ")

Display array of pairs (dictionary) in recursive manner, given
- `dicts` Parameters to display
- `spaces` Leading spaces

---
Examples
```julia
# display the vector of pairs recursively (automatic alignments)
_dicts = ["A" => "b", "d" => "A", "rr" => ["ra" => "rB", "rD" => "ra"]];
pretty_display(_dicts);
pretty_display(_dicts, "  ");
```
"""
pretty_display(
            dicts::Union{Vector{Pair{String,String}},
                         Vector{Pair{String,Any}},
                         Vector{Pair{Any,String}},
                         Vector{Pair{Any,Any}}},
            spaces::String = "    ") =
(
    # determine the length of the keys
    _max_len = maximum(length.([string(p[1]) for p in dicts]));

    # display the elements
    pretty_display.(dicts, _max_len, spaces);

    return nothing
)
