*** Keywords ***
name should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${name}

email should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${email}

gender should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${gender}

status should be
    [Arguments]    ${expected_value}
    should be equal as strings    ${expected_value}    ${status}

all users in the list have the gender ${gender}
    FOR    ${item}    IN    @{response.json()}
        ${actual_gender}=    set variable    ${item['gender']}
        should be equal    ${gender}    ${actual_gender}
    END

all users in the list have the status ${status}
    FOR    ${item}    IN    @{response.json()}
        ${actual_status}=    set variable    ${item['status']}
        should be equal    ${status}    ${actual_status}
    END

all users in the list have the name
    [Arguments]    ${name}=${name}
    FOR    ${item}    IN    @{response.json()}
        ${actual_name}=    set variable    ${item['name']}
        should be equal    ${name}    ${actual_name}
    END

all users in the list have the email
    [Arguments]    ${email}=${email}
    FOR    ${item}    IN    @{response.json()}
        ${actual_email}=    set variable    ${item['email']}
        should be equal    ${email}    ${actual_email}
    END