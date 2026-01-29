#!/bin/bash
set -e

echo "=== Mobile AI Repair (Universal Build) ==="

# 1. Define Paths
# Using $HOME ensures it works correctly in Termux
BUILD_DIR="$HOME/termux-ai-engine/llama.cpp"

# 2. Check source
if [ ! -d "$BUILD_DIR" ]; then
    echo "Source code missing. Re-cloning..."
    mkdir -p "$HOME/termux-ai-engine"
    cd "$HOME/termux-ai-engine"
    git clone https://github.com/ggerganov/llama.cpp
fi

# 3. Clean and Build
echo "Starting compilation..."
cd "$BUILD_DIR"
rm -rf build
mkdir build
cd build

# Standard configuration
# Removed specific target flags to allow default build of all examples/tools
cmake .. -DCMAKE_BUILD_TYPE=Release

echo "Building ALL targets (this guarantees success)..."
# Just build everything. It takes longer but is safer.
cmake --build . --config Release -j2

# 4. Find the binary
echo "Searching for built binary..."
# In newer llama.cpp, binaries are often in build/bin/
if [ -f "bin/llama-cli" ]; then
    echo "SUCCESS: Found 'llama-cli' in bin/"
elif [ -f "bin/main" ]; then
    echo "SUCCESS: Found 'main' in bin/. Creating symlink..."
    ln -sf main bin/llama-cli
elif [ -f "llama-cli" ]; then
    echo "SUCCESS: Found 'llama-cli' in build root"
elif [ -f "main" ]; then
    echo "SUCCESS: Found 'main' in build root. Creating symlink..."
    ln -sf main llama-cli
else
    echo "FAILURE: Could not find binary. Listing build directory contents:"
    ls -R
    exit 1
fi

echo "========================================"
echo "Repair Complete. Ready for BharatGPT!"
echo "========================================"