*** Settings ***
Resource                                 loginPage.robot
Resource                                 bedroomPage.robot
Resource                                 billPage.robot
Resource                                 clientPage.robot

*** Variables ***
${dashboardTitle}=                       Dashboard
${dashboardLabel}=                       Rooms free!
${dashboardDropdownMenu}=                xpath=//*[@id="wrapper"]/nav/ul/li[2]/a/i[1]
${dashboardDropdownLogoutButton}=        xpath=//*[@id="wrapper"]/nav/ul/li[2]/ul/li/a
${dashboardSidebarBedroomButton}=        xpath=//*[@id="side-menu"]/li[3]/a
${dashboardSidebarBillButton}=           xpath=//*[@id="side-menu"]/li[4]/a
${dashboardSidebarClientButton}=         xpath=//*[@id="side-menu"]/li[5]/a
${dashboardSidebarReservationButton}=    xpath=//*[@id="side-menu"]/li[6]/a
${dashboardSidebarUserButton}=           xpath=//*[@id="side-menu"]/li[7]/a
${dashboardSidebarDashboardButton}=      xpath=//*[@id="side-menu"]/li[2]/a
${homebutton}=                           xpath=//*[@id="wrapper"]/nav/div[1]/a
${dashBoardBlueLink}=                    xpath=//*[@id="page-wrapper"]/div/div/div/div/div[2]/div/a/div/span[1]
${dashBoardGreenLink}=                   xpath=//*[@id="page-wrapper"]/div/div/div/div/div[3]/div/a/div/span[1]
${dashBoardYellowLink}=                  xpath=//*[@id="page-wrapper"]/div/div/div/div/div[4]/div/a/div/span[1]
${dashBoardRedLink}=                     xpath=//*[@id="page-wrapper"]/div/div/div/div/div[5]/div/a/div/span[1]
*** Keywords ***

Perform Logout
                                         Click element                                                             ${dashboardDropdownMenu}
                                         Wait until page contains element                                          ${dashboardDropdownLogoutButton}
                                         Click element                                                             ${dashboardDropdownLogoutButton}
                                         Wait until page contains                                                  ${loginLabel}
                                         Title should be                                                           ${loginTitle}
Navigate To Bedroom
                                         Click Element                                                             ${dashboardSidebarBedroomButton}
                                         Wait until page contains                                                  ${bedroomLabel}
Navigate To Bill
                                         Click Element                                                             ${dashboardSidebarBillButton}
                                         Wait until page contains                                                  ${billLabel}
Navigate To Client
                                         Click Element                                                             ${dashboardSidebarClientButton}
                                         Wait until page contains                                                  ${clientLabel}
Navigate To Reservation
                                         Click Element                                                             ${dashboardSidebarReservationButton}
                                         Wait until page contains                                                  ${reservationLabel}
Navigate To User
                                         Click Element                                                             ${dashboardSidebarUserButton}
                                         Wait until page contains                                                  ${userLabel}
Navigate To Dashboard
                                         Click Element                                                             ${dashboardSidebarDashboardButton}
                                         Wait until page contains                                                  ${dashboardLabel}
Homebutton
                                         Click Element                                                             ${homebutton}
                                         Wait until page contains                                                  ${dashboardLabel}
                                         Title should be                                                           ${dashboardTitle}
Test blue link
                                         Click Element                                                             ${dashBoardBlueLink}
                                         Wait until page contains                                                  ${bedroomLabel}
                                         Title should be                                                           ${bedroomTitle}
Test green link
                                         Click Element                                                             ${dashBoardGreenLink}
                                         Wait until page contains                                                  ${billLabel}
                                         Title should be                                                           ${billTitle}
Test yellow link
                                         Click element                                                             ${dashBoardYellowLink}
                                         Wait until page contains                                                  ${clientLabel}
                                         Title should be                                                           ${clientTitle}
Test red link
                                         Click Element                                                             ${dashBoardRedLink}
                                         Wait until page contains                                                  ${reservationLabel}
                                         Title should be                                                           ${reservationTitle}





