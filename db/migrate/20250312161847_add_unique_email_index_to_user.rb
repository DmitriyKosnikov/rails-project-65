# frozen_string_literal: true

class AddUniqueEmailIndexToUser < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :email, unique: true
  end
end
