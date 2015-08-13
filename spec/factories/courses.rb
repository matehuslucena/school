FactoryGirl.define do
  factory :course do |f|
    f.name 'name'
    f.description 'description'
  end

  factory :invalid_course, parent: :course do |f|
    f.name nil
  end
end