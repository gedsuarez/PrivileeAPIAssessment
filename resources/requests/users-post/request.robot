*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../resource_collection.robot

*** Keywords ***
create user is called
    [Arguments]    ${auth}=${TOKEN}    ${payload_type}=default_payload
    an alphanumeric string with length    10
    ${payload}    run keyword if    "${payload_type}"=="modified_payload"    get variable value    ${modified_body}
    ...    ELSE    get file    ${CURDIR}/../../requests/users-post/create-user.json
    ${body}    replace payload dynamic variables    ${payload}    test_name    ${random_string}
    ${headers}    create dictionary    Content-Type=application/json    Authorization=None
    create session    session    ${BASE_URL}    auth=${NONE}    disable_warnings=1
    ${response}    post on session    session    url=/public/v2/users?access-token=${auth}    headers=${headers}    data=${body}    expected_status=any
    set test variable    ${response}
    log    ${response}
    log    ${response.headers}
    log    ${response.content}
    run keyword if    "${response.status_code}" == "201"    save new user object attributes
    delete all sessions

create user payload is modified
    [Arguments]    ${attributes_list}
    ${variables}=  get variables
    ${body}=    run keyword if    "\${modified_body}"=="${NONE}"    get variable value    ${modified_body}
    ...    ELSE    get file    ${CURDIR}/../../requests/users-post/create-user.json
    ${modified_body}=    replace request payload attribute    ${body}    attribute_list=${attributes_list}
    set test variable    ${modified_body}