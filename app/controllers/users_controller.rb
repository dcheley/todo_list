class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Welcome!"
    else
      render :new
    end
  end

  def edit
    if current_user != @user
      redirect_to :new, notice: "Not authorized."
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "Account updated!"
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email, :first_name, :last_name, :password, :password_confirmation
    )
  end
end
