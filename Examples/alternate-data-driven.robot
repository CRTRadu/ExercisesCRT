*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../resources/leads.robot
Library                         DataDriver     reader_class=TestDataApi    name=Leads_2.xlsx   include=alternate CSV    #exclude=tagtoexclude
Suite Setup                     Setup Browser
Test Setup                      Run Keywords                Home 
Suite Teardown                  Close All Browsers
Test Template                   Create Verify and Delete Lead End to End


*** Test Cases ***
Exercise 14 - Data Driven Testing - Create Lead using Suite Test Template with ${lead_status} ${last_name} ${company} ${first_name} ${salutation}
    [Tags]                    alternate CSV

*** Keywords ***

Create Verify and Delete Lead End to End
    [Arguments]                 ${lead_status}              ${last_name}                ${company}             ${first_name}               ${salutation}       
    Create Lead                 ${lead_status}              ${last_name}                ${company}             ${salutation}               ${first_name}         
    Verify Lead                 ${lead_status}              ${last_name}                ${company}             ${salutation}               ${first_name}
    Delete Lead                 ${first_name}               ${last_name}
