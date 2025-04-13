*** Settings ***
Library                               RequestsLibrary
Library                               Collections
Library                               OperatingSystem
Resource                              ../variables/common_variables.robot

*** Keywords ***
Setup API Session
    [Documentation]    Sets up the API session for the Pet Store API.
    Create Session     petstore    ${BASE_URL}    verify=${FALSE}
    Disable Warnings

Disable Warnings
    [Documentation]    Disables insecure request warnings.
    Evaluate    __import__('urllib3').disable_warnings()    modules=urllib3

Get Json Value
    [Arguments]        ${json_data}    ${json_path}
    [Documentation]    Extracts values from JSON data using a JSONPath expression.
    ${matches}=        Evaluate    [match.value for match in __import__('jsonpath_ng').parse("${json_path}").find(${json_data})]
    Run Keyword If     len(${matches}) == 0    Fail    No matches found for JSONPath: ${json_path}
    RETURN             ${matches}

Send POST Request
    [Arguments]     ${endpoint}    ${data}
    Setup API Session
    ${response}=    POST On Session    petstore    ${endpoint}    json=${data}
    RETURN    ${response}

Send GET Request
    [Arguments]     ${endpoint}    ${params}=${NONE}
    Setup API Session
    ${response}=    GET On Session    petstore    ${endpoint}    params=${params}
    RETURN          ${response}

Create Pet
    [Arguments]       ${petName}                ${petStatus}      ${petID}
    # ${category}=      Create Dictionary      id=1        name=Cats
    ${payload}=       Create Dictionary    
    ...               name=${petName}    
    ...               status=${petStatus}
    ...               id=${petID}
    # ...               category=${category}
    ${response}=               Send POST Request       ${PET_ENDPOINT}            ${payload}
    Should Be Equal As Numbers                         ${response.status_code}    200
    ${json_response}=          Set Variable            ${response.json()}
    ${response_pet_id}=        Set Variable            ${json_response}[id]
    ${response_pet_name}=      Set Variable            ${json_response}[name]
    ${response_pet_status}=    Set Variable            ${json_response}[status]
    Should Be Equal As Integers    ${response_pet_id}        ${petID}         Pet ID does not match
    Should Be Equal As Strings     ${response_pet_name}      ${petName}       Pet Name is empty
    Should Be Equal As Strings     ${response_pet_status}    ${petStatus}     Pet Status is empty
  

Verify Pet Created
    [Arguments]       ${name}    ${status}
    ${params}=        Create Dictionary       status=${status}
    ${response}=      Send GET Request        ${FIND_PETS_BY_STATUS_ENDPOINT}    ${params}
    ${json_response}=      Set Variable    ${response.json()}
    FOR    ${pet}    IN    @{json_response}
        ${pet_name}=    Set Variable    ${pet}[name]
        Run Keyword If    '${pet_name}' == '${name}'    Exit For Loop
    END
    Should Be Equal    ${pet_name}    ${name}    Pet was not found in the response

Get Pets By Status
    [Arguments]        ${status}
    ${response}=       GET On Session    petstore    ${FIND_PETS_BY_STATUS_ENDPOINT}    params=status=${status}
    RETURN             ${response}

Get Pet By ID
    [Arguments]        ${pet_id}
    ${response}=       GET On Session    petstore    ${RETRIEVE_PET_BY_ID_ENDPOINT}/${pet_id}
    RETURN             ${response}

Verify Pets Status
    [Arguments]        ${response}       ${expected_status}
    ${pets}=           Get Json Value    ${response.json()}    $[*]
    FOR     ${pet}    IN    @{pets}
        Should Be Equal As Strings    ${pet}[status]    ${expected_status}
    END

Verify Pet By ID
    [Arguments]        ${response}       ${expected_id}
    ${pets}=           Get Json Value    ${response.json()}    $[*]
    Run Keyword If    len(${pets}) == 0    Fail    No pets found in the response.
    ${pet}=    Set Variable    ${pets}[0]
    Log    Verifying pet: ${pet}    console=True
    Should Be Equal As Numbers    ${pet}[id]    ${expected_id}
    Should Not Be Empty    ${pet}[name]
    Should Not Be Empty    ${pet}[status]