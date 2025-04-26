*** Settings ***
Resource      ../resource_collection.robot
Force Tags    create-post

*** Test Cases ***
Request should NOT create post WHEN auth is invalid
    GIVEN a user is existing
    WHEN create post is called    auth=invalid
    THEN response status code should be    401
    AND error message is received    Invalid token

Request should NOT create post WHEN auth is not provided
    GIVEN a user is existing
    WHEN create post is called    auth=${None}
    THEN response status code should be    401
    AND error message is received    Invalid token

Request should create post WHEN valid user id is provided
    GIVEN a user is existing
    WHEN create post is called
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    ${random_post_title}
    AND post body should be    ${random_post_body}

Request should NOT create post WHEN invalid user id is provided
    GIVEN a user is not existing
    WHEN create post is called
    THEN response status code should be    422
    AND error field should be    user
    AND error message should be    must exist

Request should create post WHEN title is integer
    GIVEN a user is existing
    WHEN create post payload is modified    title,123123123,integer
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    123123123
    AND post body should be    ${random_post_body}

Request should create post WHEN title is decimal
    GIVEN a user is existing
    WHEN create post payload is modified    title,123123.123,decimal
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    123123.123
    AND post body should be    ${random_post_body}

Request should create post WHEN title is boolean (true)
    GIVEN a user is existing
    WHEN create post payload is modified    title,true,boolean
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    t
    AND post body should be    ${random_post_body}

Request should create post WHEN title is boolean (false)
    GIVEN a user is existing
    WHEN create post payload is modified    title,false,boolean
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    f
    AND post body should be    ${random_post_body}

Request should NOT create post WHEN title is null
    GIVEN a user is existing
    WHEN create post payload is modified    title,null,null
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    title
    AND error message should be    can't be blank

Request should NOT create post WHEN title is empty
    GIVEN a user is existing
    WHEN create post payload is modified    title,${EMPTY},string
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    title
    AND error message should be    can't be blank

Request should NOT create post WHEN title is not provided
    GIVEN a user is existing
    WHEN create post payload is modified    title,null,delete
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    title
    AND error message should be    can't be blank

Request should create post WHEN body is integer
    GIVEN a user is existing
    WHEN create post payload is modified    body,123123123,integer
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    ${random_post_title}
    AND post body should be    123123123

Request should create post WHEN body is decimal
    GIVEN a user is existing
    WHEN create post payload is modified    body,123123.123,decimal
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    ${random_post_title}
    AND post body should be    123123.123

Request should create post WHEN body is boolean (true)
    GIVEN a user is existing
    WHEN create post payload is modified    body,true,boolean
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    ${random_post_title}
    AND post body should be    t

Request should create post WHEN body is boolean (false)
    GIVEN a user is existing
    WHEN create post payload is modified    body,false,boolean
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    201
    AND schema should be valid versus response    create-post_schema.json
    AND post user id should be    ${USER_ID}
    AND post title should be    ${random_post_title}
    AND post body should be    f

Request should NOT create post WHEN body is null
    GIVEN a user is existing
    WHEN create post payload is modified    body,null,null
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    body
    AND error message should be    can't be blank

Request should NOT create post WHEN body is empty
    GIVEN a user is existing
    WHEN create post payload is modified    body,${EMPTY},string
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    body
    AND error message should be    can't be blank

Request should NOT create post WHEN body is not provided
    GIVEN a user is existing
    WHEN create post payload is modified    body,null,delete
    AND create post is called    payload_type=modified_payload
    THEN response status code should be    422
    AND error field should be    body
    AND error message should be    can't be blank