*** Keywords ***
post user id should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${post_user_id}

post title should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${post_title}

post body should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${post_body}