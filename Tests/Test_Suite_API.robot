*** Settings ***
Resource          ../Resources/Keywords/Logic_Keywords_API.robot

*** Variables ***
${github_username}    ${credentials_dict}[githubAPIsVariables][username]
${github_fake_username}    ${credentials_dict}[githubAPIsVariables][fakeUsername]
@{expresponse_user_public_profile}    login    id    node_id    avatar_url    gravatar_id    url    html_url    followers_url    following_url    
...    gists_url    starred_url    subscriptions_url    organizations_url    repos_url    events_url    received_events_url    type    
...    user_view_type    site_admin    name    company    blog    location    email    hireable    bio    twitter_username    public_repos    
...    public_gists    followers    following    created_at    updated_at
@{expresponse_user_private_profile}    avatar_url    bio    blog    company    created_at    email    events_url    followers    followers_url    
...    following    following_url    gists_url    gravatar_id    hireable    html_url    id    location    login    name    node_id    
...    notification_email    organizations_url    public_gists    public_repos    received_events_url    repos_url    site_admin    starred_url    
...    subscriptions_url    twitter_username    type    updated_at    url    user_view_type    collaborators    disk_usage    owned_private_repos    
...    plan    private_gists    total_private_repos    two_factor_authentication
@{expresponse_user_public_repos}    id    node_id    name    full_name    private    owner    html_url    description    fork    url    forks_url    
...    keys_url    collaborators_url    teams_url    hooks_url    issue_events_url    events_url    assignees_url    branches_url    tags_url    
...    blobs_url    git_tags_url    git_refs_url    trees_url    statuses_url    languages_url    stargazers_url    contributors_url    subscribers_url    
...    subscription_url    commits_url    git_commits_url    comments_url    issue_comment_url    contents_url    compare_url    merges_url    
...    archive_url    downloads_url    issues_url    pulls_url    milestones_url    notifications_url    labels_url    releases_url    deployments_url    
...    created_at    updated_at    pushed_at    git_url    ssh_url    clone_url    svn_url    homepage    size    stargazers_count    watchers_count    
...    language    has_issues    has_projects    has_downloads    has_wiki    has_pages    has_discussions    forks_count    mirror_url    archived    
...    disabled    open_issues_count    license    allow_forking    is_template    web_commit_signoff_required    topics    visibility    forks    
...    open_issues    watchers    default_branch    permissions
@{expresponse_user_private_repos}    allow_forking    archive_url    archived    assignees_url    blobs_url    branches_url    clone_url    
...    collaborators_url    comments_url    commits_url    compare_url    contents_url    contributors_url    created_at    default_branch    
...    deployments_url    description    disabled    downloads_url    events_url    fork    forks    forks_count    forks_url    full_name    
...    git_commits_url    git_refs_url    git_tags_url    git_url    has_discussions    has_downloads    has_issues    has_pages    has_projects    
...    has_wiki    homepage    hooks_url    html_url    id    is_template    issue_comment_url    issue_events_url    issues_url    keys_url    
...    labels_url    language    languages_url    license    merges_url    milestones_url    mirror_url    name    node_id    notifications_url    
...    open_issues    open_issues_count    owner    permissions    private    pulls_url    pushed_at    releases_url    size    ssh_url    
...    stargazers_count    stargazers_url    statuses_url    subscribers_url    subscription_url    svn_url    tags_url    teams_url    topics    
...    trees_url    updated_at    url    visibility    watchers    watchers_count    web_commit_signoff_required

*** Test Cases ***
Task 1 - External user public profile
    # Iniciem sessió amb usuari que no existeix.
    Create API session    /users/${github_fake_username}    noTokenNeeded
    Check endpoint response code    /users/${github_fake_username}    404
    # Iniciem sessió amb token. Comprobem keys.
    Create API session    /users/${github_username}    noTokenNeeded
    Check endpoint response code    /users/${github_username}    200
    Check endpoint response keys    /users/${github_username}    @{expresponse_user_public_profile}

Task 2 - Logged user own profile
    # Iniciem sessió sense token.
    Create API session    /user    noTokenNeeded
    Check endpoint response code    /user    401
    # Iniciem sessió amb token. Comprobem keys.
    Create API session    /user    yesTokenNeeded
    Check endpoint response code    /user    200    
    Check endpoint response keys     /user    @{expresponse_user_private_profile}

Task 3 - List repositories
    # Iniciem sessió amb usuari que no existeix.
    Create API session    /users/${github_username}/repos    noTokenNeeded
    Check endpoint response code    /users/${github_fake_username}/repos    404
    # Iniciem sessió amb usuari correcte. Comprobem keys.
    Create API session    /users/${github_username}/repos    yesTokenNeeded
    Check endpoint response code    /users/${github_username}/repos    200    
    Check endpoint response keys    /users/${github_username}/repos    @{expresponse_user_public_repos}
    Check endpoint lenght    /users/${github_username}/repos    ${1}
        # Mesurem llargada endpoint amb length - ens donarà el num de repos.
        # Fiquem 1 ja que només tenim un repository.    @{expresponse_user_public_repos}
    
Task 4 - List repositories for logged user
        # Iniciem sessió sense token.
    Create API session    /user/repos    noTokenNeeded
    Check endpoint response code    /user/repos    401
        # Iniciem sessió amb token
    Create API session    /user/repos    yesTokenNeeded
    Check endpoint response code    /user/repos    200
    Check endpoint response keys    /user/repos    @{expresponse_user_private_repos}
    Check endpoint lenght    /user/repos    ${1}
        # Mesurem llargada endpoint amb length - ens donarà el num de repos.
        # Fiquem 1 ja que només tenim un repository.
