# Automação de Testes - ServeRest

Este é um projeto de automação de testes para a aplicação [ServeRest](https://front.serverest.dev/), uma API REST e interface web para estudos de testes de automação.

## 🚀 Objetivo

Criar uma suíte de testes automatizados cobrindo tanto a API quanto a interface web do ServeRest, permitindo validar as principais funcionalidades da aplicação.

## 📂 Estrutura do Projeto

O projeto está organizado em diferentes diretórios, cada um contendo uma abordagem diferente de automação:

```
auto-test-web-serverest/
├── Caio/          # Testes de API Rest
└── Livia/         # Testes Web UI
```

## 🛠️ Tecnologias Utilizadas

- Robot Framework
- Python
- Selenium WebDriver
- SeleniumLibrary
- RequestsLibrary

## 📌 Status do Projeto

### Implementado
- ✅ Testes de cadastro de usuários (Web)
- ✅ Testes de autenticação (Web)
- ✅ Testes de API (Usuários, Produtos, Carrinhos)

### Em Desenvolvimento
- 🚧 Testes web de produtos
- 🚧 Testes web de carrinho
- 🚧 Integração contínua

## 📝 Documentação

Para informações detalhadas sobre cada suíte de testes, consulte os READMEs específicos:

- [Testes de API](./Caio/README.md)
- [Testes Web](./Livia/README.md)
