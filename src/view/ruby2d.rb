# rubocop:disable all
require 'ruby2d' # In order to use ruby2d

module View
  # Main class window view
  class Ruby2dView
    # Construct function/method
    def initialize
      @pixel_size = 50
    end

    # Method to display the window
    def start(state)
      extend Ruby2D::DSL # Necessary to manage the native window system
      set( # Set window properties
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows
      )
      show # ruby2d method to display the window
    end

    # Method to render the game state(snake, food)
    def render(state)
      render_food(state)  # To display the food
      render_snake(state)  # To display the snake
    end

    private

    def render_food(state)
      extend Ruby2D::DSL # Necessary to manage the native window system
      food = state.food
      Square.new(
        x: food.col * @pixel_size,
        y: food.row * @pixel_size,
        size: @pixel_size,
        color: 'yellow',
      )
    end

    def render_snake(state)
      extend Ruby2D::DSL # Necessary to manage the native window system
      snake = state.snake
      snake.positions.each do |pos|
        Square.new(
          x: pos.col * @pixel_size,
          y: pos.row * @pixel_size,
          size: @pixel_size,
          color: 'green',
        )
      end
    end
  end
end
