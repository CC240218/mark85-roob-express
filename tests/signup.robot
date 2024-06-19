*** Settings ***
Documentation    Cadastro de usuário

Resource    ../resources/base.resource

Test Setup    Start session   
Test Teardown    Take Screenshot


*** Test Cases ***

Não deve cadastrar usuario com email repetido

    [Tags]    email_repetido
    
    ${data}    Get fixtures    tasks    create


    # database.py
    Remove user database    ${data}[user][email]
    Insert user database    ${data}[user]
    #------------

    # Page Object
    Go to signup page
    Submit signup form    ${data}[user]
    Notice shoud be    Oops! Já existe uma conta com o e-mail informado.
    # -----------

Deve validar os campos obrigatorios do cadastro

    [Tags]    required

    # Massa de teste do tipo super variavel
    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}
    # -----------

    # Page Object
    go to signup
    Submit signup form    ${user}
    Alert shoud be    Informe seu nome completo
    Alert shoud be   Informe seu e-email
    Alert shoud be    Informe uma senha com pelo menos 6 digitos
    # ----------

Não deve cadastrar usuário com email inválido

     [Tags]    invalidEmail

    # Massa de teste do tipo super variavel
    ${user}    Create Dictionary
    ...    name= Rafa Email Imválido /SIGNUP
    ...    email= rafael@email-invalido
    ...    password= 123456
    # -----------

    # Page Object
    go to signup
    Submit signup form    ${user}
    Alert shoud be    Digite um e-mail válido
    # '''-------'


Não deve cadastrar senha com menos de 6 digitos 
   
    [Tags]    password
    
    # Massa de teste do tipo lista
    @{password_list}    Create List
    ...    1
    ...    12
    ...    123
    ...    1234
    ...    12345
    # ------------------

    # Laço com massa de teste (Super variavel + lista)
    FOR  ${pass}  IN  @{password_list}
         ${user}    Create Dictionary
    ...    name=Rafa Senha 6 digitos /SIGNUP
    ...    email=rafael_Senha@gmail.com
    ...    password=${pass}

        go to signup
        Submit signup form    ${user}
        Alert shoud be    Informe uma senha com pelo menos 6 digitos
    END
    # ------------------

Deve cadastrar um usuario
    
    [Tags]    cadastrar
    
    # Massa de teste do tipo super variavel
    ${user}    Create Dictionary
    ...    name=Rafael Cadastro /SIGNUP
    ...    email=teste_cadastro@nagem.com
    ...    password=123456
    # ------------

    # database.py
    Remove user database    ${user}[email]
    # ---------

    # Page Object
    Go to signup page
    Submit signup form    ${user}
    Notice shoud be    Boas vindas ao Mark85, o seu gerenciador de tarefas.
    # -----------

Teste criar usuário via API

    [Tags]    test

    ${fixture}    Get fixtures    tasks    create
    Clean user from database    ${fixture}[user][email]
    POST a user create    ${fixture}[user]


#Template de teste
*** Keywords ***

# Password for less 6 caracters

#     [Arguments]    ${pass}
#     ${user}    Create Dictionary
#     ...    name=Rafa teste master
#     ...    email=rafael@gmail.com
#     ...    password=${pass}

#     go to signup
#     Submit signup form    ${user}
#     Alert signup shoud be    Informe uma senha com pelo menos 6 digitos

