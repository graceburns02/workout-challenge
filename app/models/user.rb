# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  active          :boolean          default(TRUE)
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

  has_many(:injuries)

  def current_month_workouts
    current_month_start = Date.today.beginning_of_month
    current_month_end = Date.today.end_of_month

    workouts.where(date: current_month_start..current_month_end)
  end

  def current_week_workouts
    current_week_start = Date.today.beginning_of_week(:monday)
    current_week_end = current_week_start + 6.days

    workouts.where(date: current_week_start..current_week_end)
  end

  def weekly_workout_count
    current_date = Date.today.beginning_of_month
    count = 0

    while current_date.month == Date.today.month
      week_start_date = current_date.beginning_of_week(start_day = :monday)
      week_end_date = week_start_date + 6.days
      count += workouts.where(date: week_start_date..week_end_date).count

      current_date = week_end_date + 1.day
    end

    count
  end

  def owed
    if weekly_workout_count < 3
      (3 - weekly_workout_count) * 5

    else
      0
    end 
  end

  def injured_during?(date_range)
    injuries.where("start_date <= ? AND end_date >= ?", date_range.end, date_range.begin).exists?
  end

end
