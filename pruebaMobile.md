# Mobile Automation Test for Mercado Libre

## Application Objective
Automate a functionality test for the Mercado Libre mobile application on Android using Ruby and Appium.

## Requirements
- Use Ruby as the programming language for the automation script.
- Use Appium to interact with the Mercado Libre mobile application.
- The test must run exclusively on Android devices.
- Configure the script to execute from a terminal with a single command.

## Test Scenario
### Functionality to Test
Validate a search flow and filter functionality in the Mercado Libre mobile application.

# Steps
- Open the Mercado Libre mobile application installed on the Android device.
- Search for the term “playstation 5” in the search bar.
- Apply the filter for condition “Nuevos”.
- Apply the filter for location “CDMX”.
- Order the results by “mayor a menor precio”.
- Obtain the name and the price of the first 5 products displayed in the results.
- Print these products (name and price) in the console.

# Acceptance Criteria 
- The test must execute without manual intervention.
- The script must correctly execute the steps and identify UI elements on Android.
- The test should display the names and prices of the first 5 products in the console.
- Filters and sorting should be applied as specified in the test steps.

## Extra Points (Not Obligatory)
- Generate a report of the execution.
- Include images for every step in the report.
- Follow good practices in the script implementation.
- The test also works on iOS