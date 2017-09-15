class UsersController < Clearance::UsersController

  private

  def user_from_params
    email = user_params.delete(:email)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.first_name = first_name
      user.last_name = last_name
      user.password = password
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end

end