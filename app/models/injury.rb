# == Schema Information
#
# Table name: injuries
#
#  id          :integer          not null, primary key
#  description :text
#  end_date    :date
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_injuries_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Injury < ApplicationRecord
  belongs_to :user
end
