*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../resource_collection.robot

*** Keywords ***
get all users is called
    [Arguments]    ${auth}=${TOKEN}    ${name}=None    ${email}=None    ${status}=None    ${gender}=None
    @{query_param_list}    create list
    ${query_parameters}    set variable    ${EMPTY}
    append to list    ${query_param_list}    access-token=${auth}
    run keyword if    "${name}" != "None"    append to list    ${query_param_list}    name=${name}
    run keyword if    "${email}" != "None"    append to list    ${query_param_list}    email=${email}
    run keyword if    "${status}" != "None"    append to list    ${query_param_list}    status=${status}
    run keyword if    "${gender}" != "None"    append to list    ${query_param_list}    gender=${gender}
    FOR    ${param}    IN    @{query_param_list}
	    ${query_parameters}    set variable if    "${query_parameters}" == "${EMPTY}"    ${param}    ${query_parameters}&${param}
    END
    ${headers}    create dictionary    Content-Type=application/json    Authorization=None
    create session    session    ${BASE_URL}    disable_warnings=1
    ${response}    get on session    session    url=/public/v2/users?${query_parameters}    headers=${headers}    expected_status=any
    set test variable    ${response}
    log    ${response}
    log    ${response.headers}
    log    ${response.content}
    delete all sessions