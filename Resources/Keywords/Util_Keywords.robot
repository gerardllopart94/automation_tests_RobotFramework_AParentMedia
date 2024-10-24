*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Variables         ../Data/elements_dictionary.py
Library           String
Library           OperatingSystem

*** Variables ***
${waiting_time}    10s

*** Keywords ***
Perform element click
    [Arguments]    ${element}    ${page}    ${dictionaryVariableToReplace}=${EMPTY}    ${valueToReplaceToDictionary}=${EMPTY}
    IF    '${dictionaryVariableToReplace}' != '${EMPTY}' and '${valueToReplaceToDictionary}' != '${EMPTY}'
        ${elementPath}    Replace String    ${elements_dict}[${page}][${element}]    ${dictionaryVariableToReplace}    ${valueToReplaceToDictionary}
        Wait Until Element Is Visible    ${elementPath}   ${waiting_time}
        Wait until keyword succeeds    10x    1s    Scroll Element Into View    ${elementPath}
        Wait until keyword succeeds    10x    1s    Click Element    ${elementPath}
    ELSE
        Wait Until Element Is Visible    ${elements_dict}[${page}][${element}]    ${waiting_time}
        Wait until keyword succeeds    10x    1s    Scroll Element Into View    ${elements_dict}[${page}][${element}]
        Wait until keyword succeeds    10x    1s    Click Element    ${elements_dict}[${page}][${element}]
    END

Input text to element
    [Arguments]    ${element}    ${page}    ${text}    ${dictionaryVariableToReplace}=${EMPTY}    ${valueToReplaceToDictionary}=${EMPTY}
    IF    '${dictionaryVariableToReplace}' != '${EMPTY}' and '${valueToReplaceToDictionary}' != '${EMPTY}'
        ${elementPath}    Replace String    ${elements_dict}[${page}][${element}]    ${dictionaryVariableToReplace}    ${valueToReplaceToDictionary}
        Wait Until Element Is Visible    ${elementPath}   ${waiting_time}
        Wait until keyword succeeds    10x    1s    Scroll Element Into View    ${elementPath}
        Wait until keyword succeeds    10x    1s    Input Text    ${elementPath}    ${text}
    ELSE
        Wait Until Element Is Visible    ${elements_dict}[${page}][${element}]    ${waiting_time}
        Wait until keyword succeeds    10x    1s    Scroll Element Into View    ${elements_dict}[${page}][${element}]
        Wait until keyword succeeds    10x    1s    Input Text    ${elements_dict}[${page}][${element}]    ${text}
    END

Upload file to element
    [Arguments]    ${element}    ${page}    ${fileType}    ${dictionaryVariableToReplace}=${EMPTY}    ${valueToReplaceToDictionary}=${EMPTY}
    IF    '${fileType}' != 'photo'
        ${path}    Normalize Path    ${CURDIR}${/}..${/}..${/}Data${/}manolitos.png
    ELSE IF    '${fileType}' != 'text'
        ${filePath}    Normalize Path    ${CURDIR}${/}..${/}..${/}Data${/}contrato.pdf
    END
    IF    '${dictionaryVariableToReplace}' != '${EMPTY}' and '${valueToReplaceToDictionary}' != '${EMPTY}'
        ${elementPath}    Replace String    ${elements_dict}[${page}][${element}]    ${dictionaryVariableToReplace}    ${valueToReplaceToDictionary}
        Wait Until Element Is Visible    ${elementPath}   ${waiting_time}
        Wait until keyword succeeds    10x    1s    Scroll Element Into View    ${elementPath}
        Wait until keyword succeeds    10x    1s    Choose File    ${elementPath}    ${filePath}
    ELSE
        Wait Until Element Is Visible    ${elements_dict}[${page}][${element}]    ${waiting_time}
        Wait until keyword succeeds    10x    1s    Scroll Element Into View    ${elements_dict}[${page}][${element}]
        Wait until keyword succeeds    10x    1s    Choose File    ${elements_dict}[${page}][${element}]    ${filePath}
    END

Wait for element to be visible
    [Arguments]    ${element}    ${page}    ${dictionaryVariableToReplace}=${EMPTY}    ${valueToReplaceToDictionary}=${EMPTY}
    IF    '${dictionaryVariableToReplace}' != '${EMPTY}' and '${valueToReplaceToDictionary}' != '${EMPTY}'
        ${elementPath}    Replace String    ${elements_dict}[${page}][${element}]    ${dictionaryVariableToReplace}    ${valueToReplaceToDictionary}
        Wait Until Element Is Visible    ${elementPath}   ${waiting_time}
    ELSE
        Wait Until Element Is Visible    ${elements_dict}[${page}][${element}]    ${waiting_time}
    END

Get 8digit number Random
    ${random}    Generate random string    8    0123456789
    RETURN    ${random}

Generate email
    ${random}    Get 8digit number Random
    ${email}    Catenate    rbtFwk${random}@gmail.com
    RETURN    ${email}

Generate Valid DNI
    ${digits}    Get 8digit number Random
    ${dni_number}    Convert To Number    ${digits}
    ${letter}    Calculate DNILetter    ${dni_number}
    ${dni}    Set Variable    ${digits}${letter}
    [Return]    ${dni}

Calculate DNILetter
    [Arguments]    ${dni_number}
    ${letters}    Set Variable    TRWAGMYFPDXBNJZSQVHLCKE
    ${index}    Evaluate    ${dni_number} % 23
    ${letter}    Get Substring    ${letters}    ${index}    ${index+1}
    [Return]    ${letter}

Generate phone
    ${random}    Get 8digit number Random
    ${phone}    Catenate    6${random}
    RETURN    ${phone}
