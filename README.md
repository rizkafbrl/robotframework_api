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

![Setup pip install](https://raw.githubusercontent.com/rizkafbrl/robotframework_api/refs/heads/main/images/setup%20pip%20install.PNG)

## Running the Tests

To run all the pet-related tests:

```bash
robot --outputdir results tests/pets/
```

![How to run](https://raw.githubusercontent.com/rizkafbrl/robotframework_api/refs/heads/main/images/how%20to%20run.PNG)

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

## GitHub Actions Workflow

This repository includes a GitHub Actions workflow to automate the execution of Robot Framework API tests. The workflow is defined in `.github/workflows/robot-tests.yml`.

### Workflow Details

- **Trigger Events**:
  - Runs on `push` events to the `main` or `master` branches.
  - Runs on `pull_request` events targeting the `main` or `master` branches.

- **Job Configuration**:
  - **Environment**: The tests are executed on `ubuntu-22.04` with Python 3.9.
  - **Steps**:
    1. **Checkout Source**: Clones the repository.
    2. **Set Up Python**: Installs Python 3.9 and caches dependencies using `pip`.
    3. **Install Dependencies**: Installs required Python packages from `requirements.txt`.
    4. **Run Robot Framework Tests**: Executes the tests located in the `tests/` directory and stores the results in the `results/` directory.
    5. **Debugging**:
       - Displays environment information and lists files in the working directory.
       - Checks the contents of the `results/` directory after the tests are executed.
       - Prints environment variables for debugging purposes.
    6. **Upload Test Results**: Uploads the test results as an artifact named `robot-results`.

### How to Use

1. Ensure your `requirements.txt` file includes all necessary dependencies for running Robot Framework tests.
2. Push changes to the `main` or `master` branch, or create a pull request targeting these branches.
3. The workflow will automatically run and execute the tests.
4. Test results can be downloaded from the "Artifacts" section of the workflow run in GitHub Actions.

### Example Workflow File

Below is the workflow file used in this repository:

```yaml
name: Robot Framework API Tests

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  test:
    runs-on: ubuntu-22.04

    permissions:
      contents: read
      actions: read

    steps:
    - name: Checkout source
      uses: actions/checkout@v3

    - name: Set up Python 3.9
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
        cache: 'pip'

    - name: Show environment info (basic debug)
      run: |
        echo "Python version: $(python --version)"
        echo "Working directory: $(pwd)"
        echo "Listing root files:"
        ls -lah

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r [requirements.txt](http://_vscodecontentref_/1)

    - name: Run Robot Framework tests
      run: |
        mkdir -p results
        python -m robot --outputdir results tests/

    - name: Debug result directory
      run: |
        echo "Checking contents of 'results/' directory:"
        if [ -d "results" ]; then
          ls -lah results
        else
          echo "'results' directory not found!"
          exit 1
        fi

    - name: Show environment variables (hardcore debug)
      run: printenv

    - name: Upload test results
      uses: actions/upload-artifact@v4
      with:
        name: robot-results
        path: results/
```

### Viewing Test Results

After a workflow run completes:

1. Go to your GitHub repository
2. Navigate to the Actions tab
3. Click on the relevant workflow run
4. Under "Artifacts", download the "robot-results" artifact
5. Extract the zip file and open `report.html` or `log.html` in a browser

The test artifacts are saved even if the tests fail, making it easier to diagnose issues.

## Troubleshooting

If you encounter any issues:

1. Ensure the API service is running and accessible
2. Check your network connection
3. Verify that all dependencies are installed
4. Check the detailed log.html file for error information

