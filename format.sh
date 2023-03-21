#!/bin/sh
shfmt --write --posix shrc profile install.sh update-repo.sh
shfmt --write --language-dialect bash bashrc bash_profile
black --quiet startup.py
