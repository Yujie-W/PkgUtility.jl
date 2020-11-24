###############################################################################
#
# Recursive display function
#
###############################################################################
"""
    pretty_display(
                para::Array{Pair{Union{Any},Union{Any}},1},
                spaces::String = " ")

Display array of pairs (dictionary) in recursive manner, given
- `para` Parameters to display
- `spaces` Leading spaces
"""
function pretty_display(
            para::Union{ Array{Pair{String,String},1},
                         Array{Pair{String,Any},1},
                         Array{Pair{Any,String},1},
                         Array{Pair{Any,Any},1}},
            spaces::String = "    "
)
    # determine the length of the keys
    max_len = maximum(length.([string(p[1]) for p in para]));

    # display the elements
    for p in para
        # print leading spaces
        print(spaces);

        # print the key
        print( string(p[1]) );

        # print spaces after key and arrow
        print( repeat(" ", max_len-length(string(p[1]))) * " => " );

        # if the value is array of pairs, recursive display
        if typeof(p[2]) <: Array
            # display [ and line break
            print( "[\n" );
            pretty_display(p[2], spaces*repeat(" ",max_len+5));

            # display a ] and the next line
            print(spaces * repeat(" ",max_len+4) * "],\n" );

        # if the value is not array of pair, display it
        else
            print( string(p[2]) * ",\n" );
        end
    end

    return nothing
end
