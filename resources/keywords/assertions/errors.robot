*** Keywords ***
error field should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.[${error_number}].field
    should be equal    ${expected_value}    ${resp_error}

error message should be
    [Arguments]    ${expected_value}    ${error_number}=0
    ${resp_error}=    get value from response via json path    $.[${error_number}].message
    should be equal    ${expected_value}    ${resp_error}

error message is received
    [Arguments]    ${expected_value}
    ${resp_error}=    get value from response via json path    $.message
    should be equal    ${expected_value}    ${resp_error}