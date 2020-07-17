*** Settings ***
Documentation      Cadastro de produtos/pratos
...                Sendo um cozinheiro amador 
...                Quero cadastrar meus melhores pratos 
...                Para que eu possa cozinha-los para outras pessoas 

Resource            ../resources/base.robot

Test Setup          Login Session                   vanessaredes@yahoo.com.br  
Test Teardown       Close Session
*** Variable ***
&{nhoque}           nome=Nnhoque molho páprica      tipo=Massas     preco=20.00     img=nhoque.jpg
&{nhoque_errado}           nome=Nnhoque Ruim        tipo=Prato      preco=20.00     img=nhoque.jpg


*** Test Case ***
Novo prato
    Dado que "${nhoque}" é um dos meus pratos
    Quando faço o cadastro desse item
    Então devo ver este prato no meu dashboard

Deletar produto cadastrado
    Dado que eu cadastrei "&{nhoque_errado}" um produto errado 
    Quando vejo na lista
    Então devo apagar esse produto do meu dashboard