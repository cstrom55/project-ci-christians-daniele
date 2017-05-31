*** Settings ***
Library                               HttpLibrary.HTTP
Library                               Collections
Library                               String
Library                               json

Resource                              clientOperations.robot

*** Variables ***
${httpContext}=                       localhost:8080
${httpVariable}=                      http
${headerContentJson}=                 application/json
${headerAcceptAll}=                   */*

#GET endpoints
${getAllUsersEndpoint}=               /hotel-rest/webresources/user/
${getUsersCounterEndpoint}=           /hotel-rest/webresources/user/count
${getUsersByIdEndpoint}=              /hotel-rest/webresources/user/         #send id
#POST endpoint
${createUsersEndpoint}=               /hotel-rest/webresources/user/
#PUT endpoint
${updateUsersEndpoint}=               /hotel-rest/webresources/user/         #send id
#Delete endpoint
${deleteUsersEndpoint}=               /hotel-rest/webresources/user/         #send id

***
todo randomclientdata
ta från gammal??
randomUserStausId
*** Keywords ***
Random User Data
                                      ${id}=                                 Set Variable                                       100
                                      ${userLogin}=                          Generate Random String                             8                                        [UPPER]
                                      ${userPassword}=                       Generate Random String                             8                                        [UPPER]
                                      ${userType}=                           Generate Random String                             1                                        2

                                      #                                      ${userClientId}=                                   random Client Data
                                      ${userClientId}=                       random User ClientId
                                      ${userStatusId}=                       random User StatusId                               #data for userStatusId in json format

                                      ${dictionary}=                         Create Dictionary                                  id=${id}                                 login=${userLogin}        password= ${userPassword}             typeUser=${userType}        clientId=${userClientId}      userStatusId=${userStatusId}
                                      ${userData}=                           Stringify Json                                     ${dictionary}
                                      [Return]                               ${userData}

random User ClientId

                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Set request header                     Content-Type                                       ${headerContentJson}
                                      Set request header                     Accept                                             ${headerAcceptAll}
                                      ${lastClientID}=                       Get ID of last client
                                      Get                                    ${get_all_clients_endpoint}/${lastClientID}
                                      ${responseBodyLastClient}=             Get Response Body

                                      ${lastClientId}=                       Get Json Value                                     ${responseBodyLastClient}                /id
                                      ${lastClientName}=                     Get Json Value                                     ${responseBodyLastClient}                /name
                                      ${lastClientCreateDate}=               Get Json Value                                     ${responseBodyLastClient}                /createDate
                                      ${lastClientEmail}=                    Get Json Value                                     ${responseBodyLastClient}                /email
                                      ${lastClientGender}=                   Get Json Value                                     ${responseBodyLastClient}                /gender
                                      ${lastClientSSN}=                      Get Json Value                                     ${responseBodyLastClient}                /socialSecurityNumber
                                      ${lastClientDictionary}=               Create Dictionary                                  id=${lastClientId}                       name=${lastClientName}    createDate=${lastClientCreateDate}    email=${lastClientEmail}    gender=${lastClientGender}    socialSecurityNumber=${lastClientSSN}
                                      [return]                               ${lastClientDictionary}

random User StatusId
                                      ${userStatusId}=                       Set Variable                                       1
                                      ${userStatusCode}=                     Set Variable                                       1
                                      ${userStatusName}=                     Set Variable                                       ACTIVE



                                      ${userIdDictionary}=                   Create Dictionary                                  id=${userStatusId}                       code=${userStatusCode}    name=${userStatusName}



                                      [return]                               ${userIdDictionary}

Create User
                                      Create a client
                                      ${requestBody}=                        Random User Data

                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Set request header                     Content-Type                                       ${headerContentJson}
                                      Set request header                     Accept                                             ${headerAcceptAll}
                                      Set request body                       ${requestBody}
                                      Log to console                         ${\n}Creating new user ${\n}DATA:${requestBody}
                                      Post                                   ${createUsersEndpoint}
                                      ${responseStatus}=                     Get response status
                                      Should contain                         ${responseStatus}                                  204



Get ID of last user
                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Get                                    ${getAllUsersEndpoint}
                                      ${responseStatusFirstRequest}=         Get response status
                                      Should contain                         ${responseStatusFirstRequest}                      200
                                      ${bodyFirstRequest}=                   Get response body
                                      Get                                    ${getUsersCounterEndpoint}
                                      ${responseStatusSecondRequest}=        Get response status
                                      Should contain                         ${responseStatusSecondRequest}                     200
                                      ${bodySecondRequest}=                  Get response body
                                      ${lastIndex}=                          Evaluate                                           ${bodySecondRequest}-1
                                      ${jsonId}=                             Get json value                                     ${bodyFirstRequest}                      /${lastIndex}/id
                                      Log to console                         ${jsonId}
                                      [Return]                               ${jsonId}



Get User by ID
                                      ${lastUserID}=                         Get ID of last user
                                      log to console                         ${lastUserID}

                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Get                                    ${getUsersByIdEndpoint}/${lastUserID}
                                      ${responseStatus}=                     Get response status
                                      ${responseBody}=                       Get response body
                                      Should contain                         ${responseStatus}                                  200
                                      Log to console                         ${responseStatus}
                                      Log to console                         ${responseBody}
                                      [Return]                               ${responseBody}


Delete last User
                                      ${lastUserID}=                         Get ID of last user
                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Delete                                 ${deleteUsersEndpoint}/${lastUserID}
                                      ${responseStatus}=                     Get response status
                                      Should contain                         ${responseStatus}                                  204
                                      Log to console                         ${responseStatus}
                                      Log to console                         ${\n}User deleted, ID:${lastUserID}




Get All Users
                                      Create Http Context                    ${httpContext}                                     ${httpVariable}
                                      Get                                    ${getAllUsersEndpoint}
                                      ${responseStatus}=                     Get Response Status
                                      ${allUsers}=                           Get Response Body
                                      log to console                         ${\n}Users:${allUsers}
                                      log to console                         ${\n}Status code:${responseStatus}
                                      Should contain                         ${responseStatus}                                  200
                                      [return]                               ${allUsers}

Get total number of Users
                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Set request header                     Content-Type                                       ${headerContentJson}
                                      Set request header                     Accept                                             ${headerAcceptAll}
                                      Get                                    ${getUsersCounterEndpoint}
                                      ${responseStatus}=                     Get response status
                                      ${totalUsers}=                         Get response body
                                      log to console                         ${\n}Total users:${totalUsers}
                                      log to console                         ${\n}Status code:${responseStatus}
                                      Should contain                         ${responseStatus}                                  200
                                      [Return]                               ${totalUsers}

 Generate random user with last ID
                                      ${id}=                                 Get ID of last user
                                      ${userLogin}=                          Generate Random String                             8                                        [UPPER]
                                      ${userPassword}=                       Generate Random String                             8                                        [UPPER]
                                      ${userType}=                           Generate Random String                             1                                        2


                                      ${userClientId}=                       random User ClientId
                                      ${userStatusId}=                       random User StatusId                               #data for userStatusId in json format

                                      ${dictionary}=                         Create Dictionary                                  id=${id}                                 login=${userLogin}        password= ${userPassword}             typeUser=${userType}        clientId=${userClientId}      userStatusId=${userStatusId}
                                      ${userData}=                           Stringify Json                                     ${dictionary}
                                      [Return]                               ${userData}

Update User
                                      ${requestBody}=                        Generate random user with last ID
                                      ${lastUserID}=                         Get ID of last user
                                      Create http context                    ${httpContext}                                     ${httpVariable}
                                      Set request header                     Content-Type                                       ${headerContentJson}
                                      Set request header                     Accept                                             ${headerAcceptAll}
                                      Set request body                       ${requestBody}
                                      Put                                    ${updateUsersEndpoint}/${lastUserID}
                                      ${responseStatus}=                     Get response status
                                      Should contain                         ${responseStatus}                                  204
                                      Log to console                         ${responseStatus}

