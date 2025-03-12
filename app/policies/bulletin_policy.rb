# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  include Rails.application.routes.url_helpers

  def edit?
    update?
  end

  def update?
    record.user_id == user.id
  end

  def to_moderate?
    update?
  end

  def archive?
    update?
  end
end
