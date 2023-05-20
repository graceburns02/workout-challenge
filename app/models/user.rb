# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  private         :boolean
#  workout_count   :integer
#  workouts_count  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:workouts, { :class_name => "Workout", :foreign_key => "user_id", :dependent => :destroy })

  has_many(:comments, { :class_name => "Comment", :foreign_key => "user_id", :dependent => :destroy })
end
