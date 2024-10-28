# README for GitHub API Testing with Robot Framework

## Overview of Robot Framework

Robot Framework is an open-source automation framework widely used for acceptance testing and robotic process automation (RPA). It provides a simple, easy-to-understand syntax based on keywords, allowing testers and developers to create test cases in a natural language style. The framework supports the use of external libraries, enhancing its capabilities for different types of testing, including web, API, and database testing.

For a comprehensive understanding of Robot Framework, please refer to the official documentation: [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html).

---

## Test Case Breakdown

This section provides a detailed explanation of each test case included in the provided Robot Framework script, along with the keywords that each test case calls.

### *** Test Cases ***

#### Task 1 - External User Public Profile
- **Create API session**: Initializes a session for the specified GitHub user. It first checks the profile of a fake GitHub username to ensure it returns a 404 response (not found) and then checks the profile of the actual GitHub username to ensure it returns a 200 response (found).
- **Check endpoint response code**: Verifies the response code of the API call.
- **Check endpoint response keys**: Confirms that the response keys match the expected keys defined in the variable `${users_userid}`.

#### Task 2 & 6 - Logged User Own Profile & Update Logged User Metadata
- **Create API session**: Initializes the session for the logged user, first checking that without a token, it returns a 401 response (unauthorized), and then with a token, it returns a 200 response (authorized).
- **Check endpoint response code**: Validates the response code of the logged user API call.
- **Check endpoint response keys**: Asserts that the response keys are correct.
- **Update endpoint metadata**: Updates user metadata, such as name, bio, and blog, and checks the content values after each update to ensure they are correct. This involves generating random data (like a name, DNI, phone, and email) for testing purposes.

#### Task 3 - List Repositories
- **Create API session**: Creates a session to list repositories for the specified GitHub username.
- **Check endpoint response code**: Confirms that calling the repositories of a fake username returns a 404 status.
- **Check endpoint response keys**: Validates that the response keys for the repositories match the expected keys defined in `${users_userid_repos}`.
- **Check endpoint length**: This keyword counts the number of repositories returned in the response and ensures that the length matches the expected value defined in the test case.

#### Task 4 - List Repositories for Logged User
- **Create API session**: Similar to Task 3, it initializes a session to access the logged user's repositories, checking both unauthorized (401) and authorized (200) responses.
- **Check endpoint response keys**: Verifies the repository keys for the logged user.
- **Check endpoint length**: Asserts the expected length of the repositories list for the logged user.

#### Task 5 - List Commits of a Repository
- **Create API session**: Checks commits for a repository using both a fake and a real GitHub username, expecting 404 for the fake username and 200 for the valid one.
- **Check endpoint response keys**: Ensures the keys in the commits response are as expected.
- **Check endpoint length**: This keyword counts the number of commits returned in the response and validates that it matches the expected value.

#### Task 7 - Implement Testing Example Workflow
- This task essentially repeats steps from the earlier tasks to demonstrate a complete workflow. It includes checking user profiles, updating metadata, and listing repositories, similar to Tasks 2, 4, and 5, but structured in a sequential manner for testing purposes.

---

### *** Keywords ***

#### Create API session
This keyword initializes a session with the GitHub API, taking an endpoint URL and a flag indicating whether a token is required for authentication. Depending on this flag, it sets up the session either with or without an authorization token.

#### Check endpoint response code
This keyword checks the response code of an API call.

#### Check endpoint response keys
This keyword retrieves the keys from the API response and compares them with the expected keys to ensure they match. It handles both direct responses and lists of repositories.

#### Check endpoint length
This keyword counts the number of items returned in the API response. In Task 3, it counts the number of repositories, while in Task 5, it counts the number of commits. It validates that the returned count matches the expected value.

#### Update endpoint metadata and check updated content
This keyword sends a PATCH request to update specific metadata (like name or bio) for the logged user and verifies that the response indicates success (HTTP status code 200). Then, the same keyword retrieves a specific field from the API response and checks that it matches the expected value.

---

By understanding these test cases and keywords, you can effectively utilize Robot Framework for API testing, ensuring that your GitHub API interactions are functioning as expected.