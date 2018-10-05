Fabricator(:user) do
  email       FFaker::Internet.email
  password    Devise.friendly_token[0,20]
end
