# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library                    QForce
Library                    FakerLibrary                # Add Faker library
Resource                   ../resources/common.robot
Suite Setup                Setup Browser
Suite Teardown             End suite


*** Test Cases ***
Entering A Lead
    [tags]                 Lead1    P1    SmokeTest
    Appstate               Home
    LaunchApp              Sales
    ClickText              Leads
    VerifyText             Change Owner
    ClickText              New
    VerifyText             Lead Information
    UseModal               On                          # Only find fields from open modal dialog

    Picklist               Salutation                  Dr.
    TypeText               First Name                  Tina
    TypeText               Last Name                   Smith
    Picklist               Lead Status                 New
    # generate random phone number, just as an example
    # NOTE: initialization of random number generator is done on suite setup
    ${rand_phone}=         Generate Random String      14                          [NUMBERS]
    # concatenate leading "+" and random numbers
    ${phone}=              SetVariable                 +${rand_phone}
    TypeText               Phone                       ${phone}
    TypeText               Company                     Growmore
    TypeText               Title                       Manager
    TypeText               Email                       tina.smith@gmail.com
    TypeText               Website                     https://www.growmore.com/

    Picklist               Lead Source                 Partner
    ClickText              Save                        partial_match=False
    UseModal               Off
    Sleep                  1

    ClickText              Details
    VerifyField            Name                        Dr. Tina Smith
    VerifyField            Lead Status                 New
    VerifyField            Phone                       ${phone}
    VerifyField            Company                     Growmore
    VerifyField            Website                     https://www.growmore.com/

    # as an example, let's check Phone number format. Should be "+" and 14 numbers
    ${phone_num}=          GetFieldValue               Phone
    Should Match Regexp    ${phone_num}                ^[+]\\d{14}$

    ClickText              Leads
    VerifyText             Tina Smith
    VerifyText             Manager
    VerifyText             Growmore
    # just an example of using DateTime Library, let's just log today's date on the LogScreenshot
    ${date} =              Get Current Date
    Log                    Test run on: ${date}

Delete Lead test Case

    ClickText              Leads
    ClickText              Tina Smith
    VerifyText             Dr. Tina Smith
    ClickText              Details
    VerifyText             Dr. Tina Smith
    VerifyText             Growmore
    ClickText              Show more actions
    ClickText              Delete
    UseModal               On
    ClickText              Delete



Entering A Lead with Faker
    [tags]                 Lead2

    # Generate fake data using Faker
    ${fake_first_name}=         FakerLibrary.First Name
    ${fake_last_name}=          FakerLibrary.Last Name
    ${fake_company}=            FakerLibrary.Company
    ${fake_job_title}=          FakerLibrary.Job
    ${fake_email}=              FakerLibrary.Email
    ${fake_website}=            FakerLibrary.Url

    # Create full name for verification
    ${full_name}=               Set Variable                Dr. ${fake_first_name} ${fake_last_name}
    Home
    LaunchApp              Sales
    ClickText              Leads
    VerifyText             Change Owner
    ClickText              New
    VerifyText             Lead Information
    UseModal               On
    
    Picklist               Salutation                  Dr.
    TypeText               First Name                  ${fake_first_name}
    TypeText               Last Name                   ${fake_last_name}
    Picklist               Lead Status                 New
    
    # Keep the existing random phone generation
    ${rand_phone}=         Generate Random String      14                          [NUMBERS]
    ${phone}=              SetVariable                 +${rand_phone}
    TypeText               Phone                       ${phone}
    
    TypeText               Company                     ${fake_company}
    TypeText               Title                       ${fake_job_title}
    TypeText               Email                       ${fake_email}
    TypeText               Website                     ${fake_website}
    
    Picklist               Lead Source                 Partner
    ClickText              Save                        partial_match=False
    UseModal               Off
    Sleep                  1
    
    ClickText              Details
    VerifyField            Name                        ${full_name}
    VerifyField            Lead Status                 New
    VerifyField            Phone                       ${phone}
    VerifyField            Company                     ${fake_company}
    VerifyField            Website                     ${fake_website}
    
    # Phone number format validation remains the same
    ${phone_num}=          GetFieldValue               Phone
    Should Match Regexp    ${phone_num}                ^[+]\\d{14}$
    
    ClickText              Leads
    VerifyText             ${fake_first_name} ${fake_last_name}
    VerifyText             ${fake_job_title}
    VerifyText             ${fake_company}
    
    ${date} =              Get Current Date
    Log                    Test run on: ${date}