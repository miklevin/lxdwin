@echo off
cls

:::intro:::  Begin your life-time journey of Linux, Python, vim & git.         /)
:::intro:::      _                   _          __   __                 /)\_ _//
:::intro:::     | |_   _ _ __  _   _| |_ ___ _ _\ \ / /__  _   _    ___(/_ 0 0
:::intro:::  _  | | | | | '_ \| | | | __/ _ \ '__\ V / _ \| | | | *(     =(_T_)=
:::intro::: | |_| | |_| | |_) | |_| | ||  __/ |   | | (_) | |_| |   \  )   \"\
:::intro:::  \___/ \__,_| .__/ \__, |\__\___|_|   |_|\___/ \__,_|    |__>-\_>_>
:::intro:::             |_|    |___/
:::intro::: RUN JUPYTER ON LXD LINUX CONTAINER UNDER WINDOWS SUBSYSTEM FOR LINUX

:: LIFE AFTER WINDOWS STARTS HERE
:: Welcome to the most amazing thing you're going to see all day, and perhaps one
:: that will change your life forever. Enough hype. Let's get on with the process
:: that Microsoft doesn't want you to see -- and certainly not be able to perform.

:: WHERE To GO TO LEARN MORE
:: If you found this page through https://mikelev.in/ux and want to see the Github
:: and want to learn more, visit main page at https://github.com/miklevin/wsl2lxd

