# DBT Demo Project

### Overview
This project works through a series of DBT concepts and acts as a test-bed for learning how to work with DBT for building ETL jobs differently.  It starts with a simple PostgreSQL database which can be created by running the SQL scripts contained in the `source` folder.  

### Notes:
- Database Setup:
    - Install Postgres >= v14
    - Create a database in Postgres called `orders`
    - Run the "build_db.sh" script within the `source` folder of the project root
- DBT Setup:
    - Install a version of Python >= 3.8
    - Create the Python virtual environment by running this command from the command line of the project root: `python3 -m venv venv`
        - ***NOTE*** Windows the command might be `python -m venv venv`
    - Update PIP by running the following commands:
        - Linux/Mac: `source venv\bin\activate` || Windows: `venv\Scripts\activate.bat`
        - `pip install --upgrade pip`
        - `pip install -r requirements.txt`
    - Install DBT modules by running the following command from the project root:
        - `dbt deps`
    - Setup the DBT Profile by running the following commands from the project root:
        - `mkdir ~/.dbt`
        - `cp profiles.yml ~/.dbt`
    - Edit the profiles.yml file to contain the postgres user password specified in your postgres setup

    - 
- Running DBT:
    - Run the following command to run DBT: `dbt run`
    - Just go do the `targets` directory and run `python -m http.server` to launch a quick and dirty webserver then navigate to `http:localhost:8000` in a web-browser to explore the documentation and see the data flow diagrams.


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
