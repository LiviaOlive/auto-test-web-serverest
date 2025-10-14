# 🚀 SETUP RÁPIDO - Testes ServeRest

Este arquivo contém scripts prontos para configurar e executar os testes automatizados.

## ⚡ Execução Rápida (Cole no PowerShell)

### Script Completo - Configuração + Execução

```powershell
# ====== SCRIPT DE SETUP COMPLETO ======
# Cole este bloco inteiro no PowerShell

Write-Host "🚀 Iniciando configuração dos testes ServeRest..." -ForegroundColor Green

# Navegar para o diretório (ajuste o caminho conforme necessário)
$projectPath = "e:\programação\estagio\auto-test-web-serverest\Caio"
Write-Host "📁 Navegando para: $projectPath"
cd $projectPath

# Ativar ambiente virtual
Write-Host "🔧 Ativando ambiente virtual..."
& "E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1"

# Instalar dependências
Write-Host "📦 Instalando dependências..."
pip install -r requirements.txt

# Criar usuários de teste na API ServeRest
Write-Host "👤 Criando usuários de teste..."
try {
    $admin = Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Admin User", "email": "admin@serverest.dev", "password": "123456", "administrador": "true"}' -ErrorAction SilentlyContinue
    Write-Host "✅ Usuário admin criado"
} catch {
    Write-Host "⚠️  Usuário admin já existe ou erro na criação"
}

try {
    $client = Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Fulano da Silva", "email": "fulano@serverest.dev", "password": "123456", "administrador": "false"}' -ErrorAction SilentlyContinue
    Write-Host "✅ Usuário cliente criado"
} catch {
    Write-Host "⚠️  Usuário cliente já existe ou erro na criação"
}

# Executar testes
Write-Host "🧪 Executando testes..."
robot -d reports tests/

# Verificar resultado e abrir relatório
if ($LASTEXITCODE -eq 0) {
    Write-Host "🎉 Todos os testes passaram! Abrindo relatório..." -ForegroundColor Green
    start reports/report.html
} else {
    Write-Host "❌ Alguns testes falharam. Verifique o relatório." -ForegroundColor Red
    start reports/report.html
}

Write-Host "✨ Setup concluído!" -ForegroundColor Green
```

## 🛠️ Scripts Individuais

### 1. Apenas Criar Usuários

```powershell
# Criar usuários necessários para os testes
Write-Host "👤 Criando usuários de teste..."

Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Admin User", "email": "admin@serverest.dev", "password": "123456", "administrador": "true"}'

Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body '{"nome": "Fulano da Silva", "email": "fulano@serverest.dev", "password": "123456", "administrador": "false"}'

Write-Host "✅ Usuários criados com sucesso!"
```

### 2. Apenas Executar Testes

```powershell
# Ativar ambiente e executar testes
& "E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1"
cd "e:\programação\estagio\auto-test-web-serverest\Caio"
robot -d reports tests/
start reports/report.html
```

### 3. Verificar Status dos Usuários

```powershell
# Verificar se os usuários existem
$usuarios = Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method GET | ConvertFrom-Json

$admin = $usuarios.usuarios | Where-Object { $_.email -eq "admin@serverest.dev" }
$client = $usuarios.usuarios | Where-Object { $_.email -eq "fulano@serverest.dev" }

if ($admin) {
    Write-Host "✅ Usuário admin existe (ID: $($admin._id))" -ForegroundColor Green
} else {
    Write-Host "❌ Usuário admin não encontrado" -ForegroundColor Red
}

if ($client) {
    Write-Host "✅ Usuário cliente existe (ID: $($client._id))" -ForegroundColor Green
} else {
    Write-Host "❌ Usuário cliente não encontrado" -ForegroundColor Red
}
```

## 🔧 Solução de Problemas Comuns

### Erro: "robot não é reconhecido"
```powershell
# Ativar ambiente virtual primeiro
& "E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1"
```

### Erro: "401 Unauthorized"
```powershell
# Recriar usuários (execute o script de criação de usuários acima)
```

### Erro: "Diretório não encontrado"
```powershell
# Ajustar o caminho conforme sua instalação
cd "SEU_CAMINHO_AQUI\auto-test-web-serverest\Caio"
```

## 📊 Resultado Esperado

Após executar o script completo, você deve ver:

```
Tests: 8 tests, 8 passed, 0 failed
Status: ALL TESTS PASSING ✅
```

O relatório HTML será aberto automaticamente no seu navegador.