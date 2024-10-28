*** Settings ***
Resource          ../Resources/Keywords/Logic_Keywords_API.robot
Variables         ../Resources/Data/expected_keys_dictionary.py
Resource          ../Resources/Keywords/Util_Keywords.robot

*** Variables ***
${github_username}    ${credentials_dict}[githubAPIsVariables][username]
${github_fake_username}    ${credentials_dict}[githubAPIsVariables][fakeUsername]
${githubRepo}    ${credentials_dict}[githubAPIsVariables][repo]
${fakeGithubRepo}    ${credentials_dict}[githubAPIsVariables][fakeRepo]
@{/users/userid}    ${users_userid}
@{/user}    ${user}
@{/users/userid/repos}    ${users_userid_repos}
@{/user/repos}    ${user_repos}
@{/repos/userid/repoid/commits}    ${repos_userid_repoid_commits}

*** Test Cases ***
Task 1 - External user public profile
    Create API session    /users/${github_fake_username}    noTokenNeeded
    Check endpoint response code    /users/${github_fake_username}    404
    Create API session    /users/${github_username}    noTokenNeeded
    Check endpoint response code    /users/${github_username}    200
    Check endpoint response keys    /users/${github_username}    @{/users/userid}

Task 2 & 6 - Logged user own profile & Update logged user metadata
    Create API session    /user    noTokenNeeded
    Check endpoint response code    /user    401
    Create API session    /user    yesTokenNeeded
    Check endpoint response code    /user    200    
    Check endpoint response keys     /user    @{/user}
    ${random}    Get 8digit number Random
    ${userName_data}    Catenate    gerardLlopartId${random}
    Update endpoint metadata and check updated content     /user    name    ${userName_data}
    ${DNI}    Generate Valid DNI
    ${phone}    Generate phone
    ${bio_data}    Catenate    I'm Gerard and my DNI is ${DNI} and my phone is ${phone}
    Update endpoint metadata and check updated content     /user    bio    ${bio_data}
    ${email}    Generate email
    ${blog_data}    Catenate    If you wanna see my blog, please send an email to ${email}
    Update endpoint metadata and check updated content     /user    blog    ${blog_data}

Task 3 - List repositories
    Create API session    /users/${github_username}/repos    noTokenNeeded
    Check endpoint response code    /users/${github_fake_username}/repos    404
    Create API session    /users/${github_username}/repos    yesTokenNeeded
    Check endpoint response code    /users/${github_username}/repos    200    
    Check endpoint response keys    /users/${github_username}/repos    @{/users/userid/repos}
    Check endpoint length    /users/${github_username}/repos    ${1}

Task 4 - List repositories for logged user
    Create API session    /user/repos    noTokenNeeded
    Check endpoint response code    /user/repos    401
    Create API session    /user/repos    yesTokenNeeded
    Check endpoint response code    /user/repos    200
    Check endpoint response keys    /user/repos    @{/user/repos}
    Check endpoint length    /user/repos    ${1}

Task 5 - List commits of a repository
    Create API session    /repos/${github_fake_username}/${githubRepo}/commits    noTokenNeeded
    Check endpoint response code    /repos/${github_fake_username}/${githubRepo}/commits    404
    Create API session    /repos/${github_username}/${fakeGithubRepo}/commits    noTokenNeeded
    Check endpoint response code    /repos/${github_username}/${fakeGithubRepo}/commits    404
    Create API session    /repos/${github_username}/${githubRepo}/commits    noTokenNeeded
    Check endpoint response code    /repos/${github_username}/${githubRepo}/commits    200
    Check endpoint response keys    /repos/${github_username}/${githubRepo}/commits    @{/repos/userid/repoid/commits}
    Check endpoint length    /repos/${github_username}/${githubRepo}/commits    ${6}

# TASK 7 IS DONE WITHIN THE OTHER TASKS BUT IT'S REPEATED HERE
Task 7 - Implement testing example workflow
    # Step 1
    Create API session    /user    noTokenNeeded
    Check endpoint response code    /user    401
    # Step 2
    Create API session    /user    yesTokenNeeded
    Check endpoint response code    /user    200
    # Step 3 & 4
    ${DNI}    Generate Valid DNI
    ${phone}    Generate phone
    ${bio_data}    Catenate    I'm Gerard and my DNI is ${DNI} and my phone is ${phone}
    Update endpoint metadata and check updated content     /user    bio    ${bio_data}
    ${random}    Get 8digit number Random
    ${userName_data}    Catenate    gerardLlopartId${random}
    Update endpoint metadata and check updated content     /user    name    ${userName_data}
    # Steps 5 & 7 & 8
    Create API session    /user/repos    yesTokenNeeded
    Check endpoint response keys    /user/repos    @{/user/repos}
    Check endpoint length    /user/repos    ${1}
    # Step 6
    Create API session    /repos/${github_username}/${fakeGithubRepo}/commits    noTokenNeeded
    Check endpoint response code    /repos/${github_username}/${fakeGithubRepo}/commits    404