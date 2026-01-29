#!/bin/bash
# Fixed chat script for llama-simple-chat

# Paths
BINARY="$HOME/termux-ai-engine/llama.cpp/build/bin/llama-simple-chat"
MODEL="$HOME/models/qwen2.5-1.5b-instruct-q4_k_m.gguf"

if [ ! -f "$BINARY" ]; then
    echo "Error: AI engine not found at $BINARY"
    exit 1
fi

if [ ! -f "$MODEL" ]; then
    echo "Error: Model not found at $MODEL"
    exit 1
fi

echo "Starting Simple Chat..."
"$BINARY" -m "$MODEL" -c 2048
