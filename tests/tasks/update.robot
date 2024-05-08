*** Settings ***
Documentation    Interagindo com as tarefas

Library    Browser
Resource    ../../resources/base.resource

Test Setup    Start session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve marcar uma tarefa como feita
    
    [Tags]    donetask

# ------------------------ Json --------------------------------
    ${fixtures}    Get fixtures    tasks    create
# --------------------------------------------------------------

# ---------------------- database ------------------------------
    Reset user from database       ${fixtures}[user]
# --------------------------------------------------------------

#------------------------ POST API -----------------------------
    POST a user sessions            ${fixtures}[user]
    POST a new task                 ${fixtures}[task]
#---------------------------------------------------------------

# --------------------- PageObject -----------------------------
    Submit user login                ${fixtures}[user]
    Login user logged in confirm     ${fixtures}[user][name]

    Mark task as complited           ${fixtures}[task][name]
    Task shoud be complete           ${fixtures}[task][name]

# --------------------------------------------------------------


Deve deslogar o usuário
    
    [Tags]    signout

# ------------------------ Json --------------------------------
    ${fixtures}    Get fixtures    tasks    create
# --------------------------------------------------------------

# ---------------------- database ------------------------------
    Reset user from database    ${fixtures}[user]
# --------------------------------------------------------------

# --------------------- PageObject -------------------------------
    Submit user login           ${fixtures}[user]
    Signout user
    Go to home page             Faça seu login
# --------------------------------------------------------------


