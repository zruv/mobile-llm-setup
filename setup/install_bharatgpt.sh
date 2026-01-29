#!/bin/bash
set -e

# Configuration
MODEL_NAME="BharatGPT-3B-Indic.Q4_K_M.gguf"
MODEL_URL="https://huggingface.co/QuantFactory/BharatGPT-3B-Indic-GGUF/resolve/main/BharatGPT-3B-Indic.Q4_K_M.gguf"
MODEL_PATH="$HOME/models/$MODEL_NAME"
SEARCH_DIR="$HOME/termux-ai-engine"

echo "=== BharatGPT Setup ==="

# 1. Find AI Engine
echo "Searching for engine..."
if [ -f "$SEARCH_DIR/llama.cpp/build/bin/llama-cli" ]; then
    BINARY="$SEARCH_DIR/llama.cpp/build/bin/llama-cli"
elif [ -f "$SEARCH_DIR/llama.cpp/build/bin/main" ]; then
    BINARY="$SEARCH_DIR/llama.cpp/build/bin/main"
else
    BINARY=$(find "$SEARCH_DIR" -name "llama-cli" -type f | head -n 1)
    if [ -z "$BINARY" ]; then
        BINARY=$(find "$SEARCH_DIR" -name "main" -type f | head -n 1)
    fi
fi

if [ -z "$BINARY" ]; then
    echo "Error: Engine not found. Run repair_install.sh"
    exit 1
fi

echo "Engine: $BINARY"

# 2. Download
mkdir -p "$HOME/models"
if [ ! -f "$MODEL_PATH" ]; then
    echo "Downloading model..."
    curl -L -o "$MODEL_PATH" "$MODEL_URL"
else
    echo "Model exists."
fi

# 3. Create Launcher (Safe Method)
echo "Creating chat_bharat.sh..."

echo "#!/bin/bash" > chat_bharat.sh
echo "BINARY=\"$BINARY\"" >> chat_bharat.sh
echo "MODEL=\"$MODEL_PATH\"" >> chat_bharat.sh
echo "" >> chat_bharat.sh
echo "echo \"Starting BharatGPT...\"" >> chat_bharat.sh
echo "echo \"Languages: Hindi, Tamil, Telugu, Kannada, Malayalam, English\"" >> chat_bharat.sh
# Use the actual variable holding the path, which is $MODEL_PATH in this script
echo "\"$BINARY\" -m \"$MODEL_PATH\" \\" >> chat_bharat.sh
echo "  -p \"You are a helpful assistant fluent in Indian languages and English.\" \\" >> chat_bharat.sh
echo "  -cnv \\" >> chat_bharat.sh
echo "  -c 4096 \\" >> chat_bharat.sh
echo "  --temp 0.7 \\" >> chat_bharat.sh
echo "  --threads 6" >> chat_bharat.sh

chmod +x chat_bharat.sh

echo "Done! Run: ./chat_bharat.sh"
