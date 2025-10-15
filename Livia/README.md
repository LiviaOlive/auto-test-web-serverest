# Testes Automatizados Web ServeRest

Este projeto contém testes automatizados para a interface web do ServeRest, utilizando Robot Framework com Selenium Library.

## Estrutura do Projeto

```
Livia/
├── resources/
│   ├── keywords.robot    # Keywords compartilhadas entre os testes
│   └── variables.robot   # Variáveis globais e seletores
├── tests/
│   ├── test_web_auth.robot    # Testes de autenticação e cadastro
│   └── test_web_cadastro.robot # Testes adicionais de cadastro
└── requirements.txt      # Dependências do projeto
```

## Pré-requisitos

- Python 3.7 ou superior
- Chrome Browser instalado
- ChromeDriver compatível com sua versão do Chrome

## Configuração do Ambiente

1. Clone o repositório:
```bash
git clone https://github.com/LiviaOlive/auto-test-web-serverest.git
cd auto-test-web-serverest/Livia
```

2. Crie um ambiente virtual (opcional, mas recomendado):
```bash
python -m venv venv
.\venv\Scripts\activate  # Windows
```

3. Instale as dependências:
```bash
pip install -r requirements.txt
```

## Executando os Testes

### Todos os testes de autenticação
```bash
robot -d reports tests/test_web_auth.robot
```

### Executar um teste específico usando tags
```bash
robot -d reports -i [TAG] tests/test_web_auth.robot
```

Tags disponíveis:
- `web`: Todos os testes web
- `cadastro`: Testes de cadastro
- `auth`: Testes de autenticação
- `positivo`: Cenários positivos
- `negativo`: Cenários negativos
- `cliente`: Testes específicos para cliente
- `admin`: Testes específicos para administrador

## Casos de Teste

### Autenticação (test_web_auth.robot)
- TC-WEB-CAD-001: Cadastro de novo usuário
- TC-WEB-CAD-002: Cadastro de administrador
- TC-WEB-CAD-003: Cadastro com email já existente
- TC-WEB-AUTH-001: Login com credenciais válidas (cliente)
- TC-WEB-AUTH-002: Login com credenciais válidas (administrador)
- TC-WEB-AUTH-003: Login com credenciais inválidas

## Relatórios

Os relatórios são gerados automaticamente na pasta `reports/` após a execução dos testes. São gerados três arquivos:
- `log.html`: Log detalhado da execução
- `report.html`: Relatório resumido com status dos testes
- `output.xml`: Dados brutos da execução em formato XML

## Estrutura dos Testes

- **Keywords**: As keywords estão organizadas no arquivo `resources/keywords.robot`
- **Variáveis**: Configurações, URLs e seletores estão em `resources/variables.robot`
- **Casos de Teste**: Organizados por funcionalidade em arquivos separados na pasta `tests/`

## Boas Práticas Implementadas

- Uso de Page Objects (keywords e variáveis organizadas)
- Geração dinâmica de emails para evitar conflitos
- Tratamento adequado de timeouts e esperas
- Screenshots automáticos em casos de falha
- Organização por tags para melhor gerenciamento