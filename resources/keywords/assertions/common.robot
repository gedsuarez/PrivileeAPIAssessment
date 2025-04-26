*** Keywords ***
response status code should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${response.status_code}

response field should not be empty
    [Arguments]    ${json_path}
    should not be empty    ${json_path}

response body should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${response.content}    

schema should be valid versus response
    [Arguments]    ${schema}
    ${response_json}    convert string to json    ${response.content}
    validate json    ${schema}    ${response_json}

response should be empty
    should be equal as strings    []    ${response.content}