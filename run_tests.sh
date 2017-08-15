#!/usr/bin/env bash

#URL=${variable:-nginx:80}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm

pushd /home/uitests/public_app_ui/

xvfb-run -s "-screen 0 1920x1080x16" bundle exec cucumber \
  -r features features/log_in.feature \
   --expand \
  -f AllureCucumber::Formatter \
  --out allureoutput.log \

