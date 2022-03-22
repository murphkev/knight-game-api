class KnightController < ApplicationController
  def get_move
    # try to convert query params to integers
    begin
      x = Integer(params[:x])
      y = Integer(params[:y])
      tx = Integer(params[:tx])
      ty = Integer(params[:ty])
      @knight = new Knight(x, y, tx, ty)
      @path = @knight.get_path_to_target
      render json: { path: @path }, status: 200

    # handle non-numeric inputs & impossible case of no move found
    rescue ArgumentError, StandardError => e
      render json: { error: e.message }, status: 400

    end
  end
end