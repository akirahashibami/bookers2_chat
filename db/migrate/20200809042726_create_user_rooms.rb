class CreateUserRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_rooms do |t|

      t.references :user_id, foreign_key: true
      t.references :room_id, foreign_key: true
      t.timestamps
    end
  end
end
