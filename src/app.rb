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
    view = View::Ruby2dView.new      # Create a new window view
    Thread.new { init_timer(view) }  # Create a new thread to manage the timer
    view.start(@state)               # Display the window
  end

  def init_timer(view)
    # render the game state every 0.5 seconds
    loop do
      @state = Actions::move_snake(@state)
      view.render(@state)
      sleep 0.5
    end
  end
end

app = App.new
app.start
