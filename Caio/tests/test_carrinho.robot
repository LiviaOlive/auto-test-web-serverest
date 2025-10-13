*** Settings ***
Documentation    Testes de Carrinho da API ServeRest
Library          RequestsLibrary
Library          JSONLibrary
Library          Collections
Resource         ../resources/variables.robot
Resource         ../resources/keywords.robot
Suite Setup      Setup Test Environment

*** Test Cases ***


TC-CART-002: Listar carrinhos do usuário
    [Documentation]    Testa listagem de carrinhos com token de cliente
    [Tags]    carrinho    cliente    positivo
    
    # Realizar login como cliente
    ${client_token}    ${user_id}=    Realizar Login Cliente
    
    # Preparar headers com token
    ${headers}=    Criar Headers Com Token    ${client_token}
    
    # Realizar requisição GET /carrinhos
    ${response}=    GET On Session    serverest    /carrinhos    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    carrinhos
    Should Contain    ${response.json()}    quantidade
    
    # Validar estrutura da resposta
    ${carrinhos}=    Get Value From Json    ${response.json()}    $.carrinhos
    ${quantidade}=    Get Value From Json    ${response.json()}    $.quantidade
    Should Not Be Empty    ${carrinhos[0]}
    Should Be True    ${quantidade[0]} >= 0
    
    # Validar estrutura do primeiro carrinho (se houver)
    ${length}=    Get Length    ${carrinhos[0]}
    Run Keyword If    ${length} > 0    Validar Estrutura Carrinho    ${carrinhos[0][0]}

*** Keywords ***
Validar Estrutura Carrinho
    [Arguments]    ${carrinho}
    [Documentation]    Valida se o carrinho possui todos os campos obrigatórios
    Should Contain    ${carrinho}    _id
    Should Contain    ${carrinho}    precoTotal
    Should Contain    ${carrinho}    quantidadeTotal
    Should Contain    ${carrinho}    idUsuario
    Should Contain    ${carrinho}    produtos