class UsersController < ApplicationController
  before_action   :logged_in_user,  only:  [:edit, :update, :index, :destroy, :show]
  before_action   :correct_user,  only:  [:edit, :update, :show]
  before_action  :admin_user,  only:     :destroy

  def new
    @user = User.new
  end

  def show
      @user = User.find(params[:id])
      @money = User.get_balance(@user.id)
      @cash = User.get_cash_available(@user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = 'Welcome, your account was created successfully!'
       log_in @user
      redirect_to @user
    else
      @user.errors.full_messages.each() do |e|
        flash[:danger] = e
      end
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   if @user.update (user_params)
       flash[:success] = 'Profile updated successfully'
       redirect_to @user
   else
       flash[:danger] = 'Could not update information. Make sure password is correct'
       redirect_to edit_user_path(current_user)
   end
  end

  def index
    @users = User.all()
  end

  def destroy
   User.find(params[:id]).destroy
   flash[:success] = '***The user is successfully deleted***'
   redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
   unless  logged_in?
        flash[:danger] = 'Please log in'
        redirect_to   login_url
   end
  end

  def correct_user
     @user = User.find(params[:id])
      unless current_user?(@user) or current_user.admin?
        redirect_to(root_url)
      end
  end

  def admin_user
     redirect_to(root_url)  unless current_user.admin?
  end

end
