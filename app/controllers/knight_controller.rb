class KnightController < ApplicationController
  def get_path
    # try to convert query params to integers
    x = Integer params[:x]
    y = Integer params[:y]
    tx = Integer params[:tx]
    ty = Integer params[:ty]
    @path = Knight.get_path_to_target(x, y, tx, ty)
    render json: { path: @path }, status: 200
  end
end