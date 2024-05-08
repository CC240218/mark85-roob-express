*** Settings ***
Documentation    Variaveis globais e configurações de ambiente

Library    Browser

*** Variables ***
${BASE_URL}    http://localhost:3000
${BROWSER}     chromium



*** Keywords ***
go to signup
    Go To      ${BASE_URL}/signup
    
go to tasks
    Go To     ${BASE_URL}/tasks

go to create
    Go To    ${BASE_URL}/create