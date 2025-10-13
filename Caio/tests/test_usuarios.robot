*** Settings ***
Documentation    Testes de Usuários da API ServeRest
Library          RequestsLibrary
Library          JSONLibrary
Library          Collections
Resource         ../resources/variables.robot
Resource         ../resources/keywords.robot
Suite Setup      Setup Test Environment

*** Test Cases ***
TC-USR-001: Listar todos os usuários
    [Documentation]    Testa listagem de todos os usuários com token admin
    [Tags]    usuarios    admin    positivo
    
    # Realizar login e obter token admin
    ${admin_token}=    Realizar Login Admin
    
    # Preparar headers com token
    ${headers}=    Criar Headers Com Token    ${admin_token}
    
    # Realizar requisição GET /usuarios
    ${response}=    GET On Session    serverest    /usuarios    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    usuarios
    Should Contain    ${response.json()}    quantidade
    
    # Validar estrutura da resposta
    ${usuarios}=    Get Value From Json    ${response.json()}    $.usuarios
    ${quantidade}=    Get Value From Json    ${response.json()}    $.quantidade
    Should Not Be Empty    ${usuarios[0]}
    Should Be True    ${quantidade[0]} > 0
    
    # Validar estrutura do primeiro usuário
    ${primeiro_usuario}=    Set Variable    ${usuarios[0][0]}
    Should Contain    ${primeiro_usuario}    _id
    Should Contain    ${primeiro_usuario}    nome
    Should Contain    ${primeiro_usuario}    email
    Should Contain    ${primeiro_usuario}    password
    Should Contain    ${primeiro_usuario}    administrador

TC-USR-002: Buscar usuário por ID
    [Documentation]    Testa busca de usuário específico por ID
    [Tags]    usuarios    admin    positivo
    
    # Realizar login e obter token admin
    ${admin_token}=    Realizar Login Admin
    
    # Primeiro, listar usuários para obter um ID válido
    ${headers}=    Criar Headers Com Token    ${admin_token}
    ${response}=    GET On Session    serverest    /usuarios    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    
    # Obter ID do primeiro usuário
    ${usuarios}=    Get Value From Json    ${response.json()}    $.usuarios
    ${user_id}=    Get Value From Json    ${usuarios[0]}    $[0]._id
    
    # Realizar requisição GET /usuarios/{id}
    ${response}=    GET On Session    serverest    /usuarios/${user_id[0]}    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    _id
    Should Contain    ${response.json()}    nome
    Should Contain    ${response.json()}    email
    Should Contain    ${response.json()}    password
    Should Contain    ${response.json()}    administrador
    
    # Validar que o ID retornado é o mesmo solicitado
    ${returned_id}=    Get Value From Json    ${response.json()}    $._id
    Should Be Equal    ${returned_id[0]}    ${user_id[0]}