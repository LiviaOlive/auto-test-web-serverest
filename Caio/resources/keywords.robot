*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Resource   variables.robot

*** Keywords ***
Setup Test Environment
    Create Session    serverest    ${BASE_URL}
    
Realizar Login Admin
    [Documentation]    Realiza login com credenciais de administrador
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${login_data}=    Create Dictionary    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    ${response}=    POST On Session    serverest    /login    json=${login_data}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${token}=    Get Value From Json    ${response.json()}    $.authorization
    RETURN    ${token[0]}

Realizar Login Cliente
    [Documentation]    Realiza login com credenciais de cliente
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${login_data}=    Create Dictionary    email=${CLIENT_EMAIL}    password=${CLIENT_PASSWORD}
    ${response}=    POST On Session    serverest    /login    json=${login_data}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${token}=    Get Value From Json    ${response.json()}    $.authorization
    # Para obter o ID do usuário, precisamos fazer uma consulta adicional
    ${headers_with_token}=    Criar Headers Com Token    ${token[0]}
    ${user_response}=    GET On Session    serverest    url=/usuarios    params=email=${CLIENT_EMAIL}    headers=${headers_with_token}
    ${usuarios}=    Get Value From Json    ${user_response.json()}    $.usuarios
    ${user_id}=    Get Value From Json    ${usuarios[0]}    $[0]._id
    RETURN    ${token[0]}    ${user_id[0]}

Criar Headers Com Token
    [Arguments]    ${token}
    [Documentation]    Cria headers com Authorization Bearer token
    ${headers}=    Create Dictionary    
    ...    Content-Type=${CONTENT_TYPE}
    ...    Authorization=Bearer ${token}
    RETURN    ${headers}

Obter Primeiro Produto ID
    [Arguments]    ${token}
    [Documentation]    Obtém o ID do primeiro produto disponível
    ${headers}=    Criar Headers Com Token    ${token}
    ${response}=    GET On Session    serverest    /produtos    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${produtos}=    Get Value From Json    ${response.json()}    $.produtos
    ${primeiro_produto_id}=    Get Value From Json    ${produtos[0]}    $[0]._id
    RETURN    ${primeiro_produto_id[0]}