class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # チャット機能の定義します
      if user_signed_in?
        @currentUserEntry = UserRoom.where(user_id: current_user.id)
        @userEntry = UserRoom.where(user_id: @user.id)
        unless @user.id == current_user.id
          @currentUserEntry.each do |cu|
            @userEntry.each do |u|
              if cu.room_id == u.room_id
                @haveRoom = true
                @roomId = cu.room_id
              end
            end
          end
          unless @haveRoom
            @room = Room.new
            @user_room = UserRoom.new
          end
        end
      end 
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user.id
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.follower
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.followed
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

end
