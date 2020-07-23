*** Settings ***
Documentation           Aqui teremos todas as palavras chaves de automação dos comportamentos

Resource            helpers.robot
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

############ Integração com a API  ############

Dado que "${email_cozinheiro}" é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}

    ${token_cozinheiro}=    Get API token           ${email_cozinheiro}

    Set Test Variable       ${token_cozinheiro}


E "${email_cliente}" é o email do meu cliente
    Set Test Variable        ${email_cliente}

    ${token_cliente}=       Get API token              ${email_cliente}

    Set Test Variable       ${token_cliente}

E que "${produto}" está cadastrado no meu dashboard
    Set Test Variable         ${produto}

    &{headers}=             Create Dictionary       user_id=${token_cozinheiro} 
    &{payload}=             Create Dictionary       name=${produto}         plate=Tipo      price=20.00
    ${image_file}=          Get Binary File         ${EXECDIR}/resources/images/produto.jpg
    &{files}=               Create Dictionary       thumbnail=${image_file}
    

    Create Session          api                     ${api_url}
    ${resp}=                Post Request            api     /products     files=${files}      data=${payload}     headers=${headers}
    Status Should Be        200                     ${resp}

    ${produto_id}           Convert To String       ${resp.json()['_id']}
    Set Test Variable       ${produto_id}

    Go To                   ${base_url}

    Input Text              ${CAMPO_EMAIL}       ${email_cozinheiro}  
    Click Element           ${BOTAO_ENTRAR} 
    Wait Until Page Contains Element             ${DASHBOARD}

Quando o cliente solicita o preparo desse prato

    &{headers}=             Create Dictionary       Content-Type=application/json       user_id=${token_cliente}
    &{payload}=             Create Dictionary       payment=Dinheiro
   
    Create Session          api                     ${api_url}
    ${resp}=                Post Request            api     /products/${produto_id}/orders     
    ...                                             data=${payload}     headers=${headers}
    Status Should Be        200                     ${resp}

Então devo receber uma notificação de pedido desse produto
    ${mensagem_esperada}    Convert To String       ${email_cliente} está solicitando o preparo do seguinte prato: ${produto}.
    Wait Until Page Contains                        ${mensagem_esperada}      15

E posso aceitar ou rejeitar esse pedido
    Wait Until Page Contains        ACEITAR         15
    Wait Until Page Contains        REJEITAR        15    