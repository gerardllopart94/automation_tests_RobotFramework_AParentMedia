*** Settings ***
Resource          ../Resources/Keywords/Logic_Keywords_API.robot
Variables         ../Resources/Data/variables_dictionary.py

*** Variables ***
@{expresponse_user_public_profile}    ${var_dict}[gitHubAPIsExpResponseKeysDict][userPublicProfileResponseKeys]
@{expresponse_user_private_profile}    ${var_dict}[gitHubAPIsExpResponseKeysDict][userPrivateProfileResponseKeys]
@{expresponse_user_public_repos}    ${var_dict}[gitHubAPIsExpResponseKeysDict][userPublicReposResponseKeys]
@{expresponse_user_private_repos}    ${var_dict}[gitHubAPIsExpResponseKeysDict][userPrivateReposResponseKeys]

*** Test Cases ***
Check API endpoints code and response keys for profile endpoints
    [Template]    Check API response code and response keys in json format if necessary
    # Task 1
    /users/gerardllopart94    noTokenNeeded    200    yesNeedToCheckResponseKeys    @{expresponse_user_public_profile}
    /users/gerardllopart94usernotfound    noTokenNeeded    404    noNeedToCheckResponseKeys    ${EMPTY}
    # Task 2
    /user    yesTokenNeeded    200    yesNeedToCheckResponseKeys    @{expresponse_user_private_profile}
    /user    noTokenNeeded    401    noNeedToCheckResponseKeys    ${EMPTY}
    /userTest    noTokenNeeded    404    noNeedToCheckResponseKeys    ${EMPTY}
    # Task 3
    /users/gerardllopart94/repos    noTokenNeeded    200    yesNeedToCheckResponseKeys    @{expresponse_user_public_repos}
    /users/gerardllopart94usernotfound/repos    noTokenNeeded    404    noNeedToCheckResponseKeys    ${EMPTY}
    # Task 4
    /user/repos    yesTokenNeeded    200    yesNeedToCheckResponseKeys    @{expresponse_user_private_repos}
    /user/repos    noTokenNeeded    401    noNeedToCheckResponseKeys    ${EMPTY}
    /userTest/repos    noTokenNeeded    404    noNeedToCheckResponseKeys    ${EMPTY}
