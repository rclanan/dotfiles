#!/usr/bin/env python3
"""
Python startup file for enhanced interactive experience
"""

import atexit
import os
import readline
import rlcompleter
import sys

# Enable tab completion
readline.parse_and_bind("tab: complete")

# History file
histfile = os.path.join(os.path.expanduser("~"), ".python_history")

try:
    readline.read_history_file(histfile)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)

# Pretty printing for interactive sessions
if sys.stdout.isatty():
    try:
        import pprint
        import sys
        from pprint import pprint as original_pprint

        def pprint(obj, stream=None, indent=1, width=80, depth=None, *, compact=False, sort_dicts=True):
            if stream is None:
                stream = sys.stdout
            original_pprint(obj, stream, indent, width, depth, compact=compact, sort_dicts=sort_dicts)

        # Make pprint available in interactive sessions
        __builtins__['pprint'] = pprint

    except ImportError:
        pass

# Custom prompt
sys.ps1 = ">>> "
sys.ps2 = "... "

print("Python interactive session enhanced!")
print("Available: tab completion, history, pprint")
