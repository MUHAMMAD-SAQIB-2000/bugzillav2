class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, unique: true
      t.text :description
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
