*** Settings ***
Resource          Util_Keywords.robot
Resource          Database_Keywords.robot
Library           RequestsLibrary
Library           Collections
Variables         ../Data/credentials_dictionary.py
Library           Logic_Keywords_API.py
Library    Process

*** Variables ***
${github_host}    ${credentials_dict}[githubAPIsVariables][githubApi]
${token}    ${credentials_dict}[githubAPIsVariables][token]  

*** Keywords ***
Create API session
    [Arguments]    ${endpoint_url}    ${needToken}
    IF    '${needToken}' == 'noTokenNeeded'
        Create Session    github_session    ${github_host}${endpoint_url}    verify=True
    ELSE IF    '${needToken}' == 'yesTokenNeeded'
        Create Session    github_session    ${github_host}${endpoint_url}    verify=True    headers={"Authorization": "token ${token}", "Accept": "application/vnd.github.v3+json", "X-GitHub-Api-Version": "2022-11-28"}
    END

Check endpoint response code
    [Arguments]    ${endpoint_url}    ${expected_endpoint_response_code}
    ${response_status}    Run Keyword And Return Status    GET On Session    github_session    ${github_host}${endpoint_url}
    IF    '${response_status}' == 'True'
        GET On Session    github_session    ${github_host}${endpoint_url}
    ELSE
        Log    No response!
    END
    Status Should Be    ${expected_endpoint_response_code}

Check endpoint response keys
    [Arguments]    ${endpoint_url}    @{expected_response_keys}
    ${response}    GET On Session    github_session    ${github_host}${endpoint_url}
    TRY
        ${keys}    Get Dictionary Keys    ${response.json()}
    EXCEPT
        FOR    ${repo}    IN    @{response.json()}
            ${keys}    Get All Keys    ${repo}
            Exit For Loop
        END
    END
    # Compare that all the elements of @{json_response} are in @{expected_response_keys}.
    # Check that there are no more elements in @{expected_response_keys} than in @{json_response}.
    List Should Contain Sub List    ${keys}    @{expected_response_keys}
    # Compare that all the elements of @{expected_response_keys} are in @{json_response}.
    # Check that there are no more elements in @{json_response} than in @{expected_response_keys}.
    List Should Contain Sub List    @{expected_response_keys}    ${keys}

Check endpoint length
    [Arguments]    ${endpoint_url}    ${expected_lenght}
    ${response}    GET On Session    github_session    ${github_host}${endpoint_url}
    ${json_lenght}    Get Length    ${response.json()}
    Should Be Equal    ${expected_lenght}    ${json_lenght}

Update endpoint metadata and check updated content
    [Arguments]    ${endpoint_url}    ${endpoint_element}    ${text}
    ${data}    Set Variable    {"${endpoint_element}": "${text}"}
    ${response}    PATCH On Session    github_session    ${github_host}${endpoint_url}    data=${data}
    Should Be Equal    ${response.status_code}    ${200}
    ${response}    GET On Session    github_session    ${github_host}${endpoint_url}
    ${APIData}    Set Variable    ${response.json()}
    Should Be Equal    ${APIData['${endpoint_element}']}    ${text}