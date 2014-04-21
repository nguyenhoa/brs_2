class PositionsController < ApplicationController

  def show
    @position = Position.find params[:id]
  end

  def new
    @position = Position.new
  end

  def destroy
    Position.find(params[:id]).destroy
    flash[:success] = "Position deleted."
    redirect_to positions_path
  end

  def index
    @positions = Position.paginate page: params[:page]
>>>>>>>  Task Position
  end

  def edit
    @position = Position.find params[:id]
  end

  def update
    @position = Position.find params[:id]
    if @position.update_attributes position_params
      flash[:success] = "Update done!"
      redirect_to positions_path
    else
      render 'edit'
    end
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = "Create done!"
      redirect_to positions_path
    else
      redirect_to positions_path
    end
  end  

  private
    def position_params
      params.require(:position).permit(:name, :short_name)    
    end
end