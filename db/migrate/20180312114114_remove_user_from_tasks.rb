class RemoveUserFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :user, :string
  end
end
