Sequel.migration do
  change do
    create_table(:buckets) do
      primary_key :id
      String :name, :index => true, :unique => true
      String :url
      Boolean :exists, :index => true
      Boolean :public, :index => true
      DateTime :crawled_at, :index => true
      DateTime :updated_at
      DateTime :created_at, :index => true
    end
  end
end
