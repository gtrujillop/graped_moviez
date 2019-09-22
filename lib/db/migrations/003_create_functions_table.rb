Sequel.migration do 
  change do 
    create_table :functions do
      primary_key :id 
      foreign_key(:movie_id, :movies, key: :id) 
      foreign_key(:day_id, :days, key: :id) 
    end 
  end 
end
