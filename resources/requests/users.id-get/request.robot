*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../resource_collection.robot

*** Keywords ***
get users by id is called
    [Arguments]    ${auth}=${TOKEN}    ${user_id}=${user_id}
    ${headers}    create dictionary    Content-Type=application/json    Authorization=None
    create session    session    ${BASE_URL}    disable_warnings=1
    ${response}    get on session    session    url=/public/v2/users/${user_id}?access-token=${auth}    headers=${headers}    expected_status=any
    set test variable    ${response}
    log    ${response}
    log    ${response.headers}
    log    ${response.content}
    run keyword if    "${response.status_code}" == "200"    save new user object attributes
    delete all sessions