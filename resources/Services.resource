*** Settings ***
Documentation    Consumindo a API REST

Library    RequestsLibrary

*** Keywords ***

POST a user create

    [Arguments]    ${user}

    ${payload}    Create Dictionary    
    ...    name=${user}[name]    
    ...    email=${user}[email]    
    ...    password=${user}[password]
    ${resp}    POST    
    ...    url=http://localhost:3333/users    
    ...    json=${payload}    
    ...    expected_status=201
    

POST a user sessions

    [Arguments]    ${user}

    ${payload}    Create Dictionary    
    ...    email=${user}[email]    
    ...    password=${user}[password]

    ${resp}    POST    
    ...    url=http://localhost:3333/sessions
    ...    json=${payload}   
    ...    expected_status=200

    ${token}    Set Variable    ${resp.json()}[token]
    Set Test Variable    ${token}

POST a new task

    [Arguments]    ${payload}

    ${headers}    Create Dictionary    
    ...    Authorization=${token}

    POST    
    ...    url=http://localhost:3333/tasks
    ...    json=${payload}
    ...    headers=${headers}    
    ...    expected_status=201