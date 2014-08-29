class AddFirstLastNameToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    User.reset_column_information

    User.all.each do |user|
      user.first_name = user.email
      user.last_name = " "
      user.save!
    end

    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name, :string, null: false
  end
end
