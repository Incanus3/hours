Sequel.migration do
  up do
    create_table(:supervizors) do
      foreign_key :supervizor_id,:users,:null => false,:index => true
      foreign_key :subordinate_id,:users,:null => false,:index => true
      primary_key [:supervizor_id,:subordinate_id]
      index [:supervizor_id,:subordinate_id]
    end
  end

  down do
    drop_table(:supervizors)
  end
end
