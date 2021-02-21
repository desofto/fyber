class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :text

      t.integer :sender_id, index: true
      t.integer :group_id, index: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
