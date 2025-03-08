# frozen_string_literal: true

class ChangeUserToAdmin < ActiveRecord::Migration[8.0]
  def change
    user = User.find_by(email: 'kosnikov.dm@gmail.com')

    user.update(admin: true)
  end
end
