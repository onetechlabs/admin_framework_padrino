Sequel.migration do
  up do
    alter_table(:accounts) do
      add_column :avatar, String, default: "No Image", text: true
    end
  end

  down do
    drop_table :accounts
  end
end
