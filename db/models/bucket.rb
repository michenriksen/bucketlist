class Bucket < Sequel::Model
  one_to_many :bucket_objects

  def starred?
    !self.starred_at.nil?
  end
end
