class Web::Admin::BulletinsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  def index
    @bulletins = Bulletin.all
  end

  def moderation
  end
end
