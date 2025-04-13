*** Settings ***
Resource          ../../resources/keywords/pet_keywords.robot

*** Test Cases ***
Add New Pet
    [Documentation]           This test case adds a new pet and verifies its creation.
    [Tags]                    TC_ID_001
    Setup API Session
    Create Pet                Cat1    available   1
    Verify Pet Created        Cat1    available  

Add New Pet 2
    [Documentation]           This test case adds a new pet and verifies its creation.
    [Tags]                    TC_ID_002
    Setup API Session
    Create Pet                Cat2    pending     2
    Verify Pet Created        Cat2    pending
