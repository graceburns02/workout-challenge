# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  workout_id :integer
#
class Comment < ApplicationRecord

  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:workout, { :required => true, :class_name => "Workout", :foreign_key => "workout_id" })
end
