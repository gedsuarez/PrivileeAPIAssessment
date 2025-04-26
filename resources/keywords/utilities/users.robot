*** Keywords ***
save new user object attributes
    ${user_id}=    get value from response via json path    $.id
    ${name}=    get value from response via json path    $.name
    ${email}=    get value from response via json path    $.email
    ${gender}=    get value from response via json path    $.gender
    ${status}=    get value from response via json path    $.status
    set suite variable    ${user_id}
    set suite variable    ${name}
    set suite variable    ${email}
    set suite variable    ${gender}
    set suite variable    ${status}

the email is not existing
    [Arguments]    ${email}
    get all users is called    email=${email}    status=active
    ${data}=    evaluate  json.loads('''${response.content}''')
    ${no_of_users}=  get length  ${data}
    IF    ${no_of_users} != 0
        ${user_id}=    get value from response via json path    $.id
        delete user is called
    END
    set suite variable    ${expected_email}    ${email}

an ${status} user has been created
    create user payload is modified    status,${status},string
    create user is called    payload_type=modified_payload

a user is existing
    set test variable    ${USER_ID}

a user is not existing
    set test variable    ${USER_ID}    non-existing