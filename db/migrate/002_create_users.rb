Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :login, {:size => 32,:index => true,
        :null => false,:unique => true}
      String :password, {:size => 32,:null => false}
    end
  end

  down do
    drop_table :users
  end
end
