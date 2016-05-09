class Post < ApplicationRecord
  validates :title, presence: true
  self.skip_time_zone_conversion_for_attributes = [:created_at, :updated_at, :open_time, :close_time] 
end
