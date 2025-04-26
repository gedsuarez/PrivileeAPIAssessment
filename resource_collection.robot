*** Settings ***
#Environment Variables
Resource    environment_variables.robot

#Assertions
Resource    resources/keywords/assertions/common.robot
Resource    resources/keywords/assertions/errors.robot
Resource    resources/keywords/assertions/posts.robot
Resource    resources/keywords/assertions/todos.robot
Resource    resources/keywords/assertions/users.robot

#Utilities
Resource    resources/keywords/utilities/common.robot
Resource    resources/keywords/utilities/posts.robot
Resource    resources/keywords/utilities/todos.robot
Resource    resources/keywords/utilities/users.robot

#Requests
Resource    resources/requests/users-get/request.robot
Resource    resources/requests/users-post/request.robot
Resource    resources/requests/users.id-delete/request.robot
Resource    resources/requests/users.id-get/request.robot
Resource    resources/requests/users.user_id.posts-post/request.robot
Resource    resources/requests/users.user_id.todos-post/request.robot