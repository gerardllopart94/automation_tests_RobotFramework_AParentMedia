elements_dict = {
  "githubLoginPage" : {
      "usernameOrEmailInput" : 'xpath: //input[@id="login_field"]',
      "passwordInput" : 'xpath: //input[@id="password"]',
      "signInButton" : 'xpath: //input[@data-signin-label="Sign in"]',
  },
  "githubDashboardPage" : {
      "dashboardButtonDesktop" : 'xpath: //a/span[contains(text(),"Dashboard")]',
      "dashboardButtonMobile" : 'xpath: //strong/span[contains(text(),"Dashboard")]'
  }
}
