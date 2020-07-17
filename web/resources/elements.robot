*** Settings ***
Documentation       Aqui temos o mapeamento dos elementos e localizadores.

*** Variable ***

# Sign Up
${CAMPO_EMAIL}      id:email         
${BOTAO_ENTRAR}     css:button[type=submit]
${DIV_ALERT}        class:alert

# Dashboard
${DASHBOARD}            class:dashboard
${BOTAO_ADD}            class:btn-add
${CAMPO_FOTO}           css:input[id=thumbnail]    
${CAMPO_NOME}           id:name
${CAMPO_TIPO}           id:plate
${CAMPO_PRICE}          id:price
${BOTAO_CADASTRAR}      class:btn-cadastrar
