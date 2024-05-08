*** Settings ***
Documentation        Ações nos componentes de alertas

Library    Browser

*** Keywords ***

Alert shoud be
      [Arguments]    ${expected_text}
    ${element}    Set Variable    small[class=alert-error]

    Wait For Elements State    css=${element} >> text= ${expected_text}    visible    5