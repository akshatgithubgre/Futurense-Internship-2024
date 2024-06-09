# Flask Practice

This repository contains my practice projects for learning Flask, a lightweight web application framework in Python. The projects and exercises are organized into various folders, each focusing on different Flask concepts and functionalities. I have tested the endpoints using POSTMAN to ensure the correctness and functionality of the web applications.

## Contents

- **Basic Flask App**: Introduction to setting up a Flask application, routing, and handling HTTP methods.
- **Templates and Static Files**: Working with HTML templates and static files in Flask.
- **Forms and User Input**: Handling user input through forms and validating the data.
- **Database Integration**: Integrating a MYSQL database with Flask and performing CRUD operations.
- **Authentication and Authorization**: Implementing user authentication and authorization mechanisms.
- **RESTful APIs**: Building and testing RESTful APIs with Flask.

## Testing

All endpoints and functionalities have been thoroughly tested using POSTMAN. This includes:

- GET, POST, PUT, DELETE requests
- Handling form submissions
- Validating response data and status codes

## Getting Started

To run any of the projects, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/akshatgithubgre/Futurense-Internship-2024.git
    ```

2. Navigate to the desired project directory:
    ```bash
    cd Futurense-Internship-2024/7-June/Flask-Task
    ```

3. Run the virtual environment:
    ```bash
    .\venv\Scripts\activate
    ```

4. Install the required dependencies:
    ```bash
    pip install flask
    pip install mysql-connector-python
    pip install jwt
    ```

5. Set up the MySQL database:
    ```bash
    - Open MySQL Workbench.
    - Create a new database.
    - Execute the provided SQL script to set up the database schema and initial data.
    ```

5. Configure the database connection in the Flask application:
    ```bash
    - Update the `config.py` with your MySQL database credentials.
    ```
6. Run the Flask application:
    ```bash
    $env:FLASK_APP="app"

    $env:FLASK_ENV="development"

    $env:PYTHONDONTWRITEBYTECODE=1

    flask run
    ```

## Tools Used

- **Flask**: Web framework for Python
- **POSTMAN**: API testing tool
- **MySQL Workbench**: Database management tool for MySQL

Feel free to explore the projects and use them as a reference for your own Flask applications. Contributions and suggestions are welcome!

