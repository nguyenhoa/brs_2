class UsersController < ApplicationController

  before_filter :signed_in_user

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

  def index
    @q = User.search params[:q]
    @users = @q.result(distinct: true).order(:id).page(params[:page])
  end

  def create
    @user = User.new user_params
    @user.role = 0

    if @user.save

      Activity.create( time: Time.now, action: "Create User",
                                user: @user.id, description: @user.name)

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
      Activity.create( time: Time.now, action: "Update User",
                                user: @user.id, description: @user.name)
      redirect_to @user
    else
      flash[:faild] = "Edit faild"
      render 'edit'
    end
  end

  def destroy
   user = User.find (params[:id])
    Activity.create( time: Time.now, action: "Deleted Users",
                                user: user.id, description: user.name)
    user.destroy
   flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
     params.require(:user).permit(:name, :birthday, :email, :role,
        :password, :password_confirmation, :team_id, :position_id,
        user_skills_attributes: [:skill_id, :level, :num_year], "project_ids" => [])
    end
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def correct_user
      redirect_to(root_path) unless admin_user?(current_user)
    end
end