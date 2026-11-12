# AURIX v6

Run `start_aurix.bat` (creates a venv, installs requirements, launches `main.py`).

**New in v6:** neural-blob core, floating orb, live voice, proactive briefings (weather / news / health), Stop button.
Open **Assistant** in the left rail to set your name, city, quiet hours and which proactive features are on.
Closing the window sends AURIX to the floating orb; use the orb menu, the tray icon, or **Quit AURIX** to exit.

Network use is explicit: the local model never leaves your PC. Weather (Open-Meteo), headlines (Google News RSS) and web search
(DuckDuckGo, only when a message starts with *search*) are the only outgoing calls, and weather/news can be switched off.

---

# AURIX 0.4 — Personal Intelligence Desktop

A local-first Windows 11 assistant with an improved three-panel command cockpit, offline voice input/output, explicit wake-word mode, local memory, web research, screenshot analysis through an optional local vision endpoint, individually approved desktop actions, and a staged update manager.

## What is included

| Feature | Status in 0.4 |
|---|---|
| Chat with local llamafile | Included; default `127.0.0.1:8080/v1` |
| Offline speech-to-text | Included through optional Vosk + sounddevice components |
| Offline spoken replies | Included through optional pyttsx3 / Windows SAPI5 |
| Wake-word listener | Included; opt-in and requires an ONNX model file |
| Local long-term memory | Included; manual save/delete only |
| Web research | Included; DuckDuckGo query and source list, links opened manually |
| Screenshot/image understanding | Included; requires a compatible local multimodal API, such as the separate service you plan to test later |
| Supervised desktop actions | Included; tiny allow-list and approval per action |
| Update manager | Included; needs a release manifest URL; download is staged for manual review |
| LFM Omni | Optional and not started or required by this release |

## 1. Requirements

- Windows 11 64-bit.
- Python 3.11 or newer (Python 3.11 is a good compatibility target).
- Your existing local llamafile server running on `http://127.0.0.1:8080`.
- 16 GB RAM is workable for the UI + local model, but running more than one model server at the same time can increase memory pressure.

## 2. Start AURIX

1. Extract the ZIP to a normal folder, for example `C:\AURIX`.
2. Start your llamafile server as usual.
3. Double-click `start_aurix.bat`.
4. AURIX creates `.venv`, installs core dependencies once, then starts the app.
5. Press **SYNC** to read the exact loaded model ID from `/v1/models`.

The main server address in AURIX settings is the API base URL, including `/v1`:

```text
http://127.0.0.1:8080/v1
```

The root URL `http://127.0.0.1:8080` is the llamafile web interface; it is not the API base URL.

## 3. Enable offline voice input/output

Voice libraries are optional so the core app stays lighter. To install them:

1. Double-click `install_voice_features.bat`.
2. Right-click `download_voice_model.ps1` and choose **Run with PowerShell**, or run it from PowerShell in this folder:

```powershell
./download_voice_model.ps1
```

Or right-click `download_voice_model.ps1` and choose **Run with PowerShell**. This downloads the Vosk small English model (~40 MB) to:

```text
%LOCALAPPDATA%\AURIX\vosk-model-small-en-us-0.15
```

That model is English-focused. Recognition of Hindi / Hinglish may be uneven. Voice dictation is short, local, and manual: press **VOICE INPUT**, speak, review the text in the composer, then press **SEND** yourself. AURIX does not automatically execute voice transcripts.

Speech output uses the Windows SAPI5 voice available on the PC. Turn **Speak replies** on or off beside the composer. It does not use an online TTS service.

## 4. Optional wake word

Wake-word mode is **off by default**. It requires `install_voice_features.bat` and a compatible ONNX wake-word model. Download a model from the official openWakeWord model library and select the `.onnx` file in **Configuration → Wake-word ONNX model file**. Then enable **WAKE WORD** in the toolbar.

The microphone remains open locally only while the wake-word switch is on. Turn it off to release the microphone. The included Vosk English model handles the command after the wake phrase. The app does not bundle a wake-word model or claim to provide a custom “Hey AURIX” model.

