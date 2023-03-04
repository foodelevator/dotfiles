import atexit
import os
import readline

history = os.path.join(os.environ['XDG_DATA_HOME'], 'python', 'history')

def write_history():
    try:
        os.makedirs(os.path.dirname(history), exist_ok=True)
        readline.write_history_file(history)
    except FileNotFoundError:
        pass

try:
    readline.read_history_file(history)
except FileNotFoundError:
    pass

if readline.get_current_history_length() == 0:
    readline.add_history('# big chungus will get you')

atexit.register(write_history)
