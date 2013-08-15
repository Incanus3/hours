Sequel.migration do
  up do
    alter_table(:work_days) do
      add_unique_constraint [:date,:user_id]
    end
  end

  down do
  end
end
