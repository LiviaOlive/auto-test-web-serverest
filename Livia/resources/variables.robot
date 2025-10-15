*** Variables ***
${BROWSER}               chrome
${URL}                  https://front.serverest.dev/login
${TIMEOUT}              20

# Credenciais - Serão atualizadas durante os testes de cadastro
${LAST_ADMIN_EMAIL}     ${EMPTY}
${ADMIN_PASSWORD}       admin
${LAST_USER_EMAIL}      ${EMPTY}
${CLIENT_PASSWORD}      teste123

# Elementos da página
${INPUT_EMAIL}          id=email
${INPUT_PASSWORD}      id=password
${INPUT_NAME}          id=nome
${CHECKBOX_ADMIN}      id=administrador
${BUTTON_LOGIN}        css=button[type='submit']
${LINK_CADASTRO}       css=a[data-testid='cadastrar']
${TEXT_SUCCESS}        ServeRest Store
${ERROR_MESSAGE}       Email e/ou senha inválidos
${SUCCESS_MESSAGE}     Cadastro realizado com sucesso

# Dados para cadastro de usuário comum
${NEW_USER_NAME}      Usuario Teste
${NEW_USER_EMAIL}     teste@qa.com.br
${NEW_USER_PASSWORD}  teste123

# Dados para cadastro de administrador
${NEW_ADMIN_NAME}      Admin Teste
${NEW_ADMIN_EMAIL}     admin@admin.com
${NEW_ADMIN_PASSWORD}  admin