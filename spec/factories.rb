# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Signor Wences"
  user.email                 "afinefellow@net.com"
  user.password              "mousedroppings"
  user.password_confirmation "mousedroppings"
end