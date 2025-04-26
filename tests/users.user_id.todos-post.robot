*** Settings ***
Resource      ../resource_collection.robot
Force Tags    create-todo

*** Test Cases ***
Request should NOT create todo WHEN auth is invalid
    GIVEN a user is existing
    WHEN create todo is called    auth=invalid
    THEN response status code should be    401
    AND error message is received    Invalid token

Request should NOT create todo WHEN auth is not provided
    GIVEN a user is existing
    WHEN create todo is called    auth=${None}
    THEN response status code should be    401
    AND error message is received    Invalid token

Request should create todo WHEN valid user id is provided
    GIVEN a user is existing
    WHEN create todo is called
    THEN response status code should be    201
    AND schema should be valid versus response    create-todo_schema.json
    AND todo user id should be    ${USER_ID}
    AND todo title should be    ${random_todo_title}
    AND todo status should be    pending

Request should NOT create todo WHEN invalid user id is provided
    GIVEN a user is not existing
    WHEN create todo is called
    THEN response status code should be    422
    AND error field should be    user
    AND error message should be    must exist

Request should create todo WHEN title is integer
    GIVEN a user is existing
    WHEN create todo payload is modified    title,123123123,integer
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-todo_schema.json
    AND todo user id should be    ${USER_ID}
    AND todo title should be    123123123
    AND todo status should be    pending

Request should create todo WHEN title is decimal
    GIVEN a user is existing
    WHEN create todo payload is modified    title,123123.123,decimal
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-todo_schema.json
    AND todo user id should be    ${USER_ID}
    AND todo title should be    123123.123
    AND todo status should be    pending

Request should create todo WHEN title is boolean (true)
    GIVEN a user is existing
    WHEN create todo payload is modified    title,true,boolean
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-todo_schema.json
    AND todo user id should be    ${USER_ID}
    AND todo title should be    t
    AND todo status should be    pending

Request should create todo WHEN title is boolean (false)
    GIVEN a user is existing
    WHEN create todo payload is modified    title,false,boolean
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-todo_schema.json
    AND todo user id should be    ${USER_ID}
    AND todo title should be    f
    AND todo status should be    pending

Request should NOT create todo WHEN title is null
    GIVEN a user is existing
    WHEN create todo payload is modified    title,null,null
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    title
    AND error message should be    can't be blank

Request should NOT create todo WHEN title is empty
    GIVEN a user is existing
    WHEN create todo payload is modified    title,${EMPTY},string
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    title
    AND error message should be    can't be blank

Request should NOT create todo WHEN title is not provided
    GIVEN a user is existing
    WHEN create todo payload is modified    title,null,delete
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    title
    AND error message should be    can't be blank

Request should create todo WHEN status provided is completed
    GIVEN a user is existing
    WHEN create todo payload is modified    status,completed,string
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-todo_schema.json
    AND todo user id should be    ${USER_ID}
    AND todo title should be    ${random_todo_title}
    AND todo status should be    completed

Request should NOT create todo WHEN status is integer
    GIVEN a user is existing
    WHEN create todo payload is modified    status,123123123,integer
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed

Request should NOT create todo WHEN status is decimal
    GIVEN a user is existing
    WHEN create todo payload is modified    status,123123.123,decimal
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed

Request should NOT create todo WHEN status is boolean (true)
    GIVEN a user is existing
    WHEN create todo payload is modified    status,true,boolean
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed

Request should NOT create todo WHEN status is boolean (false)
    GIVEN a user is existing
    WHEN create todo payload is modified    status,false,boolean
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed

Request should NOT create todo WHEN status is null
    GIVEN a user is existing
    WHEN create todo payload is modified    status,null,null
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed

Request should NOT create todo WHEN status is empty
    GIVEN a user is existing
    WHEN create todo payload is modified    status,${EMPTY},string
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed

Request should NOT create todo WHEN status is not provided
    GIVEN a user is existing
    WHEN create todo payload is modified    status,null,delete
    AND create todo is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    status
    AND error message should be    can't be blank, can be pending or completed
