*** Settings ***
Documentation       Suite dos testes de Cadastro

Resource            ../resources/base.robot

Test Setup          Open Session   
Test Teardown       Close Session

*** Test Case ***
Cadastro simples
    Dado que acesso a página principal
    Quando submeto o meu email "vanessaredes@yahoo.com.br"
    Então devo ser autenticado

Email Incorreto
    Dado que acesso a página principal
    Quando submeto o meu email "joao$yahoo.com"
    Então devo ver a mensagem "Oops. Informe um email válido"

Email não informado
    Dado que acesso a página principal
    Quando submeto o meu email "${EMPTY}"
    Então devo ver a mensagem "Oops. Informe um email válido"    
    