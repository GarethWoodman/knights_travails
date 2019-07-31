class Cell
  attr_accessor :x, :y, :distance, :previous_move

  def initialize(x,y, distance)
    @x = x
    @y = y
    @distance = distance
    @moves = Array.new
  end

  def position
    [@x, @y]
  end
end

def knight_moves(position, target)
  dx = [2, 2, -2, -2, 1, 1, -1, -1] 
  dy = [1, -1, 1, -1, 2, -2, 2, -2] 
  
  que = Array.new
  que << Cell.new(position[0], position[1], 0)

  is_visited = create_visited
  is_visited[que[0].position] = true

  while que.length > 0
    current_knight = que.shift
    distance += 1

    if current_knight.position == target
      display_moves = all_previous_moves(current_knight)
      return "You made it in #{display_moves.length-1} moves, path: #{display_moves.reverse.inspect} "
    end

    for i in 0..7
      next_move = [dx[i] + current_knight.x , dy[i] + current_knight.y]
      if is_visited[next_move] == false && in_border(next_move)
        is_visited[next_move] = true
        new_knight = Cell.new(next_move[0], next_move[1], distance)
        new_knight.previous_move = current_knight
        que << new_knight
      end
    end
  end
end

def all_previous_moves(knight)
  moves = Array.new
  moves << knight.position
  while true do
    break if knight.previous_move == nil
    moves << knight.previous_move.position
    knight = knight.previous_move
  end
  moves
end

def in_border(position)
  x = position[0]
  y = position[1]
  (x >= 0 && x <= 7) && (y >= 0 && y <= 7)
end

def create_visited
  visited = Hash.new
  for y in 0..7
    for x in 0..7
      visited[[x,y]] = false
    end
  end
  visited
end
