*** Settings ***
Resource      ../resource_collection.robot
Force Tags    retrieve-user-by-id

*** Test Cases ***
Request should NOT retrieve a user WHEN auth is invalid
    GIVEN an active user has been created
    WHEN get users by id is called    auth=invalid
    THEN response status code should be    401
    AND error message is received    Invalid token
    [Teardown]    delete user is called

Request should NOT retrieve a user WHEN auth is not provided
    GIVEN an active user has been created
    WHEN get users by id is called    auth=${None}
    THEN response status code should be    401
    AND error message is received    Invalid token
    [Teardown]    delete user is called

Request should retrieve a user WHEN id provided is existing
    GIVEN an active user has been created
    WHEN get users by id is called
    THEN response status code should be    200
    AND schema should be valid versus response    create-user_schema.json
    AND name should be    ${random_string}
    AND email should be    ${random_string}@sample.test
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should retrieve a user WHEN id provided is not existing
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get users by id is called    user_id=nonexisting
    THEN response status code should be    404
    AND error message is received    Resource not found

