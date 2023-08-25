# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_activities_on_LOWER_name  (LOWER(name)) UNIQUE
#
class Activity < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  #validates_exclusion_of :name, in: ["4+ mile walk", "Run", "Indoor Cycle", "Outdoor Bike Ride", "Yoga"], message: "is a preset activity and can't be duplicated"
end
