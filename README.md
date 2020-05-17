# Admin Framework Padrino 1.0
Requirement :<br/><br/>
1). Padrino Web Framework (Include Sinatra Ruby Web Framework) v.0.14.4<br/>
2). Ruby 2.7.1<br/>
3). Bundler version 1.17.3<br/><br/>
Instalation :<br/>
1). cd [....your projects....]<br/>
2). Bundle Install<br/>
3). Check Config Database at /config/database.rb , set as Your Configuration Database Access<br/>
4). Create Database Manually<br/>
5). bundle exec rake db:migrate<br/>
6). bundle exec rake db:seed<br/>
7). We have 2 Default Role User :<br/>
a. admin<br/>
it is Superadmin Role CRUD<br/>
b. supervisor<br/>
it is for Read Only User<br/>
8). Fill the Request for Admin and Supervisor User Form in Terminal as you want !<br/>
9). And Lets Start with Command 'Padrino s'<br/>
10). Open http://localhost:3000/admin <br/>
