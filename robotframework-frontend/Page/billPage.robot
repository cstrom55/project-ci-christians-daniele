*** Settings ***
Resource             loginPage.robot
Resource             clientPage.robot
*** Variables ***
${billTitle}=              List
${billLabel}=              Create New Bill
${billViewFirstOption}=    //*[@id="j_idt50"]/table/tbody/tr[1]/td[7]/a[1]
${billViewLabel}=          View
${billViewTitle}=          View


*** Keywords ***
View Bill
                           Click element                                            ${billViewFirstOption}
                           Wait until page contains                                 ${billViewLabel}
                           Title should be                                          ${billViewTitle}
