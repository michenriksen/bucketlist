class BucketObject < Sequel::Model
  many_to_one :bucket
end