:: HOW TO INSTALL (SAVE THIS AND RUN)
:: Right-click in this window (if you're viewing it from the Github raw view at
:: https://raw.githubusercontent.com/miklevin/wsl2lxd/main/install.bat ), select
:: all, create a file named install.bat on your local Windows 10 or 11 computer
:: and double-click it to run. 

:: WHAT DOES IT DO? (INSTALLS A PORTABLE LINUX)
:: It will take over your Ubuntu 18.04 "slot" in the Windows Subsysystem for Linux,
:: (WSL) then install the LXD Linux Conainer software with an Ubuntu 20.04 hosting
:: JupyterLab Server reachable on your Windows machine at http://localhost:8888 
:: This the best way to run Juputer and eventually free yourself from Windows.

:: Display the above bunny-banner when the script is run as Windows .BAT file.
for /f "delims=: tokens=1*" %%A in ('findstr /b ":::intro:::" "%~f0"') do (echo.%%B)
echo.
echo This will uninstall any previous Ubuntu-18.04 and install a new one.
echo The new Ubutnu 18.04 will then create a new JupyterLab LXD container
echo which will host Jupyter in Windows browser at http://localhost:8888.
echo.
set /p warning=Press [Enter] to jump down Linux rabbit hole or press Ctrl+C escape. %
echo.

:: If you're runnnig Ubuntu 18.04 under WSL, this is going to delete it!
wsl --unregister Ubuntu-18.04
wsl --set-default-version 2

:: These are variables for the automatically created Ubuntu 18.04 user under WSL.
set wsluer="ubuntu"
set password="foo"

:: The big install! If it's your first time, it will make you reboot your machine.
ubuntu1804 install --root

:: Once Ubuntu 18.04 is installed, this sets up the default user.
wsl --distribution Ubuntu-18.04 -u root useradd -m "%wsluer%"
wsl --distribution Ubuntu-18.04 -u root sh -c "echo "%wsluer%:%password%" | chpasswd" # wrapped in sh -c to get the pipe to work
wsl --distribution Ubuntu-18.04 -u root  chsh -s /bin/bash "%wsluer%"
wsl --distribution Ubuntu-18.04 -u root usermod -aG adm,cdrom,sudo,dip,plugdev "%wsluer%"
ubuntu1804 config --default-user "%wsluer%"

:: This creates "repos" folder in your Windows HOME for Windows/Linux file sharing.
if not exist "%USERPROFILE%\repos" mkdir %USERPROFILE%\repos
if not exist "%USERPROFILE%\repos\temp" mkdir %USERPROFILE%\repos\temp
if not exist "%USERPROFILE%\repos\transfer" mkdir %USERPROFILE%\repos\transfer
if not exist "%USERPROFILE%\repos\transfer\.jupyter" mkdir %USERPROFILE%\repos\transfer\.jupyter

:: This makes file permissions under WSL keyed off of your Windows-side.
wsl --distribution Ubuntu-18.04 -u root -e echo -e "[automount]\n"options = \"metadata\" > wsl.conf
wsl --distribution Ubuntu-18.04 -u root -e mv wsl.conf /etc/

:: This creates the a repos and .ssh folder on WSL by linking to your Windows-side.
wsl --distribution Ubuntu-18.04 -e bash -lic "ln -s /mnt/c/Users/%USERNAME%/.ssh/ /home/ubuntu/.ssh" >nul
wsl --distribution Ubuntu-18.04 -e bash -lic "ln -s /mnt/c/Users/%USERNAME%/repos/ /home/ubuntu/repos" >nul

:: If you keep a .vimrc and .gitconfig Windows-side, this copies them over.
wsl --distribution Ubuntu-18.04 -e bash -lic "cp /mnt/c/Users/%USERNAME%/.vimrc /home/ubuntu/" >nul
wsl --distribution Ubuntu-18.04 -e bash -lic "cp /mnt/c/Users/%USERNAME%/.gitconfig /home/ubuntu/" >nul

:::apt:::  _   _           _       _   _              __        ______  _       _     _                  
:::apt::: | | | |_ __   __| | __ _| |_(_)_ __   __ _  \ \      / / ___|| |     | |   (_)_ __  _   ___  __
:::apt::: | | | | '_ \ / _` |/ _` | __| | '_ \ / _` |  \ \ /\ / /\___ \| |     | |   | | '_ \| | | \ \/ /
:::apt::: | |_| | |_) | (_| | (_| | |_| | | | | (_| |   \ V  V /  ___) | |___  | |___| | | | | |_| |>  < 
:::apt:::  \___/| .__/ \__,_|\__,_|\__|_|_| |_|\__, |    \_/\_/  |____/|_____| |_____|_|_| |_|\__,_/_/\_\
:::apt:::       |_|                            |___/                                                     
for /f "delims=: tokens=1*" %%A in ('findstr /b ":::apt:::" "%~f0"') do (echo.%%B)

:: We update the software reposotory on the Ubuntu 18.04 Machine
wsl --distribution Ubuntu-18.04 -u root -e sudo apt update

:: With Figlet installed, I no longer need to embed ASCII art headlines.
wsl --distribution Ubuntu-18.04 -u root -e sudo apt install figlet
wsl --distribution Ubuntu-18.04 -e bash -lic "figlet -t 'Ugrading WSL Linux'"

:: And now the big upgrading of all the Ubuntu 18.04 software.
wsl --distribution Ubuntu-18.04 -u root -e sudo apt upgrade -y
wsl --distribution Ubuntu-18.04 -e bash -lic "figlet -t 'Installing systemd'"

:: The "j" program is how Ubuntu 18.04 in WSL starts Jupyter on Ubuntu 20.04 in LXD.
wsl --distribution Ubuntu-18.04 -u root -e curl -L -o /usr/local/sbin/j "https://raw.githubusercontent.com/miklevin/wsl2lxd/main/j"
wsl --distribution Ubuntu-18.04 -u root -e chown ubuntu:ubuntu /usr/local/sbin/j
wsl --distribution Ubuntu-18.04 -u root -e chmod +x /usr/local/sbin/j

:: Grab and run distrod's install.sh from Github to turn on systemd (required for LXD)
wsl --distribution Ubuntu-18.04 -u root -e curl -L -o /home/ubuntu/repos/temp/install.sh "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
wsl --distribution Ubuntu-18.04 -u root -e chmod 777 /home/ubuntu/repos/temp/install.sh
wsl --distribution Ubuntu-18.04 -u root -e chown ubuntu:ubuntu /home/ubuntu/repos/temp/install.sh
wsl --distribution Ubuntu-18.04 -u root -e /home/ubuntu/repos/temp/install.sh install

:: Activate the LXD requirement "systemd" under WSL (previously unvailable).
wsl --distribution Ubuntu-18.04 -u root -e /opt/distrod/bin/distrod enable
wsl --distribution Ubuntu-18.04 -e bash -lic "figlet -t 'Systemd Installed'"

:: You know what's nice? Not having to type a password every time you sudo a command!
wsl --distribution Ubuntu-18.04 -u root -- echo 'ubuntu	ALL=(ALL:ALL) NOPASSWD:ALL'> ubuntu
wsl --distribution Ubuntu-18.04 -u root -- chmod 0440 ubuntu
wsl --distribution Ubuntu-18.04 -u root -- chown 0 ubuntu
wsl --distribution Ubuntu-18.04 -u root -- mv ubuntu /etc/sudoers.d/

:: Deep breath... Install the LXD Linux Container system on WSL accepting all defaults.
timeout /t 3 /nobreak >nul
wsl --distribution Ubuntu-18.04 -u ubuntu -e lxd init --auto
wsl --distribution Ubuntu-18.04 -e bash -lic "figlet -t 'Installing LXD Container'"

:: Grab and run install.sh from my Github for second half of install (under LXD)
wsl --distribution Ubuntu-18.04 -u ubuntu -e curl -L -o /home/ubuntu/repos/temp/install.sh "https://raw.githubusercontent.com/miklevin/jupyme/main/install.sh"
wsl --distribution Ubuntu-18.04 -e bash -lic "echo j > ~/.bash_profile"
wsl --distribution Ubuntu-18.04 -u ubuntu -e bash /home/ubuntu/repos/temp/install.sh

:: See the rest at https://raw.githubusercontent.com/miklevin/jupyme/main/install.sh
:: but you don't have to do anything because it is downloaded and run from above.

::  _____     ____
:: |_   _|__ |  _ \  ___
::   | |/ _ \| | | |/ _ \
::   | | (_) | |_| | (_) |
::   |_|\___/|____/ \___/

:: - Provide drag-copy shortcut in repo to run server after reboot.
:: - Switch Jupyter startup method from .bash_profile to Linux service.
:: - Prevent Jupyter configuration from being wiped-out by reinstalls.
:: - Copy requirements.txt LXD-side and one-time pip install -r requirements.txt
:: - Copy apt_installs.txt LXD-side and one-time source avtivate them.