#!/bin/bash
# Advanced chat using llama-completion for Termux

# Paths
BINARY="$HOME/termux-ai-engine/llama.cpp/build/bin/llama-completion"
MODEL="$HOME/models/qwen2.5-1.5b-instruct-q4_k_m.gguf"

# Check if binary exists
if [ ! -f "$BINARY" ]; then
    echo "Error: Advanced AI engine not found at $BINARY"
    exit 1
fi

if [ ! -f "$MODEL" ]; then
    echo "Error: Model not found at $MODEL"
    exit 1
fi

echo "Starting Advanced AI Chat..."
echo "--------------------------------"
echo "System: You are now in advanced mode."
echo "Type your message and press Enter."
echo "Press Ctrl+C to exit."
echo "--------------------------------"

# Updated to use -sys for the system prompt as seen in your help output
"$BINARY" -m "$MODEL" \
  -sys "You are a helpful, professional, and concise assistant." \
  -c 2048 \
  --temp 0.7 \
  -cnv
