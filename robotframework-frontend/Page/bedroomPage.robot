*** Settings ***
Resource                            loginPage.robot
Resource                            clientPage.robot
Library                             String

*** Variables ***
${bedroomTitle}=                    List
${bedroomLabel}=                    Create New Bedroom
${bedroomToCreatePageBtn}=          xpath=//*[@id="j_idt50"]/a[1]
${bedroomCreateTitle}=              Create New Bedroom
${bedroomCreateDesc}=               id=description
${bedroomCreateFloor}=              id=floor
${bedroomCreateNumber}=             id=number
${bedroomCreatePrice}=              id=priceDaily
${bedroomCreateStatus}=             id=bedroomStatusId
${bedroomCreateStatusVacant}=       xpath=//*[@id="bedroomStatusId"]/option[2]
${bedroomCreateType}=               id=typeBedroomId
${bedroomCreateTypeClassicKing}=    xpath=//*[@id="typeBedroomId"]/option[2]
${bedroomCreateSaveBtn}=            id=saveBtn
${bedroomCreateVerification}=       Bedroom was successfully created.

${bedroomDeleteLastOption}=         xpath=//*[@id="j_idt50"]/table/tbody/tr[7]/td[8]/a[3]
${bedroomDeleteVerification}=       Bedroom was successfully deleted.

${bedroomViewFirstOption}=          xpath=//*[@id="j_idt50"]/table/tbody/tr[1]/td[8]/a[1]
${bedroomViewLabel}=                View
*** Keywords ***
Create Bedroom
                                    Click element                                            ${bedroomToCreatePageBtn}
                                    Wait until page contains                                 ${bedroomCreateTitle}
                                    Title should be                                          ${bedroomCreateTitle}
                                    ${desc}=                                                 Generate random String             5          [UPPER]
                                    Input text                                               ${bedroomCreateDesc}               ${desc}
                                    Input text                                               ${bedroomCreateFloor}              1
                                    Input text                                               ${bedroomCreateNumber}             101
                                    Input text                                               ${bedroomCreatePrice}              110.00
                                    Click element                                            ${bedroomCreateStatus}
                                    Click element                                            ${bedroomCreateStatusVacant}
                                    Click element                                            ${bedroomCreateType}
                                    Click element                                            ${bedroomCreateTypeClassicKing}
                                    Click element                                            ${bedroomCreateSaveBtn}
                                    Wait until page contains                                 ${bedroomCreateVerification}
Delete Bedroom
                                    Click element                                            ${bedroomDeleteLastOption}
                                    Wait until page contains                                 ${bedroomDeleteVerification}
View Bedroom
                                    Click element                                            ${bedroomViewFirstOption}
                                    Wait until page contains                                 ${bedroomViewLabel}
                                    Title should be                                          ${bedroomViewLabel}
