@echo off
setlocal enableDelayedExpansion
set /a "COUNTER+=1"
set "URL=https://raw.githubusercontent.com/miklevin/drinkme/main/install.bat?cache=!COUNTER!"
set "FILENAME=install.bat"
curl -s -o "%FILENAME%" "%URL%" -H "Cache-Control: no-cache, no-store, must-revalidate" -H "Pragma: no-cache" -H "Expires: 0" --proxy-header "Cache-Control: no-cache" --proxy-header "Cache-Control: no-store"