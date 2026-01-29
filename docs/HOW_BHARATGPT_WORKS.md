# How BharatGPT Runs on Termux: A Technical Breakdown

This document explains the technical architecture and steps that enable running a 3-billion parameter Large Language Model (LLM) locally on an Android device.

## Core Technologies
The setup relies on two pillars of modern edge computing:
1. **llama.cpp**: A C++ implementation of LLM inference designed for high performance on standard CPUs (especially ARM).
2. **GGUF Quantization**: A format that compresses model weights to reduce RAM and storage requirements.

---

## Step-by-Step Architecture

### 1. Environment & Tools
**Termux** acts as a bridge, providing a Linux environment within Android. It allows the installation of development tools (`build-essential`, `cmake`, `git`) needed to compile software for the phone's ARM-based processor.

### 2. The Engine: Compiling llama.cpp
Instead of using a generic application, the engine is compiled from source on the device itself.
- **Optimization**: Compiling locally allows `cmake` to detect and use specific hardware instructions (like ARM NEON) present in the phone's CPU.
- **Binary Generation**: This process produces executable files like `llama-cli` (for terminal chat) and `llama-server` (for web interfaces).

### 3. The Brain: BharatGPT GGUF (Quantization)
A raw 3B parameter model usually requires ~6GB of VRAM/RAM. Most phones cannot handle this.
- **Quantization (Q4_K_M)**: This process reduces the precision of the model's weights from 16-bit to 4-bit.
- **Efficiency**: The model size drops from ~6GB to ~2.2GB. This allows the model to fit into the system RAM of a 4GB or 8GB device while maintaining acceptable intelligence levels.

### 4. Memory Management & Inference
The scripts (`chat_bharat.sh` or `start_bharat_server.sh`) manage how the CPU interacts with the model:
- **Threads**: Uses multiple CPU cores (`--threads 4` or `6`) to speed up text generation.
- **Context Window**: Allocates a specific amount of RAM for the model to "remember" the current conversation (e.g., 2048 or 4096 tokens).

### 5. The User Interface
- **CLI Mode**: Direct interaction via the Termux terminal using the `llama-cli` binary.
- **Server Mode**: The `llama-server` binary creates a local web server (port 8080). This allows the custom `index.html` or `client.html` to provide a "ChatGPT-like" experience through a mobile browser or a laptop on the same Wi-Fi network.

---

## Summary
By shrinking the "brain" via **Quantization** and optimizing the "engine" via **llama.cpp**, BharatGPT can run entirely offline, without sending any data to the cloud, using only the hardware inside your pocket.
