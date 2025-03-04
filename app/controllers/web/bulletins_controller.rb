class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_bulletin, only: %i[show]
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save!
      redirect_to bulletin_path(@bulletin), notice: t('bulletin.actions.create_success')
    else
      render :new, notice: t('bulletin.actions.create_failure')
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('bulletin.actions.update_success')
    else
      render :edit, notice: t('bulletin.actions.update_failure')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.expect(bulletin: %i[image title description user_id category_id])
  end
end
