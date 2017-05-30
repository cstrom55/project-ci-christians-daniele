*** Settings ***
Resource                   ./Cred/environmentCred.robot

*** Keywords ***
Setup
                           Set environment variable        ${driverName}        ${driverLocation}
                           Chrome With Preferences
                           Maximize browser window
                           Set selenium Speed              .2
                           Set selenium Timeout            20
                           Delete all cookies
                           Wait until page contains        ${loginLabel}
                           Location should be              ${baseURL}
                           Title Should be                 ${loginTitle}
Teardown
                           Close all browsers
Chrome With Preferences
                           ${chrome_options} =             Evaluate             sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

                           ${prefs}                        Create Dictionary    credentials_enable_service=${false}

                           Call Method                     ${chrome_options}    add_experimental_option                              prefs                      ${prefs}
                           Call Method                     ${chrome_options}    add_argument                                         --disable-infobars

                           Create WebDriver                Chrome               chrome_options=${chrome_options}

                           Go To                           ${baseURL}