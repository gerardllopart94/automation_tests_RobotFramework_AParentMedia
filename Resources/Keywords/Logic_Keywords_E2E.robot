*** Settings ***
Resource          Util_Keywords.robot
Resource          Database_Keywords.robot
Variables         ../Data/credentials_dictionary.py
Resource          Setup_Teardown.robot

*** Variables ***
${github_host_url}    ${credentials_dict}[githubAPIsVariables][githubPage]
${github_account_username}    ${credentials_dict}[githubAPIsVariables][githubAccountEmail]
${github_account_password}    ${credentials_dict}[githubAPIsVariables][githubAccountPassword]

*** Keywords ***
Go to github login page and perform login process
    [Arguments]    ${screenType}    ${dashboardButtonScreenType}
    Suite Setup open browser    ${screenType}
    Go To    ${github_host_url}/login
    Input text to element    usernameOrEmailInput    githubLoginPage    ${github_account_username}
    Input text to element    passwordInput    githubLoginPage    ${github_account_password}
    Perform element click    signInButton    githubLoginPage
    Wait for element to be visible    ${dashboardButtonScreenType}    githubDashboardPage
    Suite Teardown close browser