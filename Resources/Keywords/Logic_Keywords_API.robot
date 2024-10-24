*** Settings ***
Resource          Util_Keywords.robot
Resource          Database_Keywords.robot
Library           RequestsLibrary
Library           Collections
Variables         ../Data/credentials_dictionary.py

*** Variables ***
${github_host}    ${credentials_dict}[githubAPIsVariables][githubApi]
${token}    ${credentials_dict}[githubAPIsVariables][token]  

*** Keywords ***
Create API session
    [Arguments]    ${endpoint_url}    ${needToken}
    IF    '${needToken}' == 'noTokenNeeded'
        Create Session    github_session    ${github_host}${endpoint_url}    verify=True
    ELSE IF    '${needToken}' == 'yesTokenNeeded'
        Create Session    github_session    ${github_host}${endpoint_url}    verify=True    headers={"Authorization": "token ${token}"}
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
        ${json_keys}    Get Dictionary Keys    ${response.json()}
    EXCEPT
        ${json_keys}    Create List
        FOR    ${repo}    IN    @{response.json()}
            ${json_keys}    Get Dictionary Keys    ${repo}
        END
    END
    # Comparem que tots els elements de @{json_response} estiguin a @{expected_response_keys}
    # Així veiem que a @{expected_response_keys} no hi ha més elements que a @{json_response}
    List Should Contain Sub List    ${json_keys}    ${expected_response_keys}
    # Comparem que tots els elements de @{expected_response_keys} estiguin a @{json_response}
    # Així veiem que a @{json_response} no hi ha més elements que a @{expected_response_keys}
    List Should Contain Sub List    ${expected_response_keys}    ${json_keys}

Check endpoint lenght
    [Arguments]    ${endpoint_url}    ${expected_lenght}
    ${response}    GET On Session    github_session    ${github_host}${endpoint_url}
    Log    ${response.json()}
    ${json_lenght}    Get Length    ${response.json()}
    Should Be Equal    ${expected_lenght}    ${json_lenght}
