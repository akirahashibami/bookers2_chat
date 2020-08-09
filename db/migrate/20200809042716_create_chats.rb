class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|

      t.references :user_id, foreign_key: true
      t.references :room_id, foreign_key: true
      t.text :chat, null: false
      t.timestamps
    end
  end
end
