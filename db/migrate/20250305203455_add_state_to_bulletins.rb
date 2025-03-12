# frozen_string_literal: true

class AddStateToBulletins < ActiveRecord::Migration[8.0]
  def change
    add_column :bulletins, :state, :string, default: :draft, null: false
  end
end
