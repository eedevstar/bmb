FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password' }

    factory :user_with_posts do
      transient do
        posts_count { 5 }
      end

      posts do
        Array.new(posts_count) { association(:post) }
      end
    end
  end
end
