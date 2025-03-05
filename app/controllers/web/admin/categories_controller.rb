class Web::Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Categories.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('categories.actions.create_success')
    else
      render :new, status: :unproccessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('categorites.actions.update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.delete!

    redirect_to admin_categories_path, notice: t('categories.actions.destroy_success')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
