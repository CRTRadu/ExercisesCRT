*** Settings ***
Resource                        ../resources/common.robot
Library                         FakerLibrary
Library                         QWeb
Library                         String
Suite Setup                     Run Keywords    Setup Browser
Suite Teardown                  End suite


*** Test Cases ***

Enter A Lead
    Appstate                    Home
    Unique Test Data
    LaunchApp                   Sales
    ClickText                   Leads                       partial_match=false
    ClickText                   New
    VerifyText                  Lead Information
    UseModal                    On                          # Only find fields from open modal dialog
    Picklist                    Salutation                  Srta.
    TypeText                    First Name                  ${first_name}
    TypeText                    Last Name                   ${last_name}
    Picklist                    Lead Status                 New
    # generate random phone number, just as an example
    # NOTE: initialization of random number generator is done on suite setup
    ${rand_phone}=              Generate Random String      14                          [NUMBERS]
    # concatenate leading "+" and random numbers
    ${phone}=                   SetVariable                 +${rand_phone}
    TypeText                    Phone                       ${phone}                    
    TypeText                    Company                     ${company}                
    TypeText                    Title                       ${job}                      
    TypeText                    Email                       ${email}                 
    TypeText                    Website                     https://www.growmore.com/

    Picklist                    Lead Source                 Partner
    ClickText                   Save                        partial_match=False
    UseModal                    Off
    Sleep                       1

    ClickText                   Details
    VerifyField                 Name                        Srta. ${first_name} ${last_name}
    VerifyField                 Lead Status                 New
    VerifyField                 Phone                       ${phone}
    VerifyField                 Company                     ${company}
    VerifyField                 Website                     https://www.growmore.com/

    # as an example, let's check Phone number format. Should be "+" and 14 numbers
    ${phone_num}=               GetFieldValue               Phone
    Should Match Regexp         ${phone_num}                ^[+]\\d{14}$

    ClickText                   Leads
    VerifyText                  ${first_name} ${last_name}
    VerifyText                  ${job}
    VerifyText                  ${company}

Delete Lead
    LaunchApp                   Sales
    ClickText                   Leads                       partial_match=false
    Wait Until Keyword Succeeds                             1 min                       5 sec                  ClickText                   ${first_name} ${last_name}
    ClickText                   Show more actions
    ClickText                   Delete
    ClickText                   Delete
    ClickText                   Close
    Log Screenshot

*** Keywords ***

Unique Test Data
    ${Last_Name}=               Last Name
    Set Suite Variable          ${last_name}                ${Last_Name}
    ${Company}=                 Company
    Set Suite Variable          ${company}                  ${Company}
    ${First_Name}=              First Name
    Set Suite Variable          ${first_name}               ${First_Name}
    ${Job}=                     Job
    Set Suite Variable          ${job}                      ${Job}
    ${Email}=                   FakerLibrary.Email
    Set Suite Variable          ${email}                    ${Email}
