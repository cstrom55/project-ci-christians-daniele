*** Settings ***
Resource                  bedroomOperations.robot
Resource     userOperations.robot

*** Test cases***
Testcase1_GetAllBedrooms
    Get all bedrooms
Testcase2_GetBedroomTotal
    Get total number of bedrooms
Testcase3_PostNewBedroom
    Create bedroom
    Delete last bedroom
Testcase4_GetBedroomByID
    Create bedroom
    Get bedroom by ID
    Delete last bedroom
Testcase5_PutBedroom
    Create bedroom
    Update bedroom
    Delete last bedroom
Testcase6_GetAllUsers
    Get All Users