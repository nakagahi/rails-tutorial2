class UsersController < ApplicationController


  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy


  def show
    @user = User.find(params[:id])

  end

  def new

    @user = User.new

  end

  # POST /users (+ params)
   def create


    @user = User.new(user_params)


    if @user.save
      send_activation_email(@user)
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else

      render 'new'
    end


   end

   def edit

     @user = User.find(params[:id])

   end

   def update

     @user = User.find(params[:id])

     if @user.update(user_params)

       flash[:success] = "Profile Update Success"

       redirect_to @user

     else

       flash.now[:danger] = "not update"

       render "edit"

     end

   end

   def index

     @users = User.paginate(page: params[:page])

   end

   def destroy

     User.find(params[:id]).destroy

     flash[:success] = "delete success!"

     redirect_to users_path

   end

   def logged_in_user

    unless loged_in?

      store_location

      flash[:danger] = "Please login!"


      redirect_to login_path

    end

   end

   def correct_user

     unless current_user == User.find(params[:id])

       flash[:danger] = "You are worng user!"
       redirect_to root_path

     end

   end

   def admin_user

     redirect_to users_path unless current_user.admin?

   end


   private

   def user_params

     params.require(:user).permit(:name, :email, :password, :password_confirmation)

   end



end
