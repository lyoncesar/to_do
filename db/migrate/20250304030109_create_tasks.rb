class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, default: ''
      t.string :description, null: false, default: ''
      t.datetime :expires_at

      t.timestamps
    end
  end
end
