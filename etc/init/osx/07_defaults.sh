#!/bin/bash

###########################################################
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi
###########################################################

set_dashboard() {
	# disable dashboard
	defaults write com.apple.dashboard mcx-disabled -bool true
}

set_dock() {
	# Enable autohide
	defaults write com.apple.dock autohide -bool true
	
	# Speed up Mission Control animations
	defaults write com.apple.dock expose-animation-duration -float 0.2

	# Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale"

    # Reduce Dock clutter by minimizing windows into their application icons
    defaults write com.apple.dock minimize-to-application -bool true

    # Don't automatically rearrange spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Wipe all app icons from the Dock
    defaults write com.apple.dock persistent-apps -array

    # Show indicator lights for open applications
    defaults write com.apple.dock show-process-indicators -bool true

    # Make icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # Set the icon size
    defaults write com.apple.dock tilesize -int 50
}

set_finder() {
	# Always show scrollbars
    defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

    # Add 'Quit' to Fider menu
    defaults write com.apple.finder QuitMenuItem -bool true

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # Set `${HOME}` as the default location for new Finder windows
	defaults write com.apple.finder NewWindowTarget -string "PfDe"
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

	# Show Status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool true

	# Show Status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool true

	# Show Path bar in Finder
	defaults write com.apple.finder ShowPathbar -bool true

	# Show Tab bar in Finder
	defaults write com.apple.finder ShowTabView -bool true

	# Show the ~/Library directory
	chflags nohidden ~/Library
}

set_trackpad() {
	# Enable "Tap to click"
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
}

set_ui() {
	# Avoid creating `.DS_Store` files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Hide the battery percentage from the menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "NO"

    # Disable the "Are you sure you want to open this application?" dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Save screencapture to
    defaults write com.apple.screencapture location "$HOME/Desktop"

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Save screenshots to the ~/Desktop
    defaults write com.apple.screencapture location -string "$HOME/Desktop"

    # Save screenshots as PNGs
    defaults write com.apple.screencapture type -string "png"

    # Enable subpixel font rendering on non-Apple LCDs
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    # Require password immediately after the computer went into
    # sleep or screen saver mode
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Set computer name
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Laptop"
    sudo scutil --set ComputerName "Laptop"
    sudo scutil --set HostName "Laptop"
    sudo scutil --set LocalHostName "Laptop"

    # Disable Resume system-wide
	defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false


	# Increase window resize speed for Cocoa applications
	defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
}

set_spotlight() {
    # Hide Spotlight tray-icon (and subsequent helper)
    #sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
    # Disable Spotlight indexing for any volume that gets mounted and has not yet
    # been indexed before.
    # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
    sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
    # Change indexing order and disable some search results
    # Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
    # 	MENU_DEFINITION
    # 	MENU_CONVERSION
    # 	MENU_EXPRESSION
    # 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
    # 	MENU_WEBSEARCH             (send search queries to Apple)
    # 	MENU_OTHER
    defaults write com.apple.spotlight orderedItems -array \
        '{"enabled" = 1;"name" = "APPLICATIONS";}' \
        '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
        '{"enabled" = 1;"name" = "DIRECTORIES";}' \
        '{"enabled" = 1;"name" = "PDF";}' \
        '{"enabled" = 1;"name" = "FONTS";}' \
        '{"enabled" = 0;"name" = "DOCUMENTS";}' \
        '{"enabled" = 0;"name" = "MESSAGES";}' \
        '{"enabled" = 0;"name" = "CONTACT";}' \
        '{"enabled" = 0;"name" = "EVENT_TODO";}' \
        '{"enabled" = 0;"name" = "IMAGES";}' \
        '{"enabled" = 0;"name" = "BOOKMARKS";}' \
        '{"enabled" = 0;"name" = "MUSIC";}' \
        '{"enabled" = 0;"name" = "MOVIES";}' \
        '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
        '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
        '{"enabled" = 0;"name" = "SOURCE";}' \
        '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
        '{"enabled" = 0;"name" = "MENU_OTHER";}' \
        '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
        '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
        '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
        '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
    # Load new settings before rebuilding the index
    killall mds > /dev/null 2>&1
    # Make sure indexing is enabled for the main volume
    sudo mdutil -i on / > /dev/null
    # Rebuild the index from scratch
    sudo mdutil -E / > /dev/null
}

set_terminal() {
	# Use a modified version of the Solarized Dark theme by default in Terminal.app
	TERM_PROFILE='./etc/config/Solarized_Dark.terminal';
    CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
    if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
        open "$TERM_PROFILE"
        defaults write com.apple.Terminal "Default Window Settings" -string "$TERM_PROFILE"
        defaults write com.apple.Terminal "Startup Window Settings" -string "$TERM_PROFILE"
    fi
    defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"
    # Only use UTF-8 in Terminal.app
    defaults write com.apple.terminal StringEncodings -array 4
}

osascript -e 'display notification "Request Password on Terminal" with title "osx-provisioning"'
sudo -v

# TASK
set_dashboard
set_dock
set_finder
set_trackpad
set_spotlight
set_terminal

killall Dock
killall Finder
killall SystemUIServer
killall cfprefsd