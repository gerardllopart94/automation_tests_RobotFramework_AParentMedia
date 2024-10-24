*** Settings ***
Resource          ../Resources/Keywords/Logic_Keywords_E2E.robot

*** Test Cases ***
Github login process
    [Template]    Go to github login page and perform login process
    Desktop    dashboardButtonDesktop
    Mobile    dashboardButtonMobile