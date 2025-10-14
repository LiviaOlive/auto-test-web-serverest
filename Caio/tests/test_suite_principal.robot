*** Settings ***
Documentation    Suíte Principal de Testes da API ServeRest
...              Esta suíte executa todos os testes implementados para validar
...              as funcionalidades de autenticação, usuários, produtos e carrinho.
...              
...              Casos de Teste Implementados:
...              - TC-AUTH-001: Login com credenciais válidas (admin)
...              - TC-AUTH-002: Login com credenciais válidas (cliente)  
...              - TC-USR-001: Listar todos os usuários
...              - TC-USR-002: Buscar usuário por ID
...              - TC-PROD-001: Listar todos os produtos
...              - TC-PROD-002: Buscar produto por ID
...              - TC-CART-001: Criar carrinho
...              - TC-CART-002: Listar carrinhos do usuário

*** Test Cases ***
Executar Todos os Testes ServeRest
    [Documentation]    Executa todos os casos de teste implementados
    [Tags]    regression    all
    
    # Este é apenas um placeholder para documentação
    # Execute os testes individualmente usando:
    # robot tests/test_auth.robot
    # robot tests/test_usuarios.robot
    # robot tests/test_produtos.robot  
    # robot tests/test_carrinho.robot
    Log    Para executar todos os testes use: robot tests/