class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :email
      t.text :password_digest
      t.text :token
      t.integer :time_zone
      t.integer :group_id, index: true

      t.timestamps
    end
  end
end
