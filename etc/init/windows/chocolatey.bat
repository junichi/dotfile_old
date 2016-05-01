@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
xcopy H:\dotfiles\etc\init\windows\chocolaty\packages.config %homepath%\inst\
cinst %homepath%\inst\packages.config -y
rd /s /q %homepath%\inst