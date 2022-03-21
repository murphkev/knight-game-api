class KnightController < ApplicationController
  def get_move
    # try to convert query params to integers
    begin
      x = Integer(params[:x])
      y = Integer(params[:y])
      tx = Integer(params[:tx])
      ty = Integer(params[:ty])
      put "(x,y) = (#{x},#{y})"
      put "(tx,ty) = (#{tx},#{ty})"
      move = move(x, y, tx, ty)
      render json: { x: move[0], y: move[1] }, status: 200

    # handle non-numeric inputs & impossible case of no move found
    rescue ArgumentError, StandardError => e
      render json: { error: e.message }, status: 400

    end
  end

  private
  def move(x, y, tx, ty)

    pos = [x, y]
    target = [tx, ty]

    put "Pos = (#{pos[0]},#{pos[1]})" 
    put "Target (#{target[0]},#{target[1]})"
    
    # check pos and target
    if !is_valid_square(pos) || !is_valid_square(target) then
      raise ArgumentError.new "Invalid position or target (#{pos[0]},#{pos[1]}) to (#{target[0]},#{target[1]})"
    end

    # all possible moves relative to current pos
    delta_x = [-2, -1,  1,  2, -2, -1, 1, 2]
    delta_y = [-1, -2, -2, -1,  1,  2, 2, 1]

    queue = [pos, []]

    visited = Array.new(8)

    # boolean version of chess board to check visited squares
    # so that we don't revisit the same square and end up in
    # an infinite loop
    for i in visited do 
        visited[i] = Array.new(8)
        for j in visited[i] do
            visited[i][j] = false;
        end
    end 

    # mark the current knight pos as visited
    visited[pos[0]][pos[1]] = true;

    # vars for the new position
    new_pos, x, y = 0, 0, 0

    # loop until there is one element in queue
    while queue.length() != 0 do

        # get the first pos
        
        # NB: because positions are added in order of 
        # lowest to greatest 'distance' to target,
        # we don't need to sort the array, or compare the 
        # distance of moves; the first element will always
        # have the lowest, or equal lowest move count.
        
        new_pos = queue.shift();

        # if that's the target...
        if is_same_square(new_pos[0], target) then 
            return new_pos[1]
        end

        # otherwise check every other move possible
        for i in 0..8 do
            x = new_pos[0][0] + delta_x[i]
            y = new_pos[0][1] + delta_y[i]
            xy = Array[x, y]

            # make sure those squares are valid, and not previously visited
            if is_valid_square(xy) && !visited[x][y] then
                # mark square as visited
                visited[x][y] = true;
                history = new_pos[1] + xy
                queue.push(Array[xy, history])
            end
        end
    end

    # unsolvable, which should be impossible
    raise StandardError.new "Knight move could not be found"
  end

  # checks to see if two positions are the same
  def is_same_square(pos1, pos2) 
      if pos1.length() == 2 && pos2.length() == 2 then
          return pos1[0].eql?(pos2[0]) && pos1[1].eql?(pos2[1])
      else
          return false
      end
  end

  # checks to see if a square is valid for the board
  def is_valid_square(pos) 
      if pos.length() == 2 then
          return pos[0].between?(0, 7) && pos[1].between?(0, 7)
      else
          return false
      end
  end
end