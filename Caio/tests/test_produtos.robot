*** Settings ***
Documentation    Testes de Produtos da API ServeRest
Library          RequestsLibrary
Library          JSONLibrary
Library          Collections
Resource         ../resources/variables.robot
Resource         ../resources/keywords.robot
Suite Setup      Setup Test Environment

*** Test Cases ***
TC-PROD-001: Listar todos os produtos
    [Documentation]    Testa listagem de todos os produtos com token admin
    [Tags]    produtos    admin    positivo
    
    # Realizar login e obter token admin
    ${admin_token}=    Realizar Login Admin
    
    # Preparar headers com token
    ${headers}=    Criar Headers Com Token    ${admin_token}
    
    # Realizar requisição GET /produtos
    ${response}=    GET On Session    serverest    /produtos    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    produtos
    Should Contain    ${response.json()}    quantidade
    
    # Validar estrutura da resposta
    ${produtos}=    Get Value From Json    ${response.json()}    $.produtos
    ${quantidade}=    Get Value From Json    ${response.json()}    $.quantidade
    Should Not Be Empty    ${produtos[0]}
    Should Be True    ${quantidade[0]} >= 0
    
    # Validar estrutura do primeiro produto (se houver)
    ${length}=    Get Length    ${produtos[0]}
    Run Keyword If    ${length} > 0    Validar Estrutura Produto    ${produtos[0][0]}

TC-PROD-002: Buscar produto por ID
    [Documentation]    Testa busca de produto específico por ID
    [Tags]    produtos    admin    positivo
    
    # Realizar login e obter token admin
    ${admin_token}=    Realizar Login Admin
    
    # Primeiro, listar produtos para obter um ID válido
    ${headers}=    Criar Headers Com Token    ${admin_token}
    ${response}=    GET On Session    serverest    /produtos    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    
    # Verificar se há produtos disponíveis
    ${produtos}=    Get Value From Json    ${response.json()}    $.produtos
    ${length}=    Get Length    ${produtos[0]}
    Skip If    ${length} == 0    Não há produtos cadastrados para testar
    
    # Obter ID do primeiro produto
    ${product_id}=    Get Value From Json    ${produtos[0]}    $[0]._id
    
    # Realizar requisição GET /produtos/{id}
    ${response}=    GET On Session    serverest    /produtos/${product_id[0]}    headers=${headers}
    
    # Validações
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Contain    ${response.json()}    _id
    Should Contain    ${response.json()}    nome
    Should Contain    ${response.json()}    preco
    Should Contain    ${response.json()}    descricao
    Should Contain    ${response.json()}    quantidade
    
    # Validar que o ID retornado é o mesmo solicitado
    ${returned_id}=    Get Value From Json    ${response.json()}    $._id
    Should Be Equal    ${returned_id[0]}    ${product_id[0]}

*** Keywords ***
Validar Estrutura Produto
    [Arguments]    ${produto}
    [Documentation]    Valida se o produto possui todos os campos obrigatórios
    Should Contain    ${produto}    _id
    Should Contain    ${produto}    nome
    Should Contain    ${produto}    preco
    Should Contain    ${produto}    descricao
    Should Contain    ${produto}    quantidade