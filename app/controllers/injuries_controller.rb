class InjuriesController < ApplicationController
  def new
    @injury = Injury.new
  end

  def create
    @injury = current_user.injuries.build(injury_params)

    if @injury.save
      redirect_to user_path(current_user), notice: "Injury logged successfully."
    else
      render :new
    end
  end

  private

  def injury_params
    params.require(:injury).permit(:description, :start_date, :end_date)
  end
end 
