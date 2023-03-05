# PORTFOLIO DATABASE 
## Description
This project is meant to act as the back-end for this [portfolio app](https://portfolio2-psi-peach.vercel.app/)
Here is a link to the front-end repository [FRONT-END](https://github.com/Grace-aloo/Portfolio)

The database hase 3 main classes: Skill,User,Project. The User class has a one to many relationship with both the Skill class and the Project class.

## Requirements
In order to use this repo you need to have the following installed:

- OS [either: Windows 10+, Linux or MacOS(running on x86 or arm architecture)]
- VS Code
- Ruby

## Installation
Clone from this here [github](https://github.com/Grace-aloo/ruby-project-rb)

to clone follow this steps


Clone the repo by using the following:     

       https://github.com/Grace-aloo/ruby-project-db

Change directory to the repo folder: 

        cd ruby-project-db

Open it in Visual Studio Code

        code .

## Running This Application
Running the application is very straight forward. You can use the following steps to run the app. 

- Ensure the ruby gems are setup in your machine

      bundle install
      
- Perform database migrations

      rake db:migrate
      
- Run the application on the terminal

      rake console

- Run the server

      rake start      
      



## Author 

 Grace Aloo

## License
MIT