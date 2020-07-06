from __future__ import (absolute_import, division, print_function)

import os
from ranger.api.commands import Command

class move_to_trash(Command):
    """
    :move_to_trash
    Move file to trash
    """
    def execute(self):
        import shutil
        shutil.move(self.fm.thisfile.path, "/home/nikhgupta/.local/share/Trash/" + self.fm.thisfile.basename)
