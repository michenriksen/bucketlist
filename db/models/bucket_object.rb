class BucketObject < Sequel::Model
  many_to_one :bucket

  def starred?
    !self.starred_at.nil?
  end
end
