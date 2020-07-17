*** Settings ***
Documentation           Testes de login do Ninjachef Mobile

Resource                ../resources/base.robot

Test Setup              Open Session
Test Teardown           Close Session
Library                 AppiumLibrary    

*** Test Case ***
Acessar o cardapio
    Dado que desejo comer "Massas"
    Quando submeto meu email "vanessa@qaninja.com.br"
    Então devo ver os pratos do tipo escolhido

