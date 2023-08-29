class UserAuthenticationController < ApplicationController
  # Uncomment line 3 in this file and line 5 in ApplicationController if you want to force users to sign in before any other actions.
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  require "date"
  Date.new 


  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "user_authentication/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :first_name => the_id })

    @the_user = matching_users.at(0)

    matching_workouts = Workout.all

    @list_of_workouts = matching_workouts.order({ :created_at => :desc })

    monthly_count = @the_user.workouts.group("strftime('%Y-%m', date)").count
    @monthly_average = monthly_count.values.sum.to_f / monthly_count.length

    @most_frequent_activity = @the_user.workouts.group(:activity).count.max_by { |_activity, count| count }&.first

    @total_workouts = @the_user.workouts.count

    t = Date.today
    month_number = t.month
    @month = Date::MONTHNAMES[month_number]
    current_year = t.year

    current_month = Time.now.month
    current_year = Time.now.year

    @current_workouts = @the_user.workouts.where("strftime('%m', date) = ? AND strftime('%Y', date) = ?", current_month.to_s.rjust(2, '0'), current_year.to_s)

    @past_workouts = @the_user.workouts.where.not("strftime('%m', date) = ? AND strftime('%Y', date) = ?", current_month.to_s.rjust(2, '0'), current_year.to_s)

    render({ :template => "user_authentication/show.html.erb" })
  end

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
  

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => @user.errors.full_messages.to_sentence })
    end
  end
    
  def edit_profile_form

    the_id = params.fetch("path_id")

    matching_users = User.where({ :first_name => the_id })

    @the_user = matching_users.at(0)
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def edit

    the_id = params.fetch("path_id")

    matching_users = User.where({ :first_name => the_id })

    @the_user = matching_users.at(0)
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.private = params.fetch("query_private", false)
    @user.workout_count = params.fetch("query_workout_count")
    @user.workouts_count = params.fetch("query_workouts_count")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" , :alert => @user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end

  def deactivate
    @the_user = User.find(params[:id])
    @the_user.update(active: false)
    redirect_to user_path(@the_user), notice: "Profile has been deactivated."
  end

  def activate
    @the_user = User.find(params[:id])
    @the_user.update(active: true)
    redirect_to user_path(@the_user), notice: "Profile has been activated."
  end
  
  def injury
    the_id = params.fetch("path_id")
    matching_users = User.where({ :first_name => the_id })
    @the_user = matching_users.at(0)
  
    @injury = Injury.new # This initializes a new injury instance

    @user_injuries = @the_user.injuries.order(start_date: :desc)

  
    render({ :template => "user_authentication/injury.html.erb" })
  end
  

 
end
