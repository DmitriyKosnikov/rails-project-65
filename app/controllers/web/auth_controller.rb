class Web::AuthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    user = User.find_or_initialize_by(email: auth.info.email)
    user.name = auth.info.name

    if user.save
      session[:user_id] = user.id
      redirect_to rails_health_check_path, notice: t('auth.github.success')
    else
      redirect_to rails_health_check_path, alert: t('auth.github.failure')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to rails_health_check_path, notice: t('auth.github.logout')
  end
end
