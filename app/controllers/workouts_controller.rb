class WorkoutsController < ApplicationController

  require "date"
  Date.new 

  def index
    matching_workouts = Workout.all

    @list_of_workouts = matching_workouts.order({ :created_at => :desc })

    render({ :template => "workouts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_workouts = Workout.where({ :id => the_id })

    @the_workout = matching_workouts.at(0)

    render({ :template => "workouts/show.html.erb" })
  end

  def tracker
    list_of_users = User.all
    @users = list_of_users.order({:first_name => :desc})

    t = Date.today
    month_number = t.month
    @current_month = Date::MONTHNAMES[month_number]


    render({ :template => "workouts/tracker.html.erb" })
  end 

  def create
    activity_name = params.fetch("query_activity").strip.downcase

    # Try finding an existing activity, case-insensitively.
    existing_activity = Activity.where("LOWER(name) = ?", activity_name).first

    if existing_activity.nil?
      # No existing activity found. Let's try to create one.
      activity = Activity.new(name: activity_name)
      unless activity.save
        # The activity wasn't saved (probably due to the uniqueness constraint).
        redirect_to("/workouts", :alert => "Activity already exists in the list.")
        return
      end
    end
    
    # ... rest of your code ...

    the_workout = Workout.new
    the_workout.user_id = session.fetch(:user_id)
    #the_workout.name = params.fetch("query_name")
    the_workout.date = params.fetch("query_date")
    the_workout.description = params.fetch("query_description")
    the_workout.url = params.fetch(:url)
    #the_workout.image = params.fetch("input_image")
    #the_workout.activity = params.fetch("query_activity")
    the_workout.activity = activity_name  # Or store the activity ID, based on your schema.

    if the_workout.valid?
      the_workout.save
      redirect_to("/workouts", { :notice => "Workout created successfully." })
    else
      redirect_to("/workouts", { :alert => the_workout.errors.full_messages.to_sentence })
    end
  end

  def predefined_activities
    ["4+ mile walk", "Run", "Indoor Cycle", "Outdoor Bike Ride", "Yoga", "Swim", "Dance", "Ski/Snowboard", "Pilates", "Weights", "Barre", "Other"]
  end

  def update
    the_id = params.fetch("path_id")
    the_workout = Workout.where({ :id => the_id }).at(0)

    #the_workout.user_id = params.fetch("query_user_id")
    #the_workout.name = params.fetch("query_name")
    the_workout.date = params.fetch("query_date")
    the_workout.description = params.fetch("query_description")
    #the_workout.image = params.fetch("query_image")
    the_workout.url = params.fetch(:url)
    the_workout.activity = params.fetch("query_activity")

    if the_workout.valid?
      the_workout.save
      redirect_to("/workouts/#{the_workout.id}", { :notice => "Workout updated successfully."} )
    else
      redirect_to("/workouts/#{the_workout.id}", { :alert => the_workout.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_workout = Workout.where({ :id => the_id }).at(0)

    the_workout.destroy

    redirect_to("/workouts", { :notice => "Workout deleted successfully."} )
  end
end
