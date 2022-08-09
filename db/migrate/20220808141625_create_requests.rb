class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :ts
      t.string :channel
      t.string :target_language
      t.string :item_user
      t.string :reaction_type

      t.timestamps
    end
  end
end
