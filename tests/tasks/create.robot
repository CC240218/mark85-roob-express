*** Settings ***
Documentation    Cadastro de tarefas



Resource    ../../resources/base.resource

Test Setup    Start session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve cadastrar uma nova tarefa
   [Tags]    newtask
# ------------------------ Json --------------------------------
    ${fixtures}    Get fixtures    tasks    createTask
    
# --------------------------------------------------------------

# ---------------------- database ------------------------------
    # Clean user from database         ${fixtures}[user][email]
    # Insert user database             ${fixtures}[user]
    Reset user from database    ${fixtures}[user]
    
# --------------------------------------------------------------


# --------------------- PageObject -------------------------------
    Submit user login               ${fixtures}[user]
    Login user logged in confirm    ${fixtures}[user][name]

    Click new task
    Access createTask confirm        Cadastrar Tarefa
    Submit form task                ${fixtures}[task1]

    Click new task
    Submit form task                ${fixtures}[task2]

    Click new task
    Submit form task                ${fixtures}[task3]

    Task registered shoud be        ${fixtures}[task1][name]
    Task registered shoud be        ${fixtures}[task2][name]
    Task registered shoud be        ${fixtures}[task3][name]
# --------------------------------------------------------------


Não deve cadastrar tarefas sem nome

    [Tags]    nameEMPTY

# ------------------------ Json --------------------------------
    ${fixtures}    Get fixtures    tasks    userValidation
# --------------------------------------------------------------

# ---------------------- database ------------------------------
    Clean user from database        ${fixtures}[user][email]
    Insert user database            ${fixtures}[user]
# --------------------------------------------------------------

# --------------------- PageObject -------------------------------
    Submit user login               ${fixtures}[user]
    Login user logged in confirm    ${fixtures}[user][name]

    Click new task
    Access createTask confirm        Cadastrar Tarefa

    Submit form task                ${fixtures}[noNameTask]
    Alert shoud be                   Campo obrigatório
# --------------------------------------------------------------

Não deve cadastrar a task acima de 3 tags

    [Tags]    tagLimit
# ------------------------ Json --------------------------------
     ${fixtures}    Get fixtures    tasks    userValidation
# --------------------------------------------------------------


# ---------------------- database ------------------------------
    Clean user from database        ${fixtures}[user][email]
    Insert user database            ${fixtures}[user]
# --------------------------------------------------------------

# --------------------- PageObject -------------------------------
    Submit user login                ${fixtures}[user]
    Login user logged in confirm     ${fixtures}[user][name]

    Click new task
    Access createTask confirm        Cadastrar Tarefa
    Submit form task                ${fixtures}[taskError]

    Notice shoud be                  Oops! Limite de tags atingido.
# --------------------------------------------------------------


Não deve cadastrar task de nome duplicado

    [Tags]    dupli
#------------------------'Json'----------------------------- ---
    ${ficture}    Get fixtures    tasks    create
#---------------------------------------------------------------

#---------------------- database -------------------------------
    Clean user from database        ${ficture}[user][email]
    Insert user database            ${ficture}[user]
#---------------------------"-----------------------------------

#---------------------- POST API -------------------------------
    POST a user sessions            ${ficture}[user]
    POST a new task                 ${ficture}[task]
#---------------------------------------------------------------

#---------------------- PageObject ----------------------------- 
    Submit user login                ${ficture}[user]
    Login user logged in confirm     ${ficture}[user][name]
    Click new task
    Submit form task                 ${ficture}[task]
    Notice shoud be                    Oops! Tarefa duplicada.
#---------------------------------------------------------------

    