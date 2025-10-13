*** Settings ***
Documentation    Testes de Autenticação da API ServeRest
Library          RequestsLibrary
Library          JSONLibrary
Library          Collections
Resource         ../resources/variables.robot
Resource         ../resources/keywords.robot
Suite Setup      Setup Test Environment

*** Test Cases ***
TC-AUTH-001: Login com credenciais válidas (admin)
    [Documentation]    Testa login com credenciais de administrador
    [Tags]    auth    admin    positivo
    
    # Preparar dados do request
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${login_data}=    Create Dictionary    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    
    # Realizar requisição POST /login
    ${response}=    POST On Session    serverest    /login    json=${login_data}    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    authorization
    Should Contain    ${response.json()}    message
    
    # Validar que o token é válido (não vazio)
    ${token}=    Get Value From Json    ${response.json()}    $.authorization
    Should Not Be Empty    ${token[0]}
    
    # Validar mensagem de sucesso
    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal    ${message[0]}    Login realizado com sucesso

TC-AUTH-002: Login com credenciais válidas (cliente)
    [Documentation]    Testa login com credenciais de cliente
    [Tags]    auth    cliente    positivo
    
    # Preparar dados do request
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${login_data}=    Create Dictionary    email=${CLIENT_EMAIL}    password=${CLIENT_PASSWORD}
    
    # Realizar requisição POST /login
    ${response}=    POST On Session    serverest    /login    json=${login_data}    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    authorization
    Should Contain    ${response.json()}    message
    
    # Validar que o token é válido (não vazio)
    ${token}=    Get Value From Json    ${response.json()}    $.authorization
    Should Not Be Empty    ${token[0]}
    
    # Validar mensagem de sucesso
    ${message}=    Get Value From Json    ${response.json()}    $.message
    Should Be Equal    ${message[0]}    Login realizado com sucesso