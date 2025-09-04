#!/bin/bash

# KDE Power Management Setup Script
# Configures KDE to prevent system sleep while allowing screen sleep
# Perfect for development environments with long-running processes

set -e

echo "=== KDE Power Management Setup ==="
echo "This script configures KDE Power Management to:"
echo "- Prevent system sleep/suspend"
echo "- Allow screen sleep (10min AC, 5min battery)"
echo "- Keep SSH sessions and long-running processes active"
echo ""

# Check if we're on KDE/Plasma
if ! pgrep -f plasmashell > /dev/null; then
    echo "Warning: KDE Plasma does not appear to be running."
    echo "This script is designed for KDE/Plasma desktop environments."
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
fi

# Check if kwriteconfig6 is available
if ! command -v kwriteconfig6 &> /dev/null; then
    echo "Error: kwriteconfig6 not found. Please install kde-cli-tools."
    echo "Run: sudo pacman -S kde-cli-tools"
    exit 1
fi

echo "Configuring power management profiles..."

# Configure AC power profile (when plugged in)
echo "Setting up AC power profile..."
kwriteconfig6 --file powermanagementprofilesrc --group AC --group SuspendSession --key idleTime 0
kwriteconfig6 --file powermanagementprofilesrc --group AC --group SuspendSession --key suspendType 0

# Configure Battery power profile
echo "Setting up Battery power profile..."
kwriteconfig6 --file powermanagementprofilesrc --group Battery --group SuspendSession --key idleTime 0
kwriteconfig6 --file powermanagementprofilesrc --group Battery --group SuspendSession --key suspendType 0

# Configure Low Battery power profile
echo "Setting up Low Battery power profile..."
kwriteconfig6 --file powermanagementprofilesrc --group LowBattery --group SuspendSession --key idleTime 0
kwriteconfig6 --file powermanagementprofilesrc --group LowBattery --group SuspendSession --key suspendType 0

# Configure screen sleep settings
echo "Configuring screen sleep settings..."

# AC Profile - Screen sleep after 10 minutes
kwriteconfig6 --file powermanagementprofilesrc --group AC --group DPMSControl --key idleTime 600000
kwriteconfig6 --file powermanagementprofilesrc --group AC --group DPMSControl --key lockBeforeTurnOff 0

# Battery Profile - Screen sleep after 5 minutes
kwriteconfig6 --file powermanagementprofilesrc --group Battery --group DPMSControl --key idleTime 300000
kwriteconfig6 --file powermanagementprofilesrc --group Battery --group DPMSControl --key lockBeforeTurnOff 0

# Set appropriate icons for power profiles
echo "Setting power profile icons..."
kwriteconfig6 --file powermanagementprofilesrc --group AC --key icon "battery-charging"
kwriteconfig6 --file powermanagementprofilesrc --group Battery --key icon "battery-060"
kwriteconfig6 --file powermanagementprofilesrc --group LowBattery --key icon "battery-020"

echo ""
echo "=== Power Management Configuration Applied ==="
echo "✓ System sleep: DISABLED (keeps SSH sessions active)"
echo "✓ Screen sleep: ENABLED (AC: 10min, Battery: 5min)"
echo "✓ Long-running processes will not be interrupted"
echo ""

# Restart powerdevil to apply changes
echo "Restarting KDE power management service..."
if pgrep -f powerdevil > /dev/null; then
    killall powerdevil 2>/dev/null
fi

# Start powerdevil
kstart6 powerdevil 2>/dev/null &

echo ""
echo "=== Setup Complete! ==="
echo "Your system will:"
echo "• Stay awake during development sessions"
echo "• Keep SSH connections alive"
echo "• Allow screen to sleep to save power"
echo "• Prevent interruption of long-running tasks"
echo ""
echo "To verify settings:"
echo "• System Settings → Power Management"
echo "• Or check: ~/.config/powermanagementprofilesrc"
