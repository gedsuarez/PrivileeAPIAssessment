*** Settings ***
Resource      ../resource_collection.robot
Force Tags    retrieve-user-by-list

*** Test Cases ***
Request should NOT retrieve a list of users WHEN auth is invalid
    GIVEN an active user has been created
    WHEN get all users is called    auth=invalid
    THEN response status code should be    401
    AND error message is received    Invalid token
    [Teardown]    delete user is called

Request should NOT retrieve a list of users WHEN auth is not provided
    GIVEN an active user has been created
    WHEN get all users is called    auth=${None}
    THEN response status code should be    401
    AND error message is received    Invalid token
    [Teardown]    delete user is called

Request should retrieve a list of users WHEN name provided is existing
    GIVEN an active user has been created
    WHEN get all users is called    name=${name}
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND name should be    ${random_string}
    AND email should be    ${random_string}@sample.test
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should NOT retrieve a user WHEN name provided is not existing
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    name=nonexisting
    THEN response status code should be    200
    AND response should be empty

Request should retrieve a list of users WHEN email provided is existing
    GIVEN an active user has been created
    WHEN get all users is called    email=${email}
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND name should be    ${random_string}
    AND email should be    ${random_string}@sample.test
    AND gender should be    male
    AND status should be     active
    [Teardown]    delete user is called

Request should NOT retrieve a user WHEN email provided is not existing
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    email=${random_string}@sample.test
    THEN response status code should be    200
    AND response should be empty

Request should retrieve a list of users WHEN gender provided is male
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    gender=male
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND all users in the list have the gender male

Request should retrieve a list of users WHEN gender provided is female
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    gender=female
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND all users in the list have the gender female

Request should NOT retrieve a user WHEN gender provided is not existing
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    gender=nonexisting
    THEN response status code should be    200
    AND response should be empty

Request should retrieve a list of users WHEN status provided is active
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    status=active
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND all users in the list have the status active

Request should retrieve a list of users WHEN status provided is inactive
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    status=inactive
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND all users in the list have the status inactive

Request should NOT retrieve a user WHEN status provided is not existing
    [Setup]    an alphanumeric string with length    10
    GIVEN the email is not existing    email=${random_string}@sample.test
    WHEN get all users is called    status=nonexisting
    THEN response status code should be    200
    AND response should be empty

Request should retrieve a list of users WHEN multiple parameters are provided
    GIVEN an active user has been created
    WHEN get all users is called    name=${random_string}    email=${random_string}@sample.test    gender=male    status=active
    THEN response status code should be    200
    AND schema should be valid versus response    retrieve-user-list_schema.json
    AND all users in the list have the name
    AND all users in the list have the email
    AND all users in the list have the gender male
    AND all users in the list have the status active
    [Teardown]    delete user is called