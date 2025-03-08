# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    user = User.find_or_initialize_by(email: auth['info']['email'])
    user.name = auth['info']['name']

    if user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: t('auth.github.success')
    else
      redirect_to root_path, alert: t('auth.github.failure')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: t('auth.github.logout')
  end
end
