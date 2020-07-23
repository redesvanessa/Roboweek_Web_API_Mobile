*** Settings ***
Documentation           Código base para abrir uma sessão com Appium Server

Library                 AppiumLibrary

Resource                kws.robot

*** Keywords ***

Open Session
    Set Appium Timeout                   10
    Open Application                     http://localhost:4723/wd/hub 
    ...                                  automationName=UiAutomator2  
    ...                                  platformName=Android    
    ...                                  deviceName=Emulator
    ...                                  app=${EXECDIR}/app/ninjachef.apk  
    ...                                  adbExecTimeout=120000 

Close Session
    Capture Page Screenshot
    Close Application

*** Keywords ***
