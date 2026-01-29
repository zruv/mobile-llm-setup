#!/bin/bash
# AI Web Server Script

BINARY="$HOME/termux-ai-engine/llama.cpp/build/bin/llama-server"
MODEL="$HOME/models/qwen2.5-1.5b-instruct-q4_k_m.gguf"

if [ ! -f "$BINARY" ]; then
    echo "Error: Server binary not found. Please finish Phase 1 (compilation) first."
    exit 1
fi

# Try to find the Phone's IP address
IP=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1 | head -n 1)

echo "-------------------------------------------------"
echo "AI Server Starting..."
echo "-------------------------------------------------"
echo "Access from your laptop:  http://$IP:8080"
echo "Access on this phone:    http://localhost:8080"
echo "-------------------------------------------------"

"$BINARY" -m "$MODEL" -c 2048 --host 0.0.0.0 --port 8080