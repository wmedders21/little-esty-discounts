# Little Esty Shop

## Background and Description
## Table of Contents
- [Overview](#overview)
- [Learning Goals](#learning-goals)
- [Tools Used](#tools-used)
- [Features](#features)
- [Database Schema](#database-schema)

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Overview
[Little Esty Shop](https://little-esty-shop-jwld.herokuapp.com/admin) is a 12 day project assigned during Turing's Mod 2 of backend development.
This is an attempt to recreate an online store using Rails and CRUD functionality.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Tools Used
- Ruby on Rails
- Ruby
- Postgresql
- CRUD
- Postico
- RESTful

## Features
- Can determine top fives of merchants, merchant days and item count
- Allows the admin to update files
- Uses MVC strategy of development

## Database Schema
![Schema](/Users/lukepascale/turing/2module/projects/little-esty-shop/app/assets/images/little_esty_shop_schema.png)

## Contributors - Github User Names
- Will Medders - @wmedders21
- James Harkins - @James-Harkins
- Drew Proebstel - @DrewProebstel
- Luke Pascale - @enalihai
