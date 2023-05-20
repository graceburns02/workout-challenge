# == Schema Information
#
# Table name: workouts
#
#  id          :integer          not null, primary key
#  date        :date
#  description :string
#  image       :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Workout < ApplicationRecord

  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })

  has_many(:comments, { :class_name => "Comment", :foreign_key => "workout_id", :dependent => :destroy })
end
