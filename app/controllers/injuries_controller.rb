class InjuriesController < ApplicationController
  def new
    @injury = Injury.new
  end

  def create
    @injury = @current_user.injuries.build(injury_params)

    if @injury.save
      redirect_to("/users/<%= @current_user.first_name %>/injuries", { :notice => "Injury deleted successfully."} )
    else
      render :new
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_injury = Injury.where({ :id => the_id }).at(0)

    the_injury.destroy

    redirect_to("/users/#{@current_user.first_name}/injuries", { :notice => "Injury deleted successfully." })
    
  end


  private

  def injury_params
    params.require(:injury).permit(:description, :start_date, :end_date)
  end

  
end 
