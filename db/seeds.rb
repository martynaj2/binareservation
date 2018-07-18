user = User.find_or_create_by(email: "admin@test.pl")
user.name = "ADMIN"
user.surname = "ADMIN"
user.password = "test1234"
user.is_admin = true
user.save
