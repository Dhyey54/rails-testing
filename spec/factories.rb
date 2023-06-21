FactoryBot.define do
  factory(:user) do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory(:product) do
    product_name { "Testing Product" }
    price { 50.50 }
    description { "Product Description" }
  end
end
