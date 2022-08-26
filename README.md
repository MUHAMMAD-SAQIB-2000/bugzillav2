Bug tracking system(first phase)

1. Sign up, login and logout of users(name, email, password, user_type[developer, manager, qa])

    • http://railscasts.com/episodes/192-authorization-with-cancan

    1. Manager/user can have many projects
       
    2. The user can enter many bugs
       
    3. A bug belongs to a creator(user)
       
    4. A bug belongs to a developer who'll solve the bug(user)
       
    5. A bug belongs to a project
       
    6. A project can have many users and users have many projects(implement by nested attributes)
       
    7. A project can have many bugs too
       
    8. The bug has a descriptive title and deadline and a screenshot, type, and status
       
    9. The select option for project should be a live search 
       
    10. Screen shot should be an image either .png or .gif no other type of image is allowed

    • http://railscasts.com/episodes/253-carrierwave-file-uploads

    1. Description, the screen shot is not compulsory but title and status and type are compulsory.(Bug attributes)
       
    2. The title of a bug should be unique throughout the project

    3. Type can have two values (feature, bug) (Bug)

    4. Status is a drop down having values 
       (new, started, completed) if it's A feature or 
       (new, started and resolved) if it's a bug.

Use Pundit Gem for Roles Authorizations. https://github.com/elabs/pundit
 Roles:
Manager:
    1. Create Project.
    2. Edit And Delete the projects he creates.
    3. Add/Remove Developers and QA to the Projects he creates.

Developer:
    1. Assign bug to himself. Pick up a bug from the list of his projects.
    2. Can see only the projects he is part of.
    3. Mark a bug resolved.
    4. Can not see other projects.
    5. Can not report(add) Bug.
    6. Can not delete a Bug.
    7. Can not join any project.

QA:
    1. Report(add) Bugs to all projects.
    2. Can see all projects
    3. Can not edit/delete/create any project


Learn Gems
    • gem "rmagick"
    • gem "carrierwave"
    • gem 'devise'
    • gem "cancancan"
    • gem "turbolinks"
    • gem 'jquery-rails'
    • gem "byebug"
    • gem 'pagy'
    • gem "select2-rails"
    • gem 'jquery-rails'
    • gem "cocoon"
    • gem "jwt"
    • gem "bycrypt"
      
