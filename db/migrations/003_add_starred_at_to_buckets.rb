Sequel.migration do
  up do
    alter_table(:buckets) do
      add_column :starred_at, DateTime
      add_index :starred_at
    end
  end

  down do
    alter_table(:buckets) do
      drop_column :starred_at
    end
  end
end
