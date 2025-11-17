#######################################################################################################################################################################################################
#
# Changes to this function
# General
#     2024-Feb-24: add function sync_struct! to sync fields from one struct to another recursively
#     2025-Jun-03: add method to sync the struct to a dictionary (to write to file)
#     2025-Jun-04: add method to sync the struct from a dictionary (to read from file)
#
#######################################################################################################################################################################################################
"""

    sync_struct!(struct_from, struct_to)

Sync the fields from `struct_from` to `struct_to`.

"""
function sync_struct! end;

sync_struct!(struct_from::ST, struct_to::ST) where ST = (
    for fn in fieldnames(ST)
        fntype = fieldtype(ST, fn);
        # TODO: memory allocation when sync numbers and bools
        if fntype <: Union{Number, String, Bool}
            setfield!(struct_to, fn, getfield(struct_from, fn));
        elseif fntype <:AbstractArray && eltype(getfield(struct_from, fn)) <: Union{Number, String, Bool}
            setfield!(struct_to, fn, getfield(struct_from, fn));
        elseif fntype <: Function
            setfield!(struct_to, fn, deepcopy(getfield(struct_from, fn)));
        else
            sync_struct!(getfield(struct_from, fn), getfield(struct_to, fn));
        end;
    end;

    return nothing
);

sync_struct!(struct_from::ST) where ST = (
    dict = Dict{String,Any}();

    for fn in fieldnames(ST)
        fntype = fieldtype(ST, fn);

        if fntype <: Union{Number, String, Bool}
            dict[String(fn)] = getfield(struct_from, fn);
        elseif fntype <:AbstractArray && eltype(getfield(struct_from, fn)) <: Union{AbstractArray, Number, String, Bool}
            dict[String(fn)] = getfield(struct_from, fn);
        elseif fntype <:AbstractArray
            dict[String(fn)] = [
                sync_struct!(getfield(struct_from, fn)[i]) for i in eachindex(getfield(struct_from, fn))
            ];
        elseif fntype <: Function
            @warn "Function field $fn is not copied...";
        else
            dict[String(fn)] = sync_struct!(getfield(struct_from, fn));
        end;
    end;

    return dict
);

sync_struct!(dict_from::Dict, struct_to::ST) where ST = (
    fns = fieldnames(ST);

    for (k,v) in dict_from
        if Symbol(k) in fns
            fntype = fieldtype(ST, Symbol(k));

            if fntype <: Union{Number, String, Bool}
                setfield!(struct_to, Symbol(k), v);
            elseif fntype <:AbstractArray && eltype(v) <: Union{Number, String, Bool}
                setfield!(struct_to, Symbol(k), v);
            elseif fntype <:AbstractArray
                for idict in eachindex(v)
                    sync_struct!(v[idict], getfield(struct_to, Symbol(k))[idict]);
                end;
            elseif fntype <: Function
                @warn "Function field $(k) is not copied...";
            else
                sync_struct!(v, getfield(struct_to, Symbol(k)));
            end;
        else
            @warn "Field $(k) not existing in the target struct!";
        end;
    end;

    return nothing
);
