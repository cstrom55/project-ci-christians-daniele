*** Settings ***
Resource                        loginPage.robot
Resource                        clientPage.robot
*** Variables ***
${clientTitle}=                 List
${clientLabel}=                 List
${clientCreateButton}=          //*[@id="j_idt50"]/a[1]
${clientFormLabel}=             Create New Client
${clientNameTextArea}=          //*[@id="name"]
${clientEmailTextArea}=         //*[@id="email"]
${clientGenderMaleCheckbox}=    //*[@id="gender:0"]
${clientSSNTextArea}=           //*[@id="socialSecurityNumber"]
${clientSaveButton}=            //*[@id="j_idt52"]/a[1]
${clientCreatedMessage}=        Client was successfully created
${clientShowAllUsersButton}=    //*[@id="j_idt51"]/a[4]

${clientFirstName}=             //*[@id="j_idt50"]/table/tbody/tr[1]/td[2]
${clientViewFirst}=             //*[@id="j_idt50"]/table/tbody/tr[1]/td[7]/a[1]

*** Keywords ***
Create Client
                                ${clientName}=                                     Generate Random String         10                    [LETTERS]
                                ${clientEmail}=                                    Catenate                       SEPARATOR=            ${clientName}    @email.com
                                ${clientSSN}=                                      Generate Random String         7                     [NUMBERS]
                                Click Element                                      ${clientCreateButton}
                                Wait Until Page Contains                           ${clientFormLabel}
                                Input Text                                         ${clientNameTextArea}          ${clientName}
                                Input Text                                         ${clientEmailTextArea}         ${clientEmail}
                                Select Checkbox                                    ${clientGenderMaleCheckbox}
                                Input Text                                         ${clientSSNTextArea}           ${clientSSN}
                                Click Element                                      ${clientSaveButton}
                                Wait Until Page Contains                           ${clientCreatedMessage}
                                Click Element                                      ${clientShowAllUsersButton}
                                Wait Until Page Contains                           ${clientLabel}
View Client
                                ${clientName}=                                     get text                       ${clientFirstName}
                                Click element                                      ${clientViewFirst}
                                Wait Until Page Contains                           ${clientName}
