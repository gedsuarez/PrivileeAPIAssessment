*** Keywords ***
save new post object attributes
    ${post_id}=    get value from response via json path    $.id
    ${post_user_id}=    get value from response via json path    $.user_id
    ${post_title}=    get value from response via json path    $.title
    ${post_body}=    get value from response via json path    $.body
    set suite variable    ${post_id}
    set suite variable    ${post_user_id}
    set suite variable    ${post_title}
    set suite variable    ${post_body}