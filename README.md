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
- In your command line run - `rake db:create`  (_It'll create a new database in mysql_)
- In your command line run - `rake db:migrate`  (_It'll add tables to your  newly created database_)
- In your command line run - `rake db:seed`  (_It'll add data to your  newly created database tables_)

### Usage

There will be 20 **users** at first and 3 **plans** in first version. You can login with:
  > email: `user1@plato.com` \ password: `123123`

Users created with seed files contained email structure: user1@plato.com, user2@plato.com ...... user20@plato.com. And all of the users have same password.

1. User can choose plans for either him or his created organizations.
2. In the `Subscriptions` panel on the left of the logged in page user can create subscriptions.
3. If user choose a solo plan, then a `Project` will be created automatically.
4. If user choose other than solo plans, then he can create unlimited projects > cards > Tasks unlit his subscription expires.
5. If the user's/org's subscription is over then he can only upgrade his subscription.
6. User can add user's to his organizations/projects.

##### Calculation

    1. If Organization/User: seleted plan != Solo
        - if Package: Monthly (Enterprise/Business/Startup)
            - package duration (2 months) * package monthly price + additional_users * additional user price
        - if Package: Annually (Enterprise/Business/Startup)
            - package duration (2 years) * package annual price + additional_users * additional user price
    2. Solo plan: User/Organization
       -  package duration (2 months) * package monthly price


### ERD

Image URL:
> https://ibb.co/2gLqXKr

![](https://ibb.co/2gLqXKr)


### Plato V2

Run seed files `rake db:seed upgraded=yes`.

This will inactive the previous plans and create new plans.

