*** Keywords ***
todo user id should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${todo_user_id}

todo title should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${todo_title}

todo status should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${todo_status}