Sequel.migration do
  change do
    create_table(:bucket_objects) do
      primary_key :id
      foreign_key :bucket_id, :buckets, :on_delete => :cascade, :index => true
      String :key, :index => true
      String :url
      String :etag, :index => true
      Integer :size, :index => true
      Boolean :public, :index => true
      String :storage_class, :index => true
      DateTime :last_modified_at, :index => true
      DateTime :updated_at
      DateTime :created_at, :index => true
    end
  end
end
