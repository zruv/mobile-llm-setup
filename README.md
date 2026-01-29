# Mobile AI Setup Guide: Qwen, BharatGPT & More

This guide explains how to run powerful, multilingual Large Language Models (LLM) locally on an Android phone using Termux.

## 📱 Hardware Requirements
- **RAM:** 
    - 4GB: Optimized for Qwen 1.5B, Llama 3.2 1B.
    - 8GB: Recommended for **BharatGPT 3B**, Gemma 2 2B.
- **Storage:** ~3GB free per model
- **OS:** Android with Termux installed

## 📁 Files in this Setup
1. `setup/setup_mobile_ai.sh`: The main installer. Compiles the AI engine.
2. `setup/install_bharatgpt.sh`: Specific installer for the BharatGPT model.
3. `run/chat_bharat.sh`: Terminal chat for BharatGPT (Multilingual support).
4. `run/start_bharat_server.sh`: Launches BharatGPT as a web server with a custom UI.
5. `web/index.html`: The web interface used by the server.
6. `setup/repair_install.sh`: Use this if the AI engine fails to compile.

## 🚀 How to Start BharatGPT

### 1. Terminal Chat
Run the installer first, then the chat script:
```bash
bash setup/install_bharatgpt.sh
# Note: The installer creates the chat script in your current directory.
# Move it to run/ for cleanliness if desired, or run it directly:
./chat_bharat.sh
```

### 2. Web Server Mode (Beautiful UI)
This allows you to chat via a professional web interface on your laptop.
```bash
bash run/start_bharat_server.sh
```
- **On Phone:** http://localhost:8080
- **On Laptop:** Access the IP shown in the terminal (e.g., `http://192.168.1.5:8080`).

---

## 🇮🇳 Why BharatGPT?
BharatGPT is optimized for Indian context and supports multiple languages including:
- Hindi, Tamil, Telugu, Kannada, Malayalam, Marathi, Gujarati, Bengali, Punjabi, and more!

---

## 🧠 Other Models (4GB RAM Compatible)
Your phone can run other AI brains!

### 1. DeepSeek-R1-Distill-Qwen-1.5B (The "Thinking" Model)
*Best for: Logic, Math, Coding.*
```bash
curl -L -o $HOME/models/deepseek-r1-1.5b.gguf https://huggingface.co/unsloth/DeepSeek-R1-Distill-Qwen-1.5B-GGUF/resolve/main/DeepSeek-R1-Distill-Qwen-1.5B-Q4_K_M.gguf
```

### 2. Google Gemma 2 (2B)
*Best for: Creative writing and General Knowledge.*
```bash
curl -L -o $HOME/models/gemma2-2b.gguf https://huggingface.co/bartowski/gemma-2-2b-it-GGUF/resolve/main/gemma-2-2b-it-Q4_K_M.gguf
```

### 3. Llama 3.2 (1B)
*Best for: Speed and Battery Life.*
```bash
curl -L -o $HOME/models/llama3.2-1b.gguf https://huggingface.co/hugging-quants/Llama-3.2-1B-Instruct-Q4_K_M-GGUF/resolve/main/llama-3.2-1b-instruct-q4_k_m.gguf
```

---

## 🔄 How to Switch Models
To use a different model, edit your script (e.g., `run/chat.sh` or `run/start_bharat_server.sh`):
1.  Open the file: `nano run/chat_bharat.sh`
2.  Update the `MODEL=` path to point to your new `.gguf` file.
3.  Save (Ctrl+O, Enter) and Exit (Ctrl+X).

## 💡 Troubleshooting
- **"Server binary not found":** Run `bash setup/repair_install.sh` to re-compile the engine.
- **Web UI is blank:** Ensure `web/index.html` exists.
- **Phone Hot / Slow:** Use **Llama 3.2 1B** for the best battery life.
- **Wake Lock:** In Termux notifications, tap "Acquire Wake Lock" so the server doesn't stop when you turn off the screen.
