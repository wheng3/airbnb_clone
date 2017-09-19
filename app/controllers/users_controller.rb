class UsersController < Clearance::UsersController

  def new
    @user = User.new(user_from_params)
    render template: "users/new"
  end

  def create
    @user = User.new(user_from_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def superadmin_secret
    allowed?(action: action_name, user: current_user)
  end

  private

  def user_from_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
    # email = user_params.delete(:email)
    # first_name = user_params.delete(:first_name)
    # last_name = user_params.delete(:last_name)
    # password = user_params.delete(:password)

    # Clearance.configuration.user_model.new(user_params).tap do |user|
    #   user.email = email
    #   user.first_name = first_name
    #   user.last_name = last_name
    #   user.password = password
    # end
  end

  # def user_params
  #   params[Clearance.configuration.user_parameter] || Hash.new
  # end
end