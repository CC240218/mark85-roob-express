*** Settings ***
Documentation    Pagina de tarefas

Library    Browser

*** Keywords ***

Task registered shoud be
    
    [Arguments]    ${task_name}

    Wait For Elements State
    ...    css=.task-todo >> text=${task_name}    visible    5

Task shoud be complete

    [Arguments]    ${task_name}

    ${element}    Set Variable     css=.task-done >> text=${task_name}
    Wait For Elements State        ${element}    visible    5

    Get Style                      ${element}
    ...    text-decoration-line    equal    line-through


Mark task as complited
    [Arguments]    ${task_text}
    
    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_text}"]/..//button[@class="item-toggle"]

    Wait For Elements State        ${element}    visible    5
    
    Click                          ${element}


Task request removal
    [Arguments]    ${text}

    ${element}    Set Variable
    ...    xpath=//strong[text()="${text}"]/..//button[@class="task-remove"]

    Wait For Elements State        ${element}    visible    5
    Click                          ${element}


Task registered not exist
    
    [Arguments]    ${task_name}

    Wait For Elements State
    ...    css=.task-todo >> text=${task_name}    detached    5


