FactoryGirl.define do
  factory :user do |f|
    f.user_name 'teste'
    f.email 'teste@test.com.br'
    f.password '12345678'
  end
end