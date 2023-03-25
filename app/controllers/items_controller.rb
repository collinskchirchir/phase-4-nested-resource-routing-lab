class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find_by!(id: params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id]
      user = User.find_by!(id: params[:user_id])
      item = user.items.find_by!(id: params[:id])
    else
      item = Item.find_by!(id: params[:id])
    end
    render json: item, status: :ok
  end

  private

  def render_not_found_response
    render json: {error: "User not found"}, status: :not_found
  end


end
