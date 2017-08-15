bundler install
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm

pushd /home/uitests/public_app_ui/

xvfb-run -s "-screen 0 1920x1080x16" bundle exec cucumber \
  --expand \
  -f AllureCucumber::Formatter \
  --out allureoutput.log \

sudo cp -R gen/* gen1/
