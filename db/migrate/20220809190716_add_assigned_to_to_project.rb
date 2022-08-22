class AddAssignedToToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :assigned_to, :integer, default: 0
  end
end
