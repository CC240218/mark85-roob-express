*** Settings ***
Documentation    Interagindo com as tarefas

Library    Browser
Resource    ../../resources/base.resource

Test Setup    Start session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve excluir uma tarefa
    [Tags]    taskDelete

# ------------------------ Json --------------------------------
    ${fixtures}    Get fixtures    tasks    createTask
# --------------------------------------------------------------

# ---------------------- database ------------------------------
    Clean user from database    ${fixtures}[user][email]
    Insert user database        ${fixtures}[user]
    Insert task user            ${fixtures}[user][email]    ${fixtures}[task1][name]
    Insert task user            ${fixtures}[user][email]    ${fixtures}[task2][name]
# --------------------------------------------------------------

# --------------------- PageObject -------------------------------
    Submit user login           ${fixtures}[user]
    Task registered shoud be    ${fixtures}[task1][name]
    Task request removal        ${fixtures}[task1][name]
    Task registered not exist   ${fixtures}[task1][name]
# --------------------------------------------------------------