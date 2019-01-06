# README


### Features

- User Registration with OAuth
- Create Organization
- Manage Projects
- Project based Subscriptions
- Project Checklists

### Requirements

- Ruby: `2.4.1`
- Rails: `5.2.1`
- PostgreSQL

### Installation

- Clone the repository.
- Goto cloned repository using - `cd story_of_plato/` (or whatever your local project folder name)
- Install required gems(libraries) - `bundle install`
- Create a **database.yml** and **master.key** file in `config` folder. There is a **database.sample.yml** and **secrets.sample.yml** file in the same directory. Copy and paste the contents of those files in your newly created YAML file. Then change accordingly. (e.g. change database username/password/db_name)
- In your command line run - `rake db:create`  (_It'll create a new database in mysql_)
- In your command line run - `rake db:migrate`  (_It'll add tables to your  newly created database_)


### Usage
- In the `epics` folder, `ER_Diagram.uml` file shows the ER Diagram of current Database Structure.


### Contribute

> Fork the repository then create pull request. 

Happy Contributing!


