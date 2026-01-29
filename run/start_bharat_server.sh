#!/bin/bash
# BharatGPT Web Server

# Paths for Termux environment
BINARY="$HOME/termux-ai-engine/llama.cpp/build/bin/llama-server"
MODEL="$HOME/models/BharatGPT-3B-Indic.Q4_K_M.gguf"

# Check if binary exists (it might be named simply 'server' in some versions)
if [ ! -f "$BINARY" ]; then
    BINARY="$HOME/termux-ai-engine/llama.cpp/build/bin/server"
fi

# Fallback: Deep search for server binary if standard paths fail
if [ ! -f "$BINARY" ]; then
    SEARCH_BINARY=$(find "$HOME/termux-ai-engine" -name "llama-server" -type f | head -n 1)
    if [ -z "$SEARCH_BINARY" ]; then
        SEARCH_BINARY=$(find "$HOME/termux-ai-engine" -name "server" -type f | head -n 1)
    fi
    BINARY="$SEARCH_BINARY"
fi

if [ -z "$BINARY" ] || [ ! -f "$BINARY" ]; then
    echo "Error: Server binary not found."
    echo "Please ensure the AI engine was compiled with server support."
    echo "Tip: Run 'cmake --build $HOME/termux-ai-engine/llama.cpp/build --target llama-server' if missing."
    exit 1
fi

# Try to find the Phone's IP address
IP=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -n 1)

echo "-------------------------------------------------"
echo "BharatGPT Server Starting..."
echo "-------------------------------------------------"
echo "Access from your laptop:  http://$IP:8080"
echo "Access on this phone:    http://localhost:8080"
echo "-------------------------------------------------"

# Resolve the web directory relative to this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR="$SCRIPT_DIR/../web"

"$BINARY" -m "$MODEL" -c 4096 --host 0.0.0.0 --port 8080 --path "$WEB_DIR"
