*** Settings ***
Library    String
Library  JSONSchemaLibrary

*** Keywords ***
get value from response via json path
    [Arguments]    ${json_path}
    ${resp}    convert string to json    ${response.content}
    ${attribute_value}    get value from json    ${resp}    ${json_path}
    [Return]    ${attribute_value[0]}

replace payload dynamic variables
    [Arguments]    ${payload}    ${search_string}    ${new_value}
    ${modified_payload}    replace string    ${payload}    ${search_string}    ${new_value}
    [Return]    ${modified_payload}

replace request payload attribute
    [Arguments]    ${payload}    ${attribute_list}=${attribute_list}
    @{attribute_list}    split string    ${attribute_list}    ;
    ${flag}    set variable   false
    FOR    ${attribute}    IN    @{attribute_list}
    @{attribute}    split string    ${attribute}    ,
    ${json_attribute}    set variable    ${attribute}[0]
    ${json_value}    set variable    ${attribute}[1]
    ${type}    convert to string    ${attribute}[2]
    ${json_value}=    run keyword if    "${type}"=="integer"    convert to integer    ${json_value}
    ...    ELSE IF    "${type}"=="string"    set variable    ${json_value}
    ...    ELSE IF    "${type}"=="boolean"    convert to boolean    ${json_value}
    ...    ELSE IF    "${type}"=="decimal"    convert to number    ${json_value}
    ...    ELSE IF    "${type}"=="null" or "${type}"=="delete"    set variable    ${json_value}
    ${payload}=    evaluate    json.loads('''${payload}''')    json
    Set To Dictionary    	${payload}    ${json_attribute}=${json_value}
    ${modified_payload}=    evaluate    json.dumps(${payload})    json
    ${modified_payload}=    run keyword if     "${type}"=="null"    replace payload dynamic variables    ${modified_payload}    "${json_value}"    ${json_value}
    ...    ELSE IF    "${type}"=="delete"    delete from payload    ${modified_payload}    ${json_attribute}    ${json_value}
    ...    ELSE    set variable    ${modified_payload}
    ${payload}=    set variable    ${modified_payload}
    ${payload}=    run keyword if    "${flag}" == "true"     set variable    ${modified_payload}
    ...    ELSE    set variable    ${payload}
    set suite variable    ${flag}    true
    END
    [Return]    ${modified_payload}

delete from payload
    [Arguments]    ${payload}    ${json_attribute}    ${json_value}
    ${item_last}=    run keyword and return status    should contain    ${payload}    "${json_attribute}": "${json_value}"}
    ${modified_payload}=    run keyword if    "${item_last}" == "True"    replace string    ${payload}    , "${json_attribute}": "${json_value}"    ${EMPTY}
    ...    ELSE    replace string    ${payload}    "${json_attribute}": "${json_value}",    ${EMPTY}
    [Return]    ${modified_payload}

an alphanumeric string with length
    [Arguments]    ${length}
    ${random_string}=    generate random string    ${length}    [LETTERS][NUMBERS]
    set suite variable    ${random_string}