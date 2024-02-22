#!/usr/bin/env fish

# Parse command-line arguments using argparse
argparse --name=code 'h/help' 'n/name=' -- $argv

# Check if the help option is provided
if test -n "$_flag_h" -o -n "$_flag_help"
    echo "Usage: code.fish [-n/--name <name>]"
    echo "Windows: cli_win32_x64_cli [Default]"
    echo "Linux: cli-alpine-x64"
    echo "Mac (Intel): cli_darwin_x64_cli"
    echo "Mac (Apple): cli_darwin_arm64_cli"
    exit 0
end

# Check if the name option is provided
if test -n "$_flag_n" -o -n "$_flag_name"
    set name $_flag_n
else
    set name "cli-alpine-x64"  # Default value
end

# Download Visual Studio Code CLI
set vscode_archive "vscode_cli.tar.gz"
set vscode_download_url "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64"

echo "Downloading Visual Studio Code CLI..."
curl -Lk "$vscode_download_url" --output "$vscode_archive"

# Check if download was successful
if test $status -ne 0
    echo "Failed to download Visual Studio Code CLI."
    exit 1
end

# Extract the archive
echo "Extracting Visual Studio Code CLI..."
tar -xzvf "$vscode_archive"

# Delete the archive file
echo "Cleaning up..."
rm -f "$vscode_archive"

echo "Downloaded and Extacted, $name!"
