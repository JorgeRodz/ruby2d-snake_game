# rubocop:disable all
require 'ruby2d' # In order to use ruby2d

module View
  # Main class window view
  class Ruby2dView
    # Construct function/method
    def initialize
      @pixel_size = 50
    end

    # Method to render all the game
    def render(state)
      extend Ruby2D::DSL # Necessary to manage the native window system
      set( # Set window properties
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows
      )
      render_food(state)  # To display the food
      render_snake(state)  # To display the snake
      show # calling the method show in order to dislay the window
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
