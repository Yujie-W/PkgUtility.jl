###############################################################################
#
# write messages to email file
#
###############################################################################
"""
Running program on the server mat take very long time, and one may not know the status without logging into the system. Thus, we provide a function to send
    email to notify the status:


"""
function send_email! end




"""
Here is the function to send email out:

    send_email!(subject::String,
                from_email::String,
                to_email::String,
                body::String)

Send out email, given
- `subject` Email subject
- `from_email` The outgoing email address
- `to_email` Email address to send out
- `body` Main body of the email

Note that you have to run this function on a machine with `sendmail` set up.

---
Example
```julia
send_email!("[DO NOT REPLY] Job status", "from.email", "to.email", "This is the main text");
```
"""
send_email!(subject::String,
            from_email::String,
            to_email::String,
            body::String) =
(
    @info tinfo("Sending email to $(to_email)...");

    # compose email and write the email to local drive
    _email_to_write = """
    Subject: $(subject)
    From: $(from_email)
    To: $(to_email)
    $(body)
    """;
    Base.write(".tmp_email", _email_to_write);

    # send the email through pipeline and delete the file
    run( pipeline(".tmp_email", `sendmail -t`) );
    rm(".tmp_email");

    return nothing
)
