#######################################################################################################################################################################################################
#
# Changes to these functions
# General
#     2022-Aug-24: move function outside of the folder
#
#######################################################################################################################################################################################################
"""

    send_email!(subject::String, from_email::String, to_email::String, body::String)

Send out email, given
- `subject` Email subject
- `from_email` The outgoing email address
- `to_email` Email address to send out
- `body` Main body of the email

"""
function send_email!(subject::String, from_email::String, to_email::String, body::String)
    @info tinfo("Sending email to $(to_email)...");

    # compose email and write the email to local drive
    Base.write(".tmp_email", "Subject: $(subject)\nFrom: $(from_email)\nTo: $(to_email)\n$(body)");

    # send the email through pipeline and delete the file
    run(pipeline(".tmp_email", `sendmail -t`));
    rm(".tmp_email");

    return nothing
end


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
