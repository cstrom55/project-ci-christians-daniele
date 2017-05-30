*** Settings ***
Library                    Selenium2Library
Library                    OperatingSystem
Resource                   setupTeardown.robot
Resource                   ./Page/bedroomPage.robot
Resource                   ./Page/billPage.robot
Resource                   ./Page/clientPage.robot
Resource                   ./Page/reservationPage.robot
Resource                   ./Page/clientPage.robot
Resource                   ./Page/userPage.robot
Resource                   ./Page/loginPage.robot
Resource                   ./Cred/loginCred.robot

Test setup                 Setup
Test teardown              Teardown

*** Test Cases ***
Testcase1_LoginLogout
                           Perform Login
                           Perform Logout
Testcase2_CreateBedroom
                           Perform Login
                           Navigate To Bedroom
                           Create Bedroom
                           Navigate To Bedroom
                           Delete Bedroom
                           Perform Logout
Testcase3_ViewBedroom
                           Perform Login
                           Navigate To Bedroom
                           View Bedroom
                           Perform Logout
Testcase4_Navigation
                           Perform Login
                           Navigate To Bedroom
                           Navigate To Bill
                           Navigate To Client
                           Navigate To Reservation
                           Navigate To User
                           Navigate To Dashboard
                           Perform Logout
Testcase5_Homebutton
                           Perform Login
                           Navigate To Bedroom
                           Homebutton
                           Perform Logout
                           