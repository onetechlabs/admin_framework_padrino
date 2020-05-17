# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
emailadmin     = shell.ask "Which email do you want use for logging into admin?"
passwordadmin  = shell.ask "Tell me the password to use:", :echo => false

shell.say ""

account_admin = Account.new(:email => emailadmin, :name => "Admin", :surname => "1", :password => passwordadmin, :password_confirmation => passwordadmin, :role => "admin", :avatar => "No Image")

if account_admin.valid?
  account_admin.save
  shell.say "================================================================="
  shell.say "Admin Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{emailadmin}"
  shell.say "   password: #{?* * passwordadmin.length}"
  shell.say "================================================================="
else
  shell.say "Sorry, but something went wrong!"
  shell.say ""
  account_admin.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""

emailsupervisor     = shell.ask "Which email do you want use for logging into supervisor?"
passwordsupervisor  = shell.ask "Tell me the password to use:", :echo => false

shell.say ""

account_supervisor = Account.new(:email => emailsupervisor, :name => "Supervisor", :surname => "1", :password => passwordsupervisor, :password_confirmation => passwordsupervisor, :role => "supervisor", :avatar => "No Image")

if account_supervisor.valid?
  account_supervisor.save
  shell.say "================================================================="
  shell.say "Supervisor Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{emailsupervisor}"
  shell.say "   password: #{?* * passwordsupervisor.length}"
  shell.say "================================================================="
else
  shell.say "Sorry, but something went wrong!"
  shell.say ""
  account_supervisor.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""
