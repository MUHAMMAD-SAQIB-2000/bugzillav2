class AddAssignedToToBug < ActiveRecord::Migration[7.0]
  def change
    # add_reference :bugs, :user, null: false, foreign_key: true
    # add_column :bugs, :assigned_to, :integer, default: 0
  end
end
