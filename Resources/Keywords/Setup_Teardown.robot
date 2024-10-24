*** Settings ***
Resource          Util_Keywords.robot
Library           DatabaseLibrary
Library           Collections

*** Keywords ***
Suite Setup open browser
    [Arguments]    ${screenType}
    ${dc}    Create Dictionary
    ${subdict}    Create Dictionary    browser=ALL
    Set To Dictionary    ${dc}    goog:loggingPrefs    ${subdict}
    Open Browser    about:blank    Chrome    options=add_argument("--headless"); add_argument("--window-size=1920x1040"); add_argument("--force-device-scale-factor=0.6"); add_argument("--disable-gpu"); add_argument("--no-sandbox"); add_argument("--disable-extensions"); add_argument("--incognito"); add_argument("--start-maximized")    desired_capabilities=${dc}
    IF    '${screenType}' == 'Mobile'
        Set Window Size    414    896
    END

Suite Teardown close browser
    Close All Browsers