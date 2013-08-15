Sequel.migration do
  up do
    create_table :work_days do
      primary_key :id
      Date :date
      Integer :hours
      String :description, :text => true
      foreign_key :user_id
    end
  end

  down do
    drop_table :work_days
  end
end
