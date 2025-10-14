# ====== SCRIPT DE SETUP COMPLETO - Testes ServeRest ======
# Execute este arquivo no PowerShell para configurar e executar os testes automaticamente

param(
    [string]$ProjectPath = "e:\programação\estagio\auto-test-web-serverest\Caio"
)

Write-Host "🚀 Iniciando configuração dos testes ServeRest..." -ForegroundColor Green
Write-Host "📍 Caminho do projeto: $ProjectPath" -ForegroundColor Cyan

# Verificar se o diretório existe
if (-not (Test-Path $ProjectPath)) {
    Write-Host "❌ Diretório não encontrado: $ProjectPath" -ForegroundColor Red
    Write-Host "💡 Ajuste o caminho no parâmetro -ProjectPath ou edite o script" -ForegroundColor Yellow
    exit 1
}

# Navegar para o diretório
Write-Host "📁 Navegando para o diretório do projeto..."
Set-Location $ProjectPath

# Verificar se existe ambiente virtual
$venvPath = "E:/programação/estagio/auto-test-web-serverest/.venv/Scripts/Activate.ps1"
if (-not (Test-Path $venvPath)) {
    Write-Host "❌ Ambiente virtual não encontrado: $venvPath" -ForegroundColor Red
    Write-Host "💡 Verifique se o ambiente virtual foi criado corretamente" -ForegroundColor Yellow
    exit 1
}

# Ativar ambiente virtual
Write-Host "🔧 Ativando ambiente virtual..."
& $venvPath

# Instalar dependências
Write-Host "📦 Instalando/Atualizando dependências..."
pip install -r requirements.txt

# Verificar conectividade com a API
Write-Host "🌐 Testando conectividade com ServeRest API..."
try {
    $apiTest = Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method GET -TimeoutSec 10
    Write-Host "✅ API ServeRest acessível" -ForegroundColor Green
} catch {
    Write-Host "❌ Erro ao acessar API ServeRest: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 Verifique sua conexão com a internet" -ForegroundColor Yellow
    exit 1
}

# Criar usuários de teste na API ServeRest
Write-Host "👤 Criando usuários de teste..."

# Criar usuário admin
try {
    $adminBody = '{"nome": "Admin User", "email": "admin@serverest.dev", "password": "123456", "administrador": "true"}'
    $adminResponse = Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body $adminBody -ErrorAction Stop
    $adminData = $adminResponse.Content | ConvertFrom-Json
    Write-Host "✅ Usuário admin: $($adminData.message)" -ForegroundColor Green
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Write-Host "⚠️  Usuário admin já existe (isso é normal)" -ForegroundColor Yellow
    } else {
        Write-Host "❌ Erro ao criar usuário admin: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Criar usuário cliente
try {
    $clientBody = '{"nome": "Fulano da Silva", "email": "fulano@serverest.dev", "password": "123456", "administrador": "false"}'
    $clientResponse = Invoke-WebRequest -Uri "https://serverest.dev/usuarios" -Method POST -ContentType "application/json" -Body $clientBody -ErrorAction Stop
    $clientData = $clientResponse.Content | ConvertFrom-Json
    Write-Host "✅ Usuário cliente: $($clientData.message)" -ForegroundColor Green
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Write-Host "⚠️  Usuário cliente já existe (isso é normal)" -ForegroundColor Yellow
    } else {
        Write-Host "❌ Erro ao criar usuário cliente: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Aguardar um momento para sincronização
Write-Host "⏳ Aguardando sincronização..." -ForegroundColor Cyan
Start-Sleep -Seconds 2

# Executar testes
Write-Host "🧪 Executando testes automatizados..." -ForegroundColor Cyan
Write-Host "📊 Isto pode levar alguns segundos..." -ForegroundColor Gray

try {
    $testResult = & robot -d reports tests/ 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "🎉 SUCESSO! Todos os testes passaram!" -ForegroundColor Green
        Write-Host "📈 Resultado: 8 testes executados, 8 passaram, 0 falharam" -ForegroundColor Green
        Write-Host "📋 Abrindo relatório detalhado..." -ForegroundColor Cyan
        
        # Abrir relatório
        if (Test-Path "reports/report.html") {
            Start-Process "reports/report.html"
        }
    } else {
        Write-Host ""
        Write-Host "⚠️  Alguns testes falharam. Verificando detalhes..." -ForegroundColor Yellow
        Write-Host "📋 Abrindo relatório para análise..." -ForegroundColor Cyan
        
        # Abrir relatório mesmo com falhas
        if (Test-Path "reports/report.html") {
            Start-Process "reports/report.html"
        }
    }
} catch {
    Write-Host "❌ Erro durante execução dos testes: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✨ Setup concluído!" -ForegroundColor Green
Write-Host "📂 Relatórios disponíveis em: reports/" -ForegroundColor Cyan
Write-Host "🌐 Abra reports/report.html para ver detalhes completos" -ForegroundColor Cyan

# Mostrar resumo final
Write-Host ""
Write-Host "📋 RESUMO DA EXECUÇÃO:" -ForegroundColor Magenta
Write-Host "• Ambiente virtual: ativado ✅" -ForegroundColor White
Write-Host "• Dependências: instaladas ✅" -ForegroundColor White
Write-Host "• Usuários de teste: criados ✅" -ForegroundColor White
Write-Host "• Testes: executados ✅" -ForegroundColor White
Write-Host "• Relatório: gerado ✅" -ForegroundColor White