References:
- Vosk model catalogue: https://alphacephei.com/vosk/models
- openWakeWord project and model usage: https://github.com/dscripka/openWakeWord
- Example “Hey Jarvis” ONNX model listing: https://openwakeword.com/library/4365

## 5. Local memory

Open **Memory vault** in the left sidebar. Add only information you deliberately want saved. These entries remain in the local SQLite database and are included as context only for local model chats. They are not automatically uploaded to any cloud endpoint. Delete individual entries at any time.

This is retrieval memory, not model-weight training. AURIX does not silently retrain LFM2. The SQLite database is local but not encrypted, so do not save passwords, private keys or highly sensitive information in it.

## 6. Web research and screenshot analysis

- **WEB RESEARCH** sends the query text to DuckDuckGo over HTTPS and shows a list of sources. AURIX does not attach chat history or screenshots to a web search. You choose which result to open.
- **CAPTURE SCREEN** stores a screenshot in `%LOCALAPPDATA%\AURIX\captures`.
- **ANALYZE IMAGE** lets you select an image or screenshot, preview it, then explicitly send it to the configured local vision API. The default endpoint is `http://127.0.0.1:8081/v1`, but it may be offline until you start your optional multimodal server. Images are rejected if the endpoint is not loopback.

## 7. Supervised desktop actions

Type an instruction and press **PLAN ACTION**. The local model can propose only:
- Search the public web.
- Open an HTTP(S) URL in your default browser.
- Launch Calculator, Notepad, or Paint.

Each action has its own **APPROVE** and **REJECT** controls. Closing the queue executes nothing. No free-form shell, PowerShell, administrator command, arbitrary program path, file deletion, bulk file modification, purchases, or messaging is supported.

## 8. Update manager

The update manager is ready for a release feed, but this standalone package does not have a publisher URL configured. To use it, host an HTTPS JSON manifest and set its URL in **Configuration → Update manifest HTTPS URL**.

Manifest example (`release_manifest.example.json`):

```json
{
  "version": "0.4.1",
  "zip_url": "https://YOUR-HTTPS-HOST.example/AURIX_0.4.1_Windows11.zip",
  "sha256": "REPLACE_WITH_THE_64_CHARACTER_SHA256_OF_THE_ZIP"
}
```

AURIX checks the version, downloads the ZIP, compares its SHA-256 digest, tests the archive and extracts it to `%LOCALAPPDATA%\AURIX\update_staging`. It never silently replaces its own files or launches the new code. **SHA-256 verifies archive integrity against the manifest; it is not a digital publisher signature.** Review updates with a trusted adult before replacing the running application.

## 9. LFM Omni later

LFM Omni is not required for 0.4 and is not automatically started. Keep your current LFM2/llamafile server on port 8080. When you are ready to test a compatible multimodal server, configure its localhost API endpoint under **Local vision API base URL**. Do not point this field at a cloud URL.

## 10. Troubleshooting

- **Local AI offline:** confirm llamafile is running and check `http://127.0.0.1:8080/v1/models`.
- **Voice input unavailable:** run `install_voice_features.bat`, then `download_voice_model.ps1`; verify the Vosk model folder in Configuration.
- **Microphone error:** check Windows Settings → Privacy & security → Microphone and the selected input device.
- **Wake word fails:** verify an ONNX model path is selected and that optional voice packages installed correctly. Disable the switch to release the microphone.
- **No voice output:** check `install_voice_features.bat` and that Windows has an SAPI5 voice installed.
- **Screenshot analysis unavailable:** expected until a compatible local multimodal endpoint is running. Chat, memory and voice do not depend on it.

## Privacy defaults

- Main model stays on localhost.
- Voice processing is local and user-triggered, except during explicitly enabled wake-word listening.
- Cloud fallback is disabled by default and requires a separate confirmation if configured.
- Memory is manual and local.
- Search sends only its query.
- Screenshots are previewed and sent only to a loopback visual endpoint after approval.
- Desktop actions are allow-listed and approved individually.
