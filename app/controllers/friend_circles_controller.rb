class FriendCirclesController < ApplicationController
  before_filter :enforce_logged_in

  def show
    @fc = FriendCircle.find(params[:id])
    render :show
  end

  def index
    @friend_circles = FriendCircle.all
    render :index
  end

  def new
    @users = User.all
    @fc = FriendCircle.new
    render :new
  end

  def create
    fc_params = params[:fc]
    fc_params[:owner_id] = current_user.id
    @fc = FriendCircle.new(fc_params)
    if @fc.save
      friends = params[:friends]
      friends.each do |friend|
        Membership.create!(friend_circle_id: @fc.id, user_id: friend)
      end
      redirect_to @fc
    else
      render :new
    end
  end

  def edit
    @users = User.all
    @fc = FriendCircle.find(params[:id])
    render :edit
  end

  def update
    @fc = FriendCircle.find(params[:id])
    @fc.name = params[:fc][:name]
    if @fc.save
      friends = params[:friends] #array of numbers
      p friends

      #remove unchecked members
      @fc.memberships.each do |membership|
        unless friends.include?(membership.user_id)
          membership.delete
          friends.delete(membership.user_id) #optimization
        end
      end

      #add new friends to circle
      friends.each do |friend|
        unless @fc.member_ids.include?(friend) #_ids not necessary?!?!???
          Membership.create!(friend_circle_id: @fc.id, user_id: friend)
        end
      end
      redirect_to @fc
    else
      render :edit
    end
  end

end
