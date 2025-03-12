# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_bulletin, only: %i[show edit update to_moderate archive]
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true)
                   .published
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(12)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    authorize @bulletin
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
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('bulletins.actions.update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    authorize @bulletin

    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      redirect_to profile_path, notice: t('admin.messages.success')
    else
      redirect_to profile_path, notice: t('admin.messages.failure')
    end
  end

  def archive
    authorize @bulletin

    if @bulletin.may_archive?
      @bulletin.archive!

      redirect_to profile_path, notice: t('admin.messages.success')
    else
      redirect_to profile_path, notice: t('admin.messages.failure')
    end
  end

  private

  def user_not_authorized
    redirect_to bulletin_path(@bulletin), notice: t('bulletins.actions.diff_user')
  end

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.expect(bulletin: %i[image title description user_id category_id])
  end
end
