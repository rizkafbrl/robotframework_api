# Robot Framework API Test Automation

This project contains automated API tests for Pet endpoints using Robot Framework. The tests verify the functionality of a Pet API service including adding new pets and finding pets by different criteria.

## Project Structure

```
robotframework_api/
├── tests/
│   └── pets/
│       ├── add_pet.robot   # Tests for adding pets
│       └── find_pet.robot  # Tests for finding/retrieving pets
├── results/                # Test execution results
│   ├── output.xml          # XML output from Robot Framework
│   ├── log.html            # Detailed HTML log
│   └── report.html         # HTML summary report
└── README.md
```

## Test Cases

The project includes the following test cases:

### Add Pet Tests
- **Add New Pet**: Adds a new pet and verifies its creation
- **Add New Pet 2**: Adds another pet with different data and verifies its creation

### Find Pet Tests
- **Find Pets By Status (Pending)**: Retrieves pets with 'pending' status
- **Find Pets By Status (Available)**: Retrieves pets with 'available' status 
- **Retrieve Pet By ID**: Retrieves a specific pet by its ID and verifies the pet's details

## Prerequisites

To run these tests, you need to have the following installed:

- Python 3.6 or higher
- Robot Framework
- RESTinstance or RequestsLibrary for API testing

## Installation

1. Install Python from [python.org](https://www.python.org/downloads/)

2. Install Robot Framework and required libraries:

```bash
pip install robotframework
pip install robotframework-requests
# Or for RESTinstance
pip install RESTinstance
```

## Running the Tests

To run all the pet-related tests:

```bash
robot --outputdir results tests/pets/
```

To run specific test suites:

```bash
# Run only the add pet tests
robot --outputdir results tests/pets/add_pet.robot

# Run only the find pet tests
robot --outputdir results tests/pets/find_pet.robot
```

## Test Results

After test execution, Robot Framework generates three result files in the `results` directory:

- **output.xml**: Contains the test execution results in XML format
- **log.html**: Detailed HTML log with information about each test step
- **report.html**: HTML summary report showing test statistics and results

To view the results, open the HTML files in a web browser:

```bash
# For macOS
open results/report.html
open results/log.html

# For Linux
xdg-open results/report.html
xdg-open results/log.html

# For Windows
start results/report.html
start results/log.html
```

## Continuous Integration

These tests can be integrated into CI/CD pipelines. The command to run in CI environments would be:

```bash
robot --outputdir results tests/pets/
```

## Troubleshooting

If you encounter any issues:

1. Ensure the API service is running and accessible
2. Check your network connection
3. Verify that all dependencies are installed
4. Check the detailed log.html file for error information

