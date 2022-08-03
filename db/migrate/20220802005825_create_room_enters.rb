class CreateRoomEnters < ActiveRecord::Migration[6.1]
  def change
    create_table :room_enters do |t|
      t.integer :room_id
      t.integer :user_id
      t.timestamps
    end
  end
end
