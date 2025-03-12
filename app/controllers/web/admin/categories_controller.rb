# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('category.actions.create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('category.actions.update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.bulletins.any?
      redirect_to admin_categories_path, notice: t('category.actions.destroy_has_bulletins')
    else
      @category.destroy!

      redirect_to admin_categories_path, notice: t('category.actions.destroy_success')
    end
  end

  private

  def category_params
    params.expect(category: [:name])
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
