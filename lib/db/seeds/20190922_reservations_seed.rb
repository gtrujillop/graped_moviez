require "graped_moviez/models/reservation"

Sequel.seed do
  def run
    [
      ['some_user1@myemail.com', 2, 1],
      ['some_user2@myemail.com', 2, 2],
      ['some_user3@myemail.com', 1, 3],
      ['some_user4@myemail.com', 3, 4],
      ['some_user5@myemail.com', 4, 5],
      ['some_user6@myemail.com', 1, 6],
      ['some_user7@myemail.com', 2, 7],
      ['some_user8@myemail.com', 2, 1],
      ['some_user9@myemail.com', 1, 2],
      ['some_user10@myemail.com', 2, 3],
      ['some_user11@myemail.com', 2, 4],
      ['some_user12@myemail.com', 1, 5]
    ].each do |email, seats, function_id|
      GrapedMoviez::Models::Reservation.create user_email: email, seats: seats, function_id: function_id
    end
  end
end 
