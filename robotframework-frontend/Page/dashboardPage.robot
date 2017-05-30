*** Settings ***
Resource                                 loginPage.robot
Resource                                 bedroomPage.robot

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
*** Keywords ***

Perform Logout
                                         Click element                                    ${dashboardDropdownMenu}
                                         Wait until page contains element                 ${dashboardDropdownLogoutButton}
                                         Click element                                    ${dashboardDropdownLogoutButton}
                                         Wait until page contains                         ${loginLabel}
                                         Title should be                                  ${loginTitle}
Navigate To Bedroom
                                         Click Element                                    ${dashboardSidebarBedroomButton}
                                         Wait until page contains                         ${bedroomLabel}
Navigate To Bill
                                         Click Element                                    ${dashboardSidebarBillButton}
                                         Wait until page contains                         ${billLabel}
Navigate To Client
                                         Click Element                                    ${dashboardSidebarClientButton}
                                         Wait until page contains                         ${clientLabel}
Navigate To Reservation
                                         Click Element                                    ${dashboardSidebarReservationButton}
                                         Wait until page contains                         ${reservationLabel}
Navigate To User
                                         Click Element                                    ${dashboardSidebarUserButton}
                                         Wait until page contains                         ${userLabel}
Navigate To Dashboard
                                         Click Element                                    ${dashboardSidebarDashboardButton}
                                         Wait until page contains                         ${dashboardLabel}
Homebutton
                                         Click Element                                    ${homebutton}
                                         Wait until page contains                         ${dashboardLabel}
                                         Title should be                                  ${dashboardTitle}






