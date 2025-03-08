# frozen_string_literal: true

class Web::ProfileController < ApplicationController
  before_action :authenticate_user!, only: :index
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true)
                   .where(user_id: current_user.id)
                   .order(created_at: :desc)
                   .page(params[:page])
  end
end
