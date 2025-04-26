*** Keywords ***
save new todo object attributes
    ${todo_id}=    get value from response via json path    $.id
    ${todo_user_id}=    get value from response via json path    $.user_id
    ${todo_title}=    get value from response via json path    $.title
    ${todo_due_on}=    get value from response via json path    $.due_on
    ${todo_status}=    get value from response via json path    $.status
    set suite variable    ${todo_id}
    set suite variable    ${todo_user_id}
    set suite variable    ${todo_title}
    set suite variable    ${todo_due_on}
    set suite variable    ${todo_status}