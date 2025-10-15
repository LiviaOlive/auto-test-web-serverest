*** Settings ***
Documentation     Testes Web de Autenticação e Cadastro no ServeRest
Resource          ../resources/keywords.robot
Test Setup       Abrir Navegador
Test Teardown    Fechar Navegador

*** Test Cases ***
TC-WEB-CAD-001: Cadastro de novo usuário
    [Documentation]    Testa o cadastro de um novo usuário
    [Tags]    web    cadastro    cliente    positivo    order:1
    Acessar Página de Cadastro
    ${timestamp}=    Get Time    epoch
    ${email_novo}=    Set Variable    usuario${timestamp}@qa.com.br
    Preencher Formulário de Cadastro    ${NEW_USER_NAME}    ${email_novo}    ${NEW_USER_PASSWORD}
    Submeter Cadastro
    Wait Until Page Contains    ${SUCCESS_MESSAGE}    timeout=5s
    Set Global Variable    ${LAST_USER_EMAIL}    ${email_novo}
    Go To    ${URL}

TC-WEB-CAD-002: Cadastro de administrador
    [Documentation]    Testa o cadastro de um usuário administrador
    [Tags]    web    cadastro    admin    positivo    order:2
    Acessar Página de Cadastro
    ${timestamp}=    Get Time    epoch
    ${email_admin}=    Set Variable    admin${timestamp}@qa.com.br
    Preencher Formulário de Cadastro    ${NEW_ADMIN_NAME}    ${email_admin}    ${NEW_ADMIN_PASSWORD}    ${TRUE}
    Submeter Cadastro
    Wait Until Page Contains    ${SUCCESS_MESSAGE}    timeout=5s
    Set Global Variable    ${LAST_ADMIN_EMAIL}    ${email_admin}
    Go To    ${URL}

TC-WEB-CAD-003: Cadastro com email já existente
    [Documentation]    Testa o cadastro com email já utilizado
    [Tags]    web    cadastro    negativo    order:3
    Acessar Página de Cadastro
    Preencher Formulário de Cadastro    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}
    Submeter Cadastro
    Wait Until Page Contains    Este email já está sendo usado

TC-WEB-AUTH-001: Login com credenciais válidas (cliente)
    [Documentation]    Testa login web com credenciais de cliente
    [Tags]    web    auth    cliente    positivo    order:4
    Login Como Cliente
    Location Should Contain    /home
    Capture Page Screenshot

TC-WEB-AUTH-002: Login com credenciais válidas (administrador)
    [Documentation]    Testa login web com credenciais de administrador
    [Tags]    web    auth    admin    positivo    order:5
    Login Como Administrador
    Location Should Contain    /home
    Capture Page Screenshot

TC-WEB-AUTH-003: Login com credenciais inválidas
    [Documentation]    Testa login web com credenciais inválidas
    [Tags]    web    auth    negativo    order:6
    Input Text    ${INPUT_EMAIL}    email.invalido@teste.com
    Input Text    ${INPUT_PASSWORD}    senhaerrada
    Click Element    ${BUTTON_LOGIN}
    Wait Until Page Contains    ${ERROR_MESSAGE}
    Capture Page Screenshot