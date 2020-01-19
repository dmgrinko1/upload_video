users = [
    { email: 'first_user@example.com',   password: '123123123',  password_confirmation: '123123123'},
    { email: 'second_user@example.com',  password: '123123123',  password_confirmation: '123123123'},
    { email: 'third_user@example.com',   password: '123123123',  password_confirmation: '123123123'},
]

users.each { |user_details| User.find_or_create_by!(user_details) }