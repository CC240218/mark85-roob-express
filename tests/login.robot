*** Settings ***
Documentation    home,login

Library    Collections
Library    Browser
Resource    ../resources/base.resource

Test Setup    Start session
Test Teardown    Take Screenshot


*** Test Cases ***

Deve direcionar para tela de login    # Checa se a tela home, está online

    [Tags]    home
    
    # Page Object
    Go to home page    Faça seu login
    # -----------

Nao deve logar um usuario sem cadastro    # Validação de usuário sem cadastro

    [Tags]    noLogin

#'''''''''''''''''' Super variavel ''''''''''''''''''''''''
     ${user}    Create Dictionary
    ...    email=sem_cadastro@teste.com.br
    ...    password=teste
#---------------------------------------------------------


#''''''''''''''''''''' database ''''''''''''''''''''''''''
    Remove user database    ${user}[email]
#---------------------------------------------------------


#'''''''''''''''''' ''Page Object ''''''''''''''''''''''''
    Go to home page    Faça seu login
    Submit user login    ${user}
    Notice shoud be
    ...    Ocorreu um erro ao fazer login, verifique suas credenciais.
#''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Nao deve logar com senha incorreta
    
    [Tags]    pass_incorrect
     # Massa de teste do tipo super variavel
     ${user}    Create Dictionary
     ...   name=Rafa Senha Errada /HOME
    ...    email=senha_errada@teste.com.br
    ...    password=123456
    #  --------------------

    # Database.py
    Remove user database    ${user}[email]
    Insert user database    ${user}
    #---------

    # Library Collection
    Set To Dictionary    ${user}    password=abcdefg
    #  ---- - -------- -

    # Page Object
    Go to home page    Faça seu login
    Submit user login    ${user}
    Notice shoud be
    ...    Ocorreu um erro ao fazer login, verifique suas credenciais.
    #  ----------

Nao deve logar sem informar os dados obrigatorios    # Validação dos campos vazios

    [Tags]    required   

    # massa de teste do tipo super variavel
     ${user}    Create Dictionary
    ...    email=${EMPTY}
    ...    password=${EMPTY}
    # -------------------------

    # Page Object
    Go to home page    Faça seu login
    Submit user login    ${user}
    Alert shoud be    Informe seu e-mail
    Alert shoud be    Informe sua senha
    #  ------------0-

Deve logar o usuario    # Digita nos campos e efetua o login 
    [Tags]    loginUser

     ${user}    Create Dictionary
     ...   name=Rafa login /HOME
    ...    email=teste_login@teste.com
    ...    password=123456

    # Database.py
    Remove user database    ${user}[email]
    Insert user database    ${user}
    #---------

    # Page Object
    Go to home page    Faça seu login
    Submit user login    ${user}
    Login user logged in confirm     ${user}[name]
    # -------- --


Deve direcionar da home para cadastro    # Clica em um link que direciona para o cadastro

    [Tags]    homeGOsignup

    # Page Object
    Go to home page    Faça seu login
    from login to signup    Faça seu cadastro
    #- - - -   ---

