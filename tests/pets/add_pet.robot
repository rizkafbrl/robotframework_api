*** Settings ***
Resource          ../../resources/keywords/pet_keywords.robot

*** Variables ***
${PET_STATUS}     available

*** Test Cases ***
Add New Pet
    [Documentation]           This test case adds a new pet and verifies its creation.
    [Tags]                    TC_ID_001
    Setup API Session
    Create Pet                Cat1    ${PET_STATUS}
    Verify Pet Created        Cat1    ${PET_STATUS}

Add New Pet 2
    [Documentation]           This test case adds a new pet and verifies its creation.
    [Tags]                    TC_ID_002
    Setup API Session
    Create Pet                Cat2    ${PET_STATUS}
    Verify Pet Created        Cat2    ${PET_STATUS}
