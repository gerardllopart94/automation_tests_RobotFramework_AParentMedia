*** Settings ***
Resource          Util_Keywords.robot
Resource          Database_Keywords.robot
Library           RequestsLibrary
Library           Collections
Variables         ../Data/credentials_dictionary.py

*** Variables ***
${github_host}    ${credentials_dict}[envDictGithub][githubApi]
${token}    ${credentials_dict}[envDictGithub][token]  

*** Keywords ***
Check API response code and response keys in json format if necessary
    [Arguments]    ${endpoint_url}    ${needToken}    ${expected_endpoint_response_code}    ${needToCheckResponseKeys}    @{expected_response_keys}
    IF    '${needToken}' == 'noTokenNeeded'
        Create Session    github_session    ${github_host}${endpoint_url}    verify=True
    ELSE IF    '${needToken}' == 'yesTokenNeeded'
        Create Session    github_session    ${github_host}${endpoint_url}    verify=True    headers={"Authorization": "token ${token}"}
    END
    ${response_status}    Run Keyword And Return Status    GET On Session    github_session    ${github_host}${endpoint_url}
    IF    '${response_status}' == 'True'
        ${response}    GET On Session    github_session    ${github_host}${endpoint_url}
    END
    Status Should Be    ${expected_endpoint_response_code}
    IF    '${needToCheckResponseKeys}' == 'yesNeedToCheckResponseKeys'
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
    END
