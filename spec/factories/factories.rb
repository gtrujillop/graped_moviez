FactoryBot.define do
  to_create { |instance| instance.save }
  factory :movie, class: 'GrapedMoviez::Models::Movie' do
    name { "Alien" }
    description  { "Some movie with some monsters from the outer space" }
    image_url { "https://some.site/some_image.jpg" }
  end
  factory :day, class: 'GrapedMoviez::Models::Day' do
    day { Date.today }
  end
  factory :function, class: 'GrapedMoviez::Models::Function' do
    movie
    day
  end
  factory :reservation, class: 'GrapedMoviez::Models::Reservation' do
    user_email { "testuser1@myemail.com" }
    seats { 2 }
    function
  end
end
