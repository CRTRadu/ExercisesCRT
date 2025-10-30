*** Settings ***
Resource                  ../resources/common.robot
Resource                  ../resources/leads.robot
Library                   DataDriver                  file=../test-data.csv
Library                   FakerLibrary
Suite Setup               Setup Browser
Test Setup                Run Keywords                Home                  Unique Test Data
Suite Teardown            CloseAllBrowsers
Test Template             Create a Lead using CSV


*** Test Cases ***
Exercise - Data Driven Testing - Create Lead using Suite Test Template with ${lead_status} ${last_name} ${company} ${first_name} ${salutation}


*** Keywords ***

Create a Lead using CSV
    [Arguments]           ${lead_status}              ${last_name}          ${company}          ${first_name}    ${salutation}
    Create Lead           ${lead_status}              ${last_name}          ${company}          ${salutation}    ${first_name}
    Delete Lead           ${first_name}               ${last_name}

Unique Test Data
    ${Last_Name}=         Last Name
    Set Suite Variable    ${last_name}                ${Last_Name}
    ${Company}=           Company
    Set Suite Variable    ${company}                  ${Company}
    ${First_Name}=        First Name
    Set Suite Variable    ${first_name}               ${First_Name}