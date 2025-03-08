class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[reject publish archive]
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page])
  end

  def moderation
    @bulletins = Bulletin.where(state: :under_moderation)
  end

  def reject
    if @bulletin.may_reject?
      @bulletin.reject!
      redirect_to admin_path, notice: t('admin.messages.success')
    else
      redirect_to admin_path, notice: t('admin.messages.failure')
    end
  end

  def publish
    if @bulletin.may_publish?
      @bulletin.publish!
      redirect_to admin_path, notice: t('admin.messages.success')
    else
      redirect_to admin_path, notice: t('admin.messages.failure')
    end
  end

  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      redirect_to admin_path, notice: t('admin.messages.success')
    else
      redirect_to admin_path, notice: t('admin.messages.failure')
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
end
