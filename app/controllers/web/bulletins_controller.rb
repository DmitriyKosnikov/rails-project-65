class Web::BulletinsController < ApplicationController
  include AASM

  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_bulletin, only: %i[show edit update to_moderate archive]
  def index
    @bulletins = Bulletin.where(state: :published).order(created_at: :desc)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    return unless @bulletin.user_id != current_user.id

    redirect_to @bulletin, notice: t('bulletins.actions.diff_user')
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_path(@bulletin), notice: t('bulletins.actions.create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bulletin.user_id == current_user.id
      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('bulletins.actions.update_success')
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to @bulletin, notice: t('bulletins.actions.diff_user')
    end
  end

  def to_moderate
    if @bulletin.user_id == current_user.id
      if @bulletin.may_to_moderate?
        @bulletin.to_moderate!
        redirect_to profile_path, notice: t('admin.messages.success')
      else
        redirect_to profile_path, notice: t('admin.messages.failure')
      end
    else
      redirect_to @bulletin, notice: t('bulletins.actions.diff_user')
    end
  end

  def archive
    if @bulletin.user_id == current_user.id
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to profile_path, notice: t('admin.messages.success')
      else
        redirect_to profile_path, notice: t('admin.messages.failure')
      end
    else
      redirect_to @bulletin, notice: t('bulletins.actions.diff_user')
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
