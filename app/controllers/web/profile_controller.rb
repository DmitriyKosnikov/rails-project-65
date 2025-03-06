class Web::ProfileController < ApplicationController
  before_action :authenticate_user!, only: :index
  def index
    @bulletins = Bulletin.where(user_id: current_user.id)
  end
end
