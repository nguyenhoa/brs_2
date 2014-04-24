class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new

    @projects = Project.all
    @projects.each do |project|
      @user.user_projects.build project_id: project.id
    end

    @skills = Skill.all
    @skills.each do |skill|
      @user.user_skills.build skill_id: skill.id
    end
  end

  def create
    @user = User.new user_params
    @projects = Project.all
    @project_ids = params[:project_ids]
    @skills = Skill.all
    @skill_ids = params[:skill_ids]
    @user.role = 0
    if @user.save 
      @project_ids.each do |project_id|
        @user_project = UserProject.new
        @user_project.user_id = @user.id
        @user_project.project_id = project_id
        @user_project.save
      end
      @skill_ids.each do |skill_id|
        @user_skill = UserSkill.new
        @user_skill.user_id = @user.id
        @user_skill.skill_id = skill_id
        @user_skill.save
      end
      flash[:success] = "Create Successful!"
      redirect_to @user
    else
      flash[:faild] = "fail"
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = "Successful! Profile updated."
      redirect_to @user
    else
      flash[:faild] = "Edit faild"
      render 'edit'
    end
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    User.find (params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :birthday, :email, :role, :password, :password_confirmation, :team_id, :position_id)
    end
end
