# Testes Automatizados ServeRest - Caio

Este projeto implementa testes automatizados para a API ServeRest utilizando Robot Framework.

## 📋 Casos de Teste Implementados

### Autenticação (test_auth.robot)
- **TC-AUTH-001**: Login com credenciais válidas (admin) ✅
- **TC-AUTH-002**: Login com credenciais válidas (cliente) ✅

### Usuários (test_usuarios.robot)  
- **TC-USR-001**: Listar todos os usuários ✅
- **TC-USR-002**: Buscar usuário por ID ✅

### Produtos (test_produtos.robot)
- **TC-PROD-001**: Listar todos os produtos ✅
- **TC-PROD-002**: Buscar produto por ID ✅

### Carrinho (test_carrinho.robot)
- **TC-CART-002**: Listar carrinhos do usuário ✅

**Total: 7 casos de teste implementados e funcionando**

> ⚠️ **ATENÇÃO:** Se os testes falharem, consulte a seção "Troubleshooting" no final deste documento.

## 🚀 Como Executar

### Pré-requisitos
1. Python 3.8+ instalado
2. pip (gerenciador de pacotes Python)

### Configurar Ambiente Virtual
```powershell
# Navegar para o diretório do projeto
cd "e:\programação\estagio\auto-test-web-serverest\Caio"

# Ativar o ambiente virtual existente
& E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1

# OU criar novo ambiente virtual (se necessário)
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### Instalação das Dependências
```powershell
# Com o ambiente virtual ativado
pip install -r requirements.txt
```

### Executar Todos os Testes
```powershell
robot -d reports tests/
```

### Executar Testes Específicos
```powershell
# Apenas testes de autenticação
robot -d reports tests/test_auth.robot

# Apenas testes de usuários  
robot -d reports tests/test_usuarios.robot

# Apenas testes de produtos
robot -d reports tests/test_produtos.robot

# Apenas testes de carrinho
robot -d reports tests/test_carrinho.robot
```

### Executar por Tags
```powershell
# Apenas testes positivos
robot -d reports -i positivo tests/

# Apenas testes de admin
robot -d reports -i admin tests/

# Apenas testes de cliente
robot -d reports -i cliente tests/
```

## 📁 Estrutura do Projeto

```
Caio/
├── tests/                      # Arquivos de teste
│   ├── test_auth.robot         # Testes de autenticação
│   ├── test_usuarios.robot     # Testes de usuários
│   ├── test_produtos.robot     # Testes de produtos
│   ├── test_carrinho.robot     # Testes de carrinho
│   └── test_suite_principal.robot # Suíte principal
├── resources/                  # Recursos auxiliares
│   ├── variables.robot         # Variáveis globais
│   └── keywords.robot          # Keywords reutilizáveis
├── reports/                    # Relatórios de execução
├── requirements.txt            # Dependências do projeto
└── README.md                  # Documentação
```

## 🔧 Configuração

### Variáveis Principais (resources/variables.robot)
- `${BASE_URL}`: URL base da API ServeRest
- `${ADMIN_EMAIL}`: Email do usuário administrador
- `${ADMIN_PASSWORD}`: Senha do usuário administrador
- `${CLIENT_EMAIL}`: Email do usuário cliente
- `${CLIENT_PASSWORD}`: Senha do usuário cliente

### Keywords Auxiliares (resources/keywords.robot)
- `Setup Test Environment`: Configura ambiente de teste
- `Realizar Login Admin`: Autentica usuário admin
- `Realizar Login Cliente`: Autentica usuário cliente
- `Criar Headers Com Token`: Cria headers de autorização
- `Obter Primeiro Produto ID`: Obtém ID do primeiro produto

## 📊 Relatórios

Após a execução, os relatórios são gerados na pasta `reports/`:
- `report.html`: Relatório detalhado em HTML
- `log.html`: Log detalhado da execução
- `output.xml`: Dados em XML para integração

## ✅ Boas Práticas Implementadas

1. **Estrutura Organizada**: Separação clara entre testes, recursos e relatórios
2. **Reutilização**: Keywords auxiliares para evitar duplicação
3. **Documentação**: Todos os testes e keywords documentados
4. **Tags**: Organização por funcionalidade e tipo de teste
5. **Validações Robustas**: Verificações detalhadas de status e estrutura
6. **Tratamento de Erros**: Verificações de disponibilidade de dados
7. **Configuração Centralizada**: Variáveis em arquivo separado

## 🌐 API Testada

- **URL Base**: https://compassuolfront.serverest.dev
- **Documentação**: Consulte a documentação oficial da ServeRest

## ✅ Resultados da Execução

**Última execução:** Todos os 7 casos de teste implementados estão **PASSANDO**
- 8 testes executados: **8 PASSED, 0 FAILED**
- Cobertura: Autenticação, Usuários, Produtos e Carrinho
- Tempo de execução: ~30 segundos
- Relatórios disponíveis em: `reports/report.html`

## � Troubleshooting

### Se os testes falharem com erro 401:

A API ServeRest pode resetar dados. Execute estes comandos para recriar os usuários:

```powershell
# Criar usuários necessários
Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Admin User", "email": "admin@serverest.dev", "password": "123456", "administrador": "true"}'

Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Fulano da Silva", "email": "fulano@serverest.dev", "password": "123456", "administrador": "false"}'

# Executar testes novamente
robot -d reports tests/
```

### Se o comando 'robot' não for reconhecido:

```powershell
# Ativar ambiente virtual
& E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1

# Verificar se (.venv) aparece no prompt, depois executar
robot -d reports tests/
```

### Script de configuração rápida:

```powershell
# Cole este script completo no PowerShell
cd "seu\caminho\para\auto-test-web-serverest\Caio"
& E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1
pip install -r requirements.txt
Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Admin User", "email": "admin@serverest.dev", "password": "123456", "administrador": "true"}' | Out-Null
Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Fulano da Silva", "email": "fulano@serverest.dev", "password": "123456", "administrador": "false"}' | Out-Null
robot -d reports tests/
start reports/report.html
```

## �👥 Autor

**Caio Oliveira Silva Alencar**
- Implementação completa de 7 casos de teste funcionais
- Seguindo boas práticas do Robot Framework
- Estrutura preparada para integração CI/CD
- Testes validados e funcionando corretamente
- Documentação completa com solução de problemas