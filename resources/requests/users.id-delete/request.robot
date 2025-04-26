*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../resource_collection.robot

*** Keywords ***
delete user is called
    [Arguments]    ${auth}=${TOKEN}    ${user_id}=${user_id}
    ${headers}    create dictionary    Authorization=None
    create session    session    ${BASE_URL}    auth=${NONE}    disable_warnings=1
    ${response}    delete on session    session    url=/public/v2/users/${user_id}?access-token=${auth}    headers=${headers}    expected_status=any
    set test variable    ${response}
    log    ${response}
    log    ${response.headers}
    log    ${response.content}
    delete all sessions