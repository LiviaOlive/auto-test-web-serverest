*** Settings ***
Library    SeleniumLibrary
Resource   variables.robot

*** Keywords ***
Acessar Página de Cadastro
    Click Element    ${LINK_CADASTRO}
    Wait Until Element Is Visible    ${INPUT_NAME}

Preencher Formulário de Cadastro
    [Arguments]    ${nome}    ${email}    ${senha}    ${eh_admin}=${FALSE}
    Input Text    ${INPUT_NAME}    ${nome}
    Input Text    ${INPUT_EMAIL}    ${email}
    Input Text    ${INPUT_PASSWORD}    ${senha}
    Run Keyword If    ${eh_admin}    Select Checkbox    ${CHECKBOX_ADMIN}

Submeter Cadastro
    Click Element    ${BUTTON_LOGIN}
Abrir Navegador
    [Documentation]    Abre o navegador e navega para a página inicial
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${options}
    Go To    ${URL}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}
    Wait Until Element Is Visible    ${INPUT_EMAIL}    timeout=10s
    Log    Página carregada com sucesso

Fechar Navegador
    Close All Browsers

Login Como Administrador
    [Documentation]    Realiza login com credenciais de administrador
    Log    Iniciando login como administrador: ${LAST_ADMIN_EMAIL}
    Wait Until Element Is Visible    ${INPUT_EMAIL}    timeout=10s
    Input Text    ${INPUT_EMAIL}    ${LAST_ADMIN_EMAIL}
    Input Text    ${INPUT_PASSWORD}    ${ADMIN_PASSWORD}
    Log    Credenciais inseridas, clicando no botão de login
    Click Element    ${BUTTON_LOGIN}
    Log    Aguardando redirecionamento...
    Sleep    2s
    ${url}=    Get Location
    Log    URL atual: ${url}
    Page Should Not Contain    ${ERROR_MESSAGE}

Login Como Cliente
    [Documentation]    Realiza login com credenciais de cliente
    Log    Iniciando login como cliente: ${LAST_USER_EMAIL}
    Wait Until Element Is Visible    ${INPUT_EMAIL}    timeout=10s
    Input Text    ${INPUT_EMAIL}    ${LAST_USER_EMAIL}
    Input Text    ${INPUT_PASSWORD}    ${CLIENT_PASSWORD}
    Log    Credenciais inseridas, clicando no botão de login
    Click Element    ${BUTTON_LOGIN}
    Log    Aguardando redirecionamento...
    Wait Until Location Contains    /home    timeout=10s
    Page Should Not Contain    ${ERROR_MESSAGE}