require "graped_moviez/models/day"

Sequel.seed do
  def run
    7.times do |day|
      GrapedMoviez::Models::Day.create day: Date.today + day
    end
  end
end 
