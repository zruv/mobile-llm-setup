#!/bin/bash
set -e

# Configuration for 4GB RAM Device
MODEL_FILE="qwen2.5-1.5b-instruct-q4_k_m.gguf"
MODEL_URL="https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct-GGUF/resolve/main/qwen2.5-1.5b-instruct-q4_k_m.gguf"
BUILD_DIR="$HOME/termux-ai-engine"

echo "=== Mobile AI Setup (4GB RAM Optimized) ==="

# 1. Install Dependencies
echo "[1/4] Installing dependencies..."
pkg update -y && pkg upgrade -y
pkg install git build-essential cmake curl -y

# 2. Compile AI Engine
echo "[2/4] Compiling AI Engine..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

if [ ! -d "llama.cpp" ]; then
    git clone https://github.com/ggerganov/llama.cpp
fi

cd llama.cpp
rm -rf build
cmake -B build -DGGML_MINIAUDIO=OFF -DLLAMA_BUILD_TESTS=OFF -DLLAMA_BUILD_SERVER=OFF
cmake --build build --config Release -j4

# 3. Download Model
echo "[3/4] Downloading AI Model (1.5B)..."
mkdir -p "$HOME/models"
cd "$HOME/models" # Download to models directory
if [ -f "$MODEL_FILE" ]; then
    echo "Model already exists. Skipping."
else
    curl -L -o "$MODEL_FILE" "$MODEL_URL"
fi

# 4. Create Chat Script
echo "[4/4] Creating 'chat.sh'..."
BINARY_PATH="$BUILD_DIR/llama.cpp/build/bin/llama-cli"

cat > chat.sh <<EOF
#!/bin/bash
echo "Starting AI Chat..."
"$BINARY_PATH" -m "$HOME/models/$MODEL_FILE" -p "You are a helpful assistant." -cnv -c 2048 --threads 4
EOF
chmod +x chat.sh

echo "========================================"
echo "Setup Complete!"
echo "To start chatting, run: ./chat.sh"
echo "========================================"
