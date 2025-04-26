*** Settings ***
Resource    ../../libraries.robot
Resource    ../../../resource_collection.robot

*** Keywords ***
create post is called
    [Arguments]    ${auth}=${TOKEN}    ${user_id}=${USER_ID}    ${payload_type}=default_payload
    ${random_post_title}=    generate random string    15    [LETTERS][NUMBERS]
    ${random_post_body}=    generate random string    50    [LETTERS][NUMBERS]
    ${payload}    run keyword if    "${payload_type}"=="modified_payload"    get variable value    ${modified_body}
    ...    ELSE    get file    ${CURDIR}/../../requests/users.user_id.posts-post/create-post.json
    ${body}    replace payload dynamic variables    ${payload}    test_post    ${random_post_title}
    ${body}    replace payload dynamic variables    ${body}    post_body    ${random_post_body}
    ${headers}    create dictionary    Content-Type=application/json    Authorization=None
    create session    session    ${BASE_URL}    auth=${NONE}    disable_warnings=1
    ${response}    post on session    session    url=/public/v2/users/${user_id}/posts?access-token=${auth}    headers=${headers}    data=${body}    expected_status=any
    set test variable    ${response}
    log    ${response}
    log    ${response.headers}
    log    ${response.content}
    run keyword if    "${response.status_code}" == "201"    save new post object attributes
    delete all sessions
    set test variable    ${random_post_title}
    set test variable    ${random_post_body}

create post payload is modified
    [Arguments]    ${attributes_list}
    ${variables}=  get variables
    ${body}=    run keyword if    "\${modified_body}"=="${NONE}"    get variable value    ${modified_body}
    ...    ELSE    get file    ${CURDIR}/../../requests/users.user_id.posts-post/create-post.json
    ${modified_body}=    replace request payload attribute    ${body}    attribute_list=${attributes_list}
    set test variable    ${modified_body}