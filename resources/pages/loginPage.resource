*** Settings ***
Documentation    Actions do login

Library    Browser


*** Keywords ***

Go to home page    
    
    [Arguments]    ${cheked_text}
    ${elemnt}    Set Variable    xpath=//h1
    
    
    Wait For Elements State    ${elemnt}    visible    5
    Get Text                   ${elemnt}    equal    ${cheked_text}



Submit user login

    [Arguments]    ${user}

    Fill Text    css=input[name=email]        ${user}[email]
    Fill Text    css=input[name=password]     ${user}[password]

    Click        css=button[type=submit]


from login to signup 

    Click    xpath=//*[@id="root"]/div/div[1]/div/a

    [Arguments]    ${expected_text}
    ${element}    Set Variable    css=h1

    Wait For Elements State    ${element}    visible    3
    Get Text                   ${element}    equal    ${expected_text}