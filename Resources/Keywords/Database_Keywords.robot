*** Settings ***
Library           DatabaseLibrary

*** Variables ***
${DB_HOST}
${DB_PORT}
${DB_USER}
${DB_PASSWORD}
${DB_SCHEMA}

*** Keywords ***
Perform DB connection
    Connect To Database    pymysql    ${DB_SCHEMA}    ${DB_USER}    ${DB_PASSWORD}    ${DB_HOST}    ${DB_PORT}

Perform DB disconnection
    Disconnect From Database

Example keyword for database checks
    [Arguments]    ${email}
    Perform DB connection
    # Your check here
    Disconnect From Database