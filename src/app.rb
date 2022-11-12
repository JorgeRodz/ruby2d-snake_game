# rubocop:disable all
# --- Load the necessary files ---
require_relative 'model/state' # holding the state of the game
require_relative 'view/ruby2d' # all the view related code
# --- Load the necessary files ---

view = View::Ruby2dView.new           # Create a new window view
initial_state = Model::initial_state  # Set the initial state
view.render(initial_state)            # In order to display the window
