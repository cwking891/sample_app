# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Signor Wences"
  user.email                 "afinefellow@net.com"
  user.password              "mypassword"
  user.password_confirmation "mypassword"
end