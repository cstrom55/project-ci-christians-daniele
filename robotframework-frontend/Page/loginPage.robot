*** Settings ***
Resource                      ../Cred/loginCred.robot
Resource                      dashboardPage.robot

*** Variables ***
${loginTitle}=                Hotel Accomodation - login page
${loginLabel}=                Please, login!
${loginUserTextField}=        id=login
${loginPasswordTextField}=    id=senha
${loginBtnLogin}=             id=loginBtn

*** Keywords ***
Perform Login
                              Input text                             ${loginUserTextField}        ${username}
                              Input text                             ${loginPasswordTextField}    ${password}
                              Click element                          ${loginBtnLogin}
                              Wait until page contains               ${dashboardLabel}