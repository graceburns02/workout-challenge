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
  
end
