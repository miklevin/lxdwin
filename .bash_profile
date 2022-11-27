# Activate py310 virtual environment.
source ~/py311/bin/activate

# Color-code prompt.
source ~/.bash_prompt

# Make gnu screen show more useful information.
export SCREENDIR=$HOME/.screen

# Allow all your Jupyter configuration (dark mode) survive reinstalls.
export JUPYTER_CONFIG_DIR=~/repos/transfer/.jupyter

# Enable WSL Graphics & Auido
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export WAYLAND_DISPLAY=wayland-0
export PULSE_SERVER=/mnt/wslg/pulseserver

# Un-comment the following lines to enable Linux graphics using VcXsrv or Xming.
# source ~/repos/transfer/.display.sh
# LIBGL_ALWAYS_INDIRECT=1

# Un-comment the following line if you've set up graphis on WSL host.
# source ~/repos/transfer/.display.sh

cd ~/repos
