class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.timestamps
      t.string :name
      t.string :description
    end
  end
end
