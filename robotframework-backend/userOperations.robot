*** Settings ***
Library                        HttpLibrary.HTTP
Library                        Collections
Library                        String
Library                        json

*** Variables ***
${httpContext}=                localhost:8080
${httpVariable}=               http
${headerContentJson}=          application/json
${headerAcceptAll}=            */*

#GET endpoints
${getAllUsersEndpoint}=        /hotel-rest/webresources/user/
${getUsersCounterEndpoint}=    /hotel-rest/webresources/user/count
${getUsersByIdEndpoint}=       /hotel-rest/webresources/user/         #send id
#POST endpoint
${createUsersEndpoint}=        /hotel-rest/webresources/user/
#PUT endpoint
${updateUsersEndpoint}=        /hotel-rest/webresources/user/         #send id
#Delete endpoint
${deleteUsersEndpoint}=        /hotel-rest/webresources/user/         #send id

*** Keywords ***

Get All Users
                               Create Http Context                    ${httpContext}            ${httpVariable}
                               Get                                    ${getAllUsersEndpoint}
                               ${response_status}=                    Get Response Status
                               ${response_body}=                      Get Response Body
                               Should contain                         ${response_status}        200
