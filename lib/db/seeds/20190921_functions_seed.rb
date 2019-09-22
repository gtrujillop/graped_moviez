require "graped_moviez/models/function"

Sequel.seed do
  def run
    [
      [1, 1],
      [2, 2],
      [3, 3],
      [2, 4],
      [1, 5],
      [3, 6],
      [1, 7]
    ].each do |movie_id, day_id|
      GrapedMoviez::Models::Function.create movie_id: movie_id, day_id: day_id
    end
  end
end 
