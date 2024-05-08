*** Settings ***
Documentation    CRUD de Tasks


Library    Browser

*** Keywords ***

Access createTask confirm
    
    [Arguments]    ${expected_text}
    Wait For Elements State
    ...    css=div h1 >> text=${expected_text}    visible    5



Submit form task

    [Arguments]    ${task}

    Fill Text    css=input[name=name]   ${task}[name] 
      
    IF  @{task}[tags]
        
        ${tag_element}    Set Variable   css=input[name=tags]
        FOR  ${tag}  IN  @{task}[tags]
        Fill Text    ${tag_element}   ${tag}
        Press Keys   ${tag_element}    Enter
        Sleep    1
        END

    END
    Click    css=button[type=submit] >> text=Cadastrar
    Sleep    3

