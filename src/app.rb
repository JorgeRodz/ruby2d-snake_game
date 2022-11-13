# rubocop:disable all
# --- Load the necessary files ---
require_relative 'model/state'      # holding the state of the game
require_relative 'view/ruby2d'      # all the view related code
require_relative 'actions/actions'  # In order to move all the components of the game
# --- Load the necessary files ---



class App
  def initialize
    @state = Model::initial_state  # Set the initial state
  end

  def start
    @view = View::Ruby2dView.new(self)      # Create a new window view
    timer_thread = Thread.new { init_timer }  # Create a new thread to manage the timer
    @view.start(@state)               # Display the window
    timer_thread.join
  end

  def init_timer
    # render the game state every 0.5 seconds
    loop do
      if @state.game_finished
        puts "Juego terminado"
        puts "Puntaje: #{@state.snake.positions.length}"
        break
      end
      @state = Actions::move_snake(@state)
      @view.render(@state)
      sleep 0.5
    end
  end

  def send_action(action, params)
    # :change_direction, Model::Direction::UP
    new_state = Actions.send(action, @state, params)
    if new_state.hash != @state.hash
      @state = new_state
      @view.render(@state)
    end
    @view.render(@state)
  end
end

app = App.new
app.start
