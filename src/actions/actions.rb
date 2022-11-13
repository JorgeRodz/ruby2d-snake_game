# rubocop:disable all
module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)
    # verificar que la siguiente casilla sea valida
    if position_is_valid?(state, next_position)
      move_snake_to(state, next_position)
    else
      end_game(state)
    end
  end

  private

  def self.calc_next_position(state)
    current_position = state.snake.positions.first
    case state.next_direction
      when Model::Direction::UP
        # reducir fila
        return Model::Coord.new(
          current_position.row - 1,
          current_position.col
        )
      when Model::Direction::RIGHT
        # incrementar col
        return Model::Coord.new(
          current_position.row,
          current_position.col + 1
        )
      when Model::Direction::DOWN
        # incrementar fila
        return Model::Coord.new(
          current_position.row + 1,
          current_position.col
        )
      when Model::Direction::LEFT
        # reducir col
        return Model::Coord.new(
          current_position.row,
          current_position.col - 1
        )
    end
  end

  def self.position_is_valid?(state, next_position)
    # verificar que este en la grilla
    is_invalid =  (
                    (next_position.row >= state.grid.rows || next_position.row < 0) ||
                    (next_position.col >= state.grid.cols || next_position.col < 0)
                  )
    return false if is_invalid
    # verificar que no este superponiendo a la serpiente
    return !(state.snake.positions.include? next_position)
  end

  def self.move_snake_to(state, next_position)
    # [(1,1),(1,0)]
    new_positions = [next_position] + state.snake.positions[0...-1]
    state.snake.positions = new_positions
    state
  end

  def self.end_game(state)
    state.game_finished = true
    state
  end
end
