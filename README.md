# DBT Demo Project

### Overview
This project works through a series of DBT concepts and acts as a test-bed for learning how to work with DBT for building ETL jobs differently.  It starts with a simple PostgreSQL database which can be created by running the SQL scripts contained in the `source` folder.  

From there, the basic DBT command of:
- `dbt run`

### Notes:
- You will need to setup a profile.yml file in your `~/.dbt` folder to enable the database connection.  For this demo, I used the default `template1` database that gets setup with a simple PostgreSQL install (version 14 for this project).


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
