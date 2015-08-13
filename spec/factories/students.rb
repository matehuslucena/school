FactoryGirl.define do
  factory :student do |f|
    f.name 'name'
    f.register_number '123-4'
  end

  factory :invalid_student, parent: :student do |f|
    f.name nil
  end
end