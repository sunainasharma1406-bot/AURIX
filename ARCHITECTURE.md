# v6 module map
- `aurix/common.py` settings, helpers, SQLite memory store
- `aurix/workers.py` QThread workers (diagnostics, chat streaming, planner, search, vision, voice-in, wake word, updates)
- `aurix/blob.py` NeuralBlob renderer, HoloCore stage, FloatingOrb, Toast
- `aurix/speech.py` live TTS engine (persistent PowerShell + System.Speech)
- `aurix/proactive.py` weather / news / health / wellness / briefing scheduler
- `aurix/ui_build.py` layout + stylesheet; `aurix/assistant.py` chat flow, speech, orb/tray, proactive wiring
- `aurix/window.py` main window glue; `aurix/app.py` entry point

# AURIX 0.4 architecture

## Runtime
- Windows 11 desktop UI: PySide6 / Qt Widgets.
- Main local model: OpenAI-compatible local API, default `http://127.0.0.1:8080/v1` (llamafile).
- Optional local visual model: OpenAI-compatible API, default `http://127.0.0.1:8081/v1`. It is not required to use chat, voice, memory, or web research.
- Local history and manually approved long-term memory: SQLite under `%LOCALAPPDATA%\AURIX`.
- Offline voice input: Vosk + sounddevice. Audio is captured only for a user-triggered short dictation or while the wake-word switch is explicitly enabled.
- Wake word: openWakeWord + a user-selected ONNX model. No wake model is bundled. The microphone stays active only while this feature is enabled.
- Offline voice output: pyttsx3 using Windows SAPI5 voices.
- Web search: DuckDuckGo HTML search via HTTPS. Search query text is sent to DuckDuckGo; chats and screenshots are not attached.

## Trust boundaries
- The chat model does not have direct computer access.
- The action planner can return only a small JSON allow-list: public web search, opening an HTTP(S) link, or launching Calculator / Notepad / Paint.
- Every proposed action is shown to the user and approved individually. The app does not run arbitrary shell commands, scripts, PowerShell, administrator operations, or model-generated code.
- Screenshots/images are previewed first and sent only to a configured loopback visual API after the user selects **Analyze locally**.
- No automatic cloud route is enabled. Any configured cloud fallback requires a separate confirmation before message/context transmission.
- Long-term memory is opt-in and manually saved/deleted by the user. It is inserted only into local-model context.
- Update ZIPs require HTTPS + SHA-256 matching and are extracted to a staging folder. The app does not execute an installer or overwrite its running files. SHA-256 checks integrity against the manifest; it is not a publisher signature.

## Data locations
- Settings: `%LOCALAPPDATA%\AURIX\settings.json`
- SQLite history and saved memories: `%LOCALAPPDATA%\AURIX\aurix_memory.sqlite3`
- Captured screenshots: `%LOCALAPPDATA%\AURIX\captures`
- Downloaded update staging: `%LOCALAPPDATA%\AURIX\update_staging`
