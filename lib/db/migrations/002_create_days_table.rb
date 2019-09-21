Sequel.migration do 
  change do 
    create_table :days do
      primary_key :id 
      Date :day, null: false, unique: true
    end 
  end 
end
