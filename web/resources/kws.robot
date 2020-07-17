*** Settings ***
Documentation           Aqui teremos todas as palavras chaves de automação dos comportamentos

*** Keywords ***
Dado que acesso a página principal
    Go To               ${base_url}

Quando submeto o meu email "${email}"  
    Input Text          ${CAMPO_EMAIL}         ${email}  
    Click Element       ${BOTAO_ENTRAR} 

Então devo ser autenticado
    Wait Until Page Contains Element    ${DASHBOARD}

Então devo ver a mensagem "${expect_message}"
    Wait Until Element Contains     ${DIV_ALERT}         ${expect_message}

# Cadastro de Pratos

Dado que "${produto}" é um dos meus pratos
    Set Test Variable       ${produto}

Quando faço o cadastro desse item
    Wait Until Element Is Visible           ${BOTAO_ADD}    5
    Click Element                           ${BOTAO_ADD} 

    Choose File         ${CAMPO_FOTO}        ${EXECDIR}/resources/images/${produto['img']}

    Input Text          ${CAMPO_NOME}             ${produto['nome']}
    Input Text          ${CAMPO_TIPO}             ${produto['tipo']}
    Input Text          ${CAMPO_PRICE}            ${produto['preco']}

    Click Element       ${BOTAO_CADASTRAR}

Então devo ver este prato no meu dashboard
    Wait Until Element Is Visible           ${DASHBOARD}    10
    Wait Until Element Contains             ${DASHBOARD}   ${produto['nome']}
    
Dado que eu cadastrei "${produto}" um produto errado 
    Set Test Variable       ${produto}
    Quando faço o cadastro desse item

Quando vejo na lista
    Então devo ver este prato no meu dashboard

Então devo apagar esse produto do meu dashboard
    Click Element           class:delete-icon