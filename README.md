# DBT Demo Project

### Overview
This project works through a series of DBT concepts and acts as a test-bed for learning how to work with DBT for building ETL jobs differently.  It starts with a simple PostgreSQL database which can be created by running the SQL scripts contained in the `source` folder.  

From there, the basic DBT command of:
- `dbt run`

### Notes:
- You will need to setup a profile.yml file in your `~/.dbt` folder to enable the database connection.  For this demo, I create a database called `orders` with a simple PostgreSQL install (version 14 for this project).  Default username is postgres, modify to your preference.
- I include the generated documentation in this project so the sharing of the project is easier for people to check that out without getting PostgreSQL up and running.  Just go do the `targets` directory and run `python -m http.server` to launch a quick and dirty webserver then navigate to `http:localhost:8000` in a web-browser to explore the documentation and see the data flow diagrams.


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
