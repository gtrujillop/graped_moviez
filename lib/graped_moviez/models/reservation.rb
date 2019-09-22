module GrapedMoviez
  module Models
    DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
    class Reservation < Sequel::Model
      many_to_one :function
    end
  end
end
