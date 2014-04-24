class SkillsController < ApplicationController

  def show
    @skill = Skill.find params[:id]
  end

  def index
    @skills = Skill.paginate page: params[:page]
  end

  
  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save 
      flash[:success] = "Create Successful!"
      redirect_to @skills
    else
      flash[:faild] = "fail"
      render 'new'
    end
  end

  def edit
    @skill = Skill.find params[:id]
  end

  def update
    @skill = Skill.find params[:id]
    if @skill.update_attributes skill_params
      flash[:success] = "Successful! Skill updated."
      redirect_to @skill
    else
      flash[:faild] = "Edit faild"
      render 'edit'
    end
  end

  def destroy
    Skill.find (params[:id]).destroy
    flash[:success] = "Skill deleted."
    redirect_to skills_url
  end

  private

    def skill_params
      params.require(:skill).permit(:name)
    end
end
