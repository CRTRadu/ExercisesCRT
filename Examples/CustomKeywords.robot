*** Settings ***
Library                         QWeb
Library                         RetryFailed                 global_retries=2
Resource                        ../resources/common.robot
Resource                        ../resources/keywords.robot
Suite Setup                     Setup Browser
Suite Teardown                  Close All Browsers

*** Test Cases ***

Exercise 12 - Custom Keywords - Step 1 Grouping
    # At this point the test data in the custom keywords are fixed.
    Appstate                    Home
    Create Lead Step 1 Grouping 
    Verify Lead Step 1 Grouping
    Delete Lead Step 1 Grouping

Exercise 12 - Custom Keywords - Step 2 Replace values with arguments
    # At this point the test data in the custom keywords are variables
    Home
    Create Lead Step 2 Replace values with arguments        lead_status=New             last_name=Smith        company=Growmore    salutation=Dr.           first_name=Charles
    Verify Lead Step 2 Replace values with arguments        last_name=Smith             salutation=Dr.         first_name=Charles                           company=Growmore                             phone=+12234567858449    title=Manager    website=https://www.growmore.com/
    Delete Lead Step 2 Replace values with arguments        last_name=Smith             first_name=Charles

Exercise 13 - Custom Keywords - Step 2 Replace values with arguments
    # At this point the test data in the custom keywords are variables
    Home
    Create Lead Step 2 Replace values with arguments        lead_status=New             last_name=John         company=Google      salutation=Dr.           first_name=Trevor
    Verify Lead Step 2 Replace values with arguments        last_name=Smith             salutation=Dr.         first_name=Peter                           company=Growmore                             phone=+12234567858449    title=Manager    website=https://www.growmore.com/
    Delete Lead Step 2 Replace values with arguments        last_name=Smith             first_name=John

Exercise 14 - Custom Keywords - Step 2 Replace values with arguments
    # At this point the test data in the custom keywords are variables
    Home
    Create Lead Step 2 Replace values with arguments        lead_status=Old             last_name=Terry        company=Apple       salutation=Dr.           first_name=Matt
    Verify Lead Step 2 Replace values with arguments        last_name=Smith             salutation=Dr.         first_name=Charles                           company=Growmore                             phone=+12234567858449    title=Manager    website=https://www.growmore.com/
    Delete Lead Step 2 Replace values with arguments        last_name=Smith             first_name=John


*** Keywords ***

    ##############################################################################################################################
    # Step 1 - Group keywords in Custom Keywords
    ##############################################################################################################################

Create Lead Step 1 Grouping
    Launch App                  Sales
    ClickText                   Leads
    ClickText                   New                         anchor=Import
    VerifyText                  Lead Information
    UseModal                    On                          # Only find fields from open modal dialog
    Picklist                    Salutation                  Dr.                         #optional
    TypeText                    First Name                  Tina                        #optional
    TypeText                    Last Name                   Smith                       #mandatory
    Picklist                    Lead Status                 New                         #mandatory
    TypeText                    Phone                       +12234567858449             First Name             #optional
    TypeText                    Company                     Growmore                    Industry               #mandatory
    TypeText                    Title                       Manager                     Address Information    #optional
    TypeText                    Email                       tina.smith@gmail.com        Rating                 #optional
    TypeText                    Website                     https://www.growmore.com/                          #optional
    Picklist                    Lead Source                 Advertisement               #optional
    ClickText                   Save                        partial_match=False
    UseModal                    Off
    Sleep                       2

Verify Lead Step 1 Grouping
    Launch App                  Sales
    ClickText                   Leads
    Wait Until Keyword Succeeds                             1 min                       5 sec                  ClickText           Tina Smith
    ClickText                   Details                     anchor=Activity
    VerifyText                  Dr. Tina Smith              anchor=Details
    #                           VerifyText                  Manager                     anchor=Details
    VerifyText                  +12234567858449             anchor=Lead Status
    VerifyField                 Company                     Growmore
    VerifyField                 Website                     https://www.growmore.com/
    Log Screenshot

Delete Lead Step 1 Grouping
    Launch App                  Sales
    ClickText                   Leads
    Wait Until Keyword Succeeds                             1 min                       5 sec                  ClickText           Tina Smith
    ClickText                   Show more actions           timeout=45s
    ClickText                   Delete
    ClickText                   Delete
    ClickText                   Close
    Log Screenshot