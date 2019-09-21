Sequel.migration do 
  change do 
    create_table :functions do
      primary_key :id 
      foreign_key(:movie_id, :movies) 
      foreign_key(:day_id, :days) 
    end 
  end 
end
