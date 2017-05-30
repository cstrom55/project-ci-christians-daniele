*** Settings ***
Library                    Selenium2Library
Library                    OperatingSystem
Resource                   setupTeardown.robot

Test setup                 Setup
Test teardown              Teardown

*** Test Cases ***