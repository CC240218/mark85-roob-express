*** Settings ***
Documentation        Ações nos componentes de notificação



Library    String
Library    Browser

*** Keywords ***

Login user logged in confirm

    [Arguments]    ${expected_text}
    @{Splited_name}    Split String    ${expected_text}
    ${elemnt}    Set Variable    header .right small

    Wait For Elements State    css=${elemnt}    visible    5
    Get Text    css= ${elemnt}   equal   Olá, ${Splited_name}[0]

Signout user

    Click    css=button[type=button][class=signout]

Click new task

    Click    css=button[type=button][class=button-add]