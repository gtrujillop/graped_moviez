require "graped_moviez"

FactoryBot.define do
  factory :movie do
    name { "Alien" }
    description  { "Some movie with some monsters from the outer space" }
    image_url { "https://some.site/some_image.jpg" }
  end
  factory :day do
    day { Date.today }
  end
  factory :function do
    movie
    day
  end
  factory :reservation do
    user_email { "testuser1@myemail.com" }
    seats { 2 }
    function
  end
end
