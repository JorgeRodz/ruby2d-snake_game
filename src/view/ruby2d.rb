# rubocop:disable all
require 'ruby2d' # In order to use ruby2d
require_relative "../model/state"

module View
  # Main class window view
  class Ruby2dView
    # Construct function/method
    def initialize(app)
      @pixel_size = 50
      @food
      @snake_positions
      @app = app
    end

    # Method to display the window
    def start(state)
      extend Ruby2D::DSL # Necessary to manage the native window system
      set( # Set window properties
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows
      )
      on :key_down do |event|
        handle_key_event(event)
      end
      show # ruby2d method to display the window
    end

    # Method to render the game state(snake, food)
    def render(state)
      extend Ruby2D::DSL # Necessary to manage the native window system
      close if state.game_finished
      render_food(state)  # To display the food
      render_snake(state)  # To display the snake
    end

    private

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL # Necessary to manage the native window system
      food = state.food
      @food = Square.new(
        x: food.col * @pixel_size,
        y: food.row * @pixel_size,
        size: @pixel_size,
        color: 'yellow',
      )
    end

    def render_snake(state)
      # if @snake_positions
      #   @snake_positions.each do |pos|
      #     pos.remove
      #   end
      # end
      @snake_positions.each(&:remove) if @snake_positions # This line is the same as the if block above
      extend Ruby2D::DSL # Necessary to manage the native window system
      snake = state.snake
      @snake_positions = snake.positions.map do |pos|
        Square.new(
          x: pos.col * @pixel_size,
          y: pos.row * @pixel_size,
          size: @pixel_size,
          color: 'green',
        )
      end
    end

    def  handle_key_event(event)
      case event.key
        when 'up'
          # cambiar direccion hacia arriba
          @app.send_action(:change_direction, Model::Direction::UP)
        when 'down'
          # cambiar direccion hacia abajo
          @app.send_action(:change_direction, Model::Direction::DOWN)
        when 'left'
          # cambiar direccion hacia izquierda
          @app.send_action(:change_direction, Model::Direction::LEFT)
        when 'right'
          # cambiar direccion hacia derecha
          @app.send_action(:change_direction, Model::Direction::RIGHT)
      end
    end
  end
end
