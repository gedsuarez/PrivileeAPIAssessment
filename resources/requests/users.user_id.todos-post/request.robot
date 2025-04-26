*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../resource_collection.robot

*** Keywords ***
create todo is called
    [Arguments]    ${auth}=${TOKEN}    ${user_id}=${USER_ID}    ${payload_type}=default_payload
    ${random_todo_title}=    generate random string    15    [LETTERS][NUMBERS]
    ${payload}    run keyword if    "${payload_type}"=="modified_payload"    get variable value    ${modified_body}
    ...    ELSE    get file    ${CURDIR}/../../requests/users.user_id.todos-post/create-todo.json
    ${body}    replace payload dynamic variables    ${payload}    test_todo    ${random_todo_title}
    ${headers}    create dictionary    Content-Type=application/json    Authorization=None
    create session    session    ${BASE_URL}    auth=${NONE}    disable_warnings=1
    ${response}    post on session    session    url=/public/v2/users/${user_id}/todos?access-token=${auth}    headers=${headers}    data=${body}    expected_status=any
    set test variable    ${response}
    log    ${response}
    log    ${response.headers}
    log    ${response.content}
    run keyword if    "${response.status_code}" == "201"    save new todo object attributes
    delete all sessions
    set test variable    ${random_todo_title}

create todo payload is modified
    [Arguments]    ${attributes_list}
    ${variables}=  get variables
    ${body}=    run keyword if    "\${modified_body}"=="${NONE}"    get variable value    ${modified_body}
    ...    ELSE    get file    ${CURDIR}/../../requests/users.user_id.todos-post/create-todo.json
    ${modified_body}=    replace request payload attribute    ${body}    attribute_list=${attributes_list}
    set test variable    ${modified_body}