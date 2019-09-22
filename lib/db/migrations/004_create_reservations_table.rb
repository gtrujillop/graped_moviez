Sequel.migration do 
  change do 
    create_table :reservations do
      primary_key :id 
      String :user_email, unique: true, null: false
      Integer :seats, null: false
      foreign_key(:function_id, :functions, key: :id) 
    end 
  end 
end
