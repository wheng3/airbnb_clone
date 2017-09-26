class UsersController < Clearance::UsersController

  def new
    render template: "users/new"
  end

  def create
    @user = User.new(user_from_params)

    if @user.save
      WelcomeJob.perform_later(@user)
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def superadmin_secret
    allowed?(action: action_name, user: current_user)
  end

  def edit
    if current_user == User.find(params[:id])
      @user = current_user
      render template: "users/edit"
    else
      redirect '/'
      flash[:faliure] = "Sorry you can't edit other users' profile"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_from_params)
      flash[:success] = "Successfully updated user profile"
      render template: "users/edit"
    else
      render 'edit'
    end
  end

  def listings
    @listings = current_user.listings
  end

  def reservations
    @reservations = current_user.reservations
  end

  private

  def user_from_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :avatar)
  end
end