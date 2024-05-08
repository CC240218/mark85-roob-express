*** Settings ***
Documentation        Ações nos componentes de notificação

Library    Browser

*** Keywords ***

Notice shoud be
    [Arguments]    ${expected_text}
    ${notice}    Set Variable    css=.notice p

    Wait For Elements State    ${notice}    visible    5
    Get Text                   ${notice}    equal    ${expected_text}




  