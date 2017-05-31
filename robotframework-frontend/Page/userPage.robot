*** Settings ***
Resource             loginPage.robot
Resource             clientPage.robot
*** Variables ***
${userTitle}=        List
${userLabel}=        Create New User
${userViewFirst}=    //*[@id="j_idt50"]/table/tbody/tr[1]/td[7]/a[1]
${userTextFirst}=    //*[@id="j_idt50"]/table/tbody/tr[1]/td[2]

*** Keywords ***
View User
                     ${userText}                                        Get Text            ${userTextFirst}
                     Click Element                                      ${userViewFirst}
                     Wait until page contains                           ${userText}


