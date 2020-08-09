class RoomsController < ApplicationController

  before_action :authenticate_user!

  def create
    @room = Room.create
    @user_room1 = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    # 現在ログインしているユーザーに対しては、@entry1とし、
    # EntriesテーブルにRoom.createで作成された@roomにひもづくidと、
    # 現在ログインしているユーザーのidを保存させる記述をします。
    @user_room2 = UserRoom.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    # @entry2ではフォローされている側の情報をEntriesテーブルに保存するため。
    # users/show.html.erbのfields_for @entryで保存したparamsの情報(:user_id, :room_id)を許可し、
    # 現在ログインしているユーザーと同じく@roomにひもづくidを保存する記述をしています。
    redirect_to "/rooms/#{@room.id}"
    # そしてcreateと同時に、チャットルームが開くようにredirectをしています。
  end

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      # UserRoomテーブルに、現在ログインしているユーザーのidとそれにひもづいたチャットルームのidを
      # whereメソッドで探し、そのレコードがあるか確認します。
      @chats = @room.chats
      @chat = Chat.new
      @user_rooms = @room.user_rooms
      # Chatテーブルにそのチャットルームのidと紐づいたメッセージを表示させるため、
      # @chatsにアソシエーションを利用した@room.chatsという記述を代入します。
      # 新しくメッセージを作成する場合は、メッセージのインスタンスを生成するために、
      # Message.newをし、@messageに代入させます。
      # rooms/show.html.erbでユーザーの名前などの情報を表示させるために、@room.user_roomsを
      # @user_roomsというインスタンス変数に入れ、UserRoomsテーブルのuser_idの情報を取得します（ビューの方で記述）。
    else
      redirect_back(fallback_location: root_path)
      # 条件がfalseだったら、前のページに戻るための記述である、redirect_backを使います。
    end
  end
end
