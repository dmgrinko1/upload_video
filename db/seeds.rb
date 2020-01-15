users = [
    { username: 'first_user',  auth_token: SecureRandom.uuid },
    { username: 'second_user', auth_token: SecureRandom.uuid },
    { username: 'third_user',  auth_token: SecureRandom.uuid },
]

users.each { |user_details| User.find_or_create_by!(user_details) }