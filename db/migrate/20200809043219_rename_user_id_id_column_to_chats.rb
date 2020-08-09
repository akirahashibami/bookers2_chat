class RenameUserIdIdColumnToChats < ActiveRecord::Migration[5.2]
  def change
    rename_column :chats, :user_id_id, :user_id
    rename_column :chats, :room_id_id, :room_id
  end
end
