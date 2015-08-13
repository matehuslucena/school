FactoryGirl.define do
  factory :post do |f|
    f.title 'title'
    f.body 'body'
  end

  factory :invalid_post, parent: :post do |f|
    f.title nil
  end
end