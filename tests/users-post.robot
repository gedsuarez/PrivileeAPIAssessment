*** Settings ***
Resource      ../resource_collection.robot
Force Tags    create-user

*** Test Cases ***
Request should NOT create a user WHEN auth is invalid
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,${expected_email},string
    AND create user is called    auth=invalid    payload_type=modified_payload
    THEN response status code should be    401
    AND error message is received    Invalid token

Request should NOT create a user WHEN auth is not provided
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,${expected_email},string
    AND create user is called    auth=${NONE}    payload_type=modified_payload
    THEN response status code should be    401
    AND error message is received    Invalid token

Request should create a user WHEN gender is male and status is active
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    ${random_string}
    AND email should be    ${expected_email}
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should create a user WHEN gender is female and status is inactive
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    gender,female,string;status,inactive,string;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    ${random_string}
    AND email should be    ${expected_email}
    AND gender should be    female
    AND status should be     inactive
    [Teardown]    delete user is called

Request should create a user WHEN name is an integer
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,123455,integer;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    123455
    AND email should be    ${expected_email}
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should create a user WHEN name is a decimal
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,1234.55,decimal;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    1234.55
    AND email should be    ${expected_email}
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should create a user WHEN name is a boolean (true)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,true,boolean;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    t
    AND email should be    ${expected_email}
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should create a user WHEN name is a boolean (false)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,false,boolean;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    f
    AND email should be    ${expected_email}
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should NOT create a user WHEN name is null
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,null,null;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    name
    AND error message should be    can't be blank

Request should NOT create a user WHEN name is EMPTY
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,${EMPTY},string;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    name
    AND error message should be    can't be blank

Request should NOT create a user WHEN name is not provided
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    name,null,delete;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    name
    AND error message should be    can't be blank

Request should NOT create a user WHEN gender is invalid
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    gender,invalid,string;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    gender
    AND error message should be    can't be blank, can be male of female

Request should NOT create a user WHEN gender is an integer
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    gender,12312312,integer;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    gender
    AND error message should be    can't be blank, can be male of female

Request should NOT create a user WHEN gender is a decimal
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    gender,12312.312,decimal;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    gender
    AND error message should be    can't be blank, can be male of female
    
Request should NOT create a user WHEN gender is a boolean (true)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    gender,true,boolean;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    gender
    AND error message should be    can't be blank, can be male of female

Request should NOT create a user WHEN gender is a boolean (false)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    gender,false,boolean;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    gender
    AND error message should be    can't be blank, can be male of female

Request should NOT create a user WHEN email is invalid
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,${random_string},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    is invalid

Request should NOT create a user that has an existing inactive email
    [Setup]    an alphanumeric string with length    10
    GIVEN an inactive user has been created
    WHEN create user payload is modified    email,${email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    has already been taken
    [Teardown]    delete user is called

Request should NOT create a user that has an existing active email
    [Setup]    an alphanumeric string with length    10
    GIVEN an active user has been created
    WHEN create user payload is modified    email,${email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    has already been taken
    [Teardown]    delete user is called

Request should NOT create a user WHEN email is an integer
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,1231234,integer
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    is invalid

Request should NOT create a user WHEN email is a decimal
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,1231.234,decimal
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    is invalid

Request should NOT create a user WHEN email is a boolean (true)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,true,boolean
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    is invalid

Request should NOT create a user WHEN email is a boolean (false)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    email,false,boolean
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    email
    AND error message should be    is invalid

Request should NOT create a user WHEN status is invalid
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    status,invalid,string;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank

Request should NOT create a user WHEN status is an integer
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    status,7236871,integer;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank

Request should NOT create a user WHEN status is a decimal
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    status,7236.871,decimal;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank

Request should NOT create a user WHEN status is a boolean (true)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    status,true,boolean;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank

Request should NOT create a user WHEN status is a boolean (false)
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN create user payload is modified    status,false,boolean;email,${expected_email},string
    AND create user is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank