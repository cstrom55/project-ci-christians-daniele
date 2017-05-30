*** Settings ***
Library                                 HttpLibrary.HTTP
Library                                 Collections
Library                                 String
Library                                 json

*** Variables ***
${httpContext}=                         localhost:8080
${httpVariable}=                        http
${headerContentJson}=                   application/json
${headerAcceptAll}=                     */*

#GET endpoints
${getAllBedroomsEndpoint}=              /hotel-rest/webresources/bedroom/
${getBedroomCounterEndpoint}=           /hotel-rest/webresources/bedroom/count
${getBedroomByIdEndpoint}=              /hotel-rest/webresources/bedroom/         #id
#POST endpoint
${createBedroomEndpoint}=               /hotel-rest/webresources/bedroom/
#PUT endpoint
${updateBedroomEndpoint}=               /hotel-rest/webresources/bedroom/         #id
#Delete endpoint
${deleteBedroomEndpoint}=               /hotel-rest/webresources/bedroom/         #id

*** Keywords ***
Get ID of last bedroom  #
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Get                                       ${getAllBedroomsEndpoint}
                                        ${responseStatusFirstRequest}=            Get response status
                                        Should contain                            ${responseStatusFirstRequest}                          200
                                        ${bodyFirstRequest}=                      Get response body
                                        Get                                       ${getBedroomCounterEndpoint}
                                        ${responseStatusSecondRequest}=           Get response status
                                        Should contain                            ${responseStatusSecondRequest}                         200
                                        ${bodySecondRequest}=                     Get response body
                                        ${lastIndex}=                             Evaluate                                               ${bodySecondRequest}-1
                                        ${jsonId}=                                Get json value                                         ${bodyFirstRequest}       /${lastIndex}/id
                                        Log to console                            ${jsonId}
                                        [Return]                                  ${jsonId}

Generate random bedroom  #
                                        ${id}=                                    Set variable                                           100
                                        ${description}=                           Generate random string                                 5                         [UPPER]
                                        ${floor}=                                 Set variable                                           1
                                        ${number}=                                Set variable                                           111
                                        ${priceDaily}=                            Generate random string                                 3                         [NUMBERS]
                                        ${bedroomStatusIdDictionary}=             Create dictionary                                      id=1                      code=0                        name=VACANT
                                        ${typeBedroomIdDictionary}=               Create dictionary                                      id=6                      name=WHEELCHAIR ACCESS
                                        ${dictionary}=                            Create dictionary                                      id=${id}                  description=${description}    floor=${floor}    number=${number}    priceDaily=${priceDaily}    bedroomStatusId=${bedroomStatusIdDictionary}    typeBedroomId=${typeBedroomIdDictionary}
                                        ${bedroomJson}=                           Stringify json                                         ${dictionary}
                                        Log to console                            ${\n}Random bedroom created
                                        [return]                                  ${bedroomJson}
                                        
Generate random bedroom with last ID  ###
                                        ${id}=                                    Get ID of last bedroom
                                        ${description}=                           Generate random string                                 5                         [UPPER]
                                        ${floor}=                                 Set variable                                           1
                                        ${number}=                                Set variable                                           111
                                        ${priceDaily}=                            Generate random string                                 3                         [NUMBERS]
                                        ${bedroomStatusIdDictionary}=             Create dictionary                                      id=1                      code=0                        name=VACANT
                                        ${typeBedroomIdDictionary}=               Create dictionary                                      id=6                      name=WHEELCHAIR ACCESS
                                        ${dictionary}=                            Create dictionary                                      id=${id}                  description=${description}    floor=${floor}    number=${number}    priceDaily=${priceDaily}    bedroomStatusId=${bedroomStatusIdDictionary}    typeBedroomId=${typeBedroomIdDictionary}
                                        ${bedroomJson}=                           Stringify json                                         ${dictionary}
                                        [return]                                  ${bedroomJson}

Create bedroom  ###
                                        ${requestBody} =                          Generate random bedroom
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Set request header                        Content-Type                                           ${headerContentJson}
                                        Set request header                        Accept                                                 ${headerAcceptAll}
                                        Set request body                          ${requestBody}
                                        Log to console                            ${\n}Creating a new bedroom${\n}DATA:${requestBody}
                                        Post                                      ${createBedroomEndpoint}
                                        ${responseStatus}=                        Get response status
                                        log to console                            ${\n}Status code:${responseStatus}
                                        Should contain                            ${responseStatus}                                      204

Get all bedrooms  #
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Set request header                        Content-Type                                           ${headerContentJson}
                                        Set request header                        Accept                                                 ${headerAcceptAll}
                                        Get                                       ${getAllBedroomsEndpoint}
                                        ${responseStatus}=                        Get response status
                                        ${allBedrooms}=                           Get response body
                                        log to console                            ${\n}Bedrooms:${allBedrooms}
                                        log to console                            ${\n}Status code:${responseStatus}
                                        Should contain                            ${responseStatus}                                      200
                                        [Return]                                  ${allBedrooms}

Get total number of bedrooms  #
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Set request header                        Content-Type                                           ${headerContentJson}
                                        Set request header                        Accept                                                 ${headerAcceptAll}
                                        Get                                       ${getBedroomCounterEndpoint}
                                        ${responseStatus}=                        Get response status
                                        ${totalBedrooms}=                         Get response body
                                        log to console                            ${\n}Total bedrooms:${totalBedrooms}
                                        log to console                            ${\n}Status code:${responseStatus}
                                        Should contain                            ${responseStatus}                                      200
                                        [Return]                                  ${totalBedrooms}

Update bedroom  ###
                                        ${requestBody}=                           Generate random bedroom with last ID
                                        ${lastBedroomID}=                         Get ID of last bedroom
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Set request header                        Content-Type                                           ${headerContentJson}
                                        Set request header                        Accept                                                 ${headerAcceptAll}
                                        Set request body                          ${requestBody}
                                        Put                                       ${updateBedroomEndpoint}/${lastBedroomID}
                                        ${responseStatus}=                        Get response status
                                        Should contain                            ${responseStatus}                                      204
                                        Log to console                            ${responseStatus}
                                        Log to console                            ${\n}Bedroom updated, ID:${lastBedroomID}${\n}DATA:${requestBody}

Delete last bedroom  #
                                        ${lastBedroomID}=                         Get ID of last bedroom
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Delete                                    ${deleteBedroomEndpoint}/${lastBedroomID}
                                        ${responseStatus}=                        Get response status
                                        Should contain                            ${responseStatus}                                      204
                                        Log to console                            ${responseStatus}
                                        Log to console                            ${\n}Bedroom deleted, ID:${lastBedroomID}

Get bedroom by ID  #
                                        ${lastBedroomID}=                         Get ID of last bedroom
                                        Create http context                       ${httpContext}                                         ${httpVariable}
                                        Get                                       ${getBedroomByIdEndpoint}/${lastBedroomID}
                                        ${responseStatus}=                        Get response status
                                        ${responseBody}=                          Get response body
                                        Should contain                            ${responseStatus}                                      200
                                        Log to console                            ${responseStatus}
                                        Log to console                            ${responseBody}
                                        [Return]                                  ${responseBody}





