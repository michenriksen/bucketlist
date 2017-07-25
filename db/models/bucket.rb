class Bucket < Sequel::Model
  one_to_many :bucket_objects
end
