#!/usr/bin/env bash

# Default installation directory
INSTALL_DIR="${HOME}/.local/bin"

# Function to display usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  --install-dir=DIR   Specify the directory to install scripts (default: ${HOME}/.local/bin)"
    echo "  --help              Show this help message and exit"
    exit 0
}

# Parse arguments
for arg in "$@"; do
    case $arg in
        --install-dir=*)
            INSTALL_DIR="${arg#*=}"
            shift
            ;;
        --help)
            usage
            ;;
        *)
            echo "Error: Unknown option: $arg"
            echo
            usage
            ;;
    esac
done

# Log the chosen installation directory
echo "Installation directory set to: $INSTALL_DIR"

# Create the directory if it doesn't exist
mkdir -p "$INSTALL_DIR" || {
    echo "Error: Unable to create directory $INSTALL_DIR"
    exit 1
}

# Copy all shell scripts to the target directory
SCRIPT_DIR="$(dirname "$0")"
echo "Copying scripts from $SCRIPT_DIR to $INSTALL_DIR..."
cp "$SCRIPT_DIR"/*.sh "$INSTALL_DIR" || {
    echo "Error: Failed to copy scripts to $INSTALL_DIR"
    exit 1
}

# Make the scripts executable
chmod +x "$INSTALL_DIR"/*.sh || {
    echo "Error: Failed to make scripts executable in $INSTALL_DIR"
    exit 1
}

# Success message
echo "Installation complete!"
