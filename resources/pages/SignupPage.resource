*** Settings ***
Documentation    Actions da pagina signup

Library    Browser
Resource    ../env.resource

*** Keywords ***

Go to signup page
    
    
    Go to signup
    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   xpath=//h1[text()="Faça seu cadastro"]    equal    Faça seu cadastro

Submit signup form
    [Arguments]    ${user}

    Fill Text                  id=name    ${user}[name]
    Fill Text                  css=#email   ${user}[email]
    Fill Text                  id=password   ${user}[password]

    Click                      id=buttonSignup
 

