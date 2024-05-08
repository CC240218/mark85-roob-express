*** Settings ***
Documentation    Acesso a aplicação

# database
Library    libs/database.py
Library    JSONLibrary


# Componets
Resource    pages/Components/Header.resource
Resource    pages/Components/Alert.resource
Resource    pages/Components/Notice.resource


# Pages
Resource    ../resources/pages/SignupPage.resource
Resource    ../resources/pages/loginPage.resource   
Resource    ../resources/pages/CreatePage.resource
Resource    ../resources/pages/TaskPage.resource
Resource    ../resources/Services.resource

Library     Browser


*** Keywords ***

Start session
    
    New Browser    browser=${BROWSER}    headless=False
    New Page        ${BASE_URL}



#helped - metodos auxiliares
Get fixtures
    [Arguments]    ${file_name}    ${scenario}

    ${json}    Load Json From File    ${EXECDIR}/resources/fixtures/${file_name}.json    encoding=utf-8    

    RETURN    ${json}[${scenario}]


Reset user from database

    [Arguments]    ${user}
    
    Clean user from database        ${user}[email]
    Insert user database            ${user}