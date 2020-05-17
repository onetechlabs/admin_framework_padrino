# Admin Framework Padrino 1.0
Requirement :
1. Padrino Web Framework (Include Sinatra Ruby Web Framework) v.0.14.4 s
2. Ruby 2.7.1
3. Bundler version 1.17.3<br/>
Instalation :<br/>
1. cd [....your projects....]
2. Bundle Install
3. Check Config Database at /config/database.rb , set as Your Configuration Database Access
4. Create Database Manually
5. bundle exec rake db:migrate
6. bundle exec rake db:seed
7. We have 2 Default Role User :
a. admin
it is Superadmin Role CRUD
b. supervisor
it is for Read Only User
Fill the Request for Admin and Supervisor User Form in Terminal as you want !
8. And Lets Start with Command 'Padrino s'
9. Open http://localhost:3000/admin
