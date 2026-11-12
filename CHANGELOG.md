# 6.0.0
- Restructured into a package: common / workers / dialogs / blob / speech / proactive / ui_build / assistant / window / app.
- Neural network is now the blob itself: neurons on a morphing sphere, signals ripple along the wires, and feature satellites
  (CHAT WEB MEMORY VISION VOICE ACTION WEATHER NEWS HEALTH) are tethered to the core. The blob now fills the whole window.
- Floating orb + tray icon when the window is closed or minimised; alerts pop up as toasts next to it.
- Live text-to-speech rewritten (Windows System.Speech via a persistent process): speaks sentence by sentence while the model streams,
  skips code and sources, Stop button cancels instantly. Test with the speaker button.
- Proactive mode: spoken briefing, weather + air quality (Open-Meteo), live headlines + new-headline alerts (Google News RSS),
  PC health (CPU/RAM/disk/battery), wellness reminders, quiet hours. FEED tab keeps everything.
- STOP button while generating; optional auto-send for voice dictation; Assistant settings dialog.
- Fixes carried from 0.5: session titles, empty-session pile-up, log spam, voice stop, threads on exit.

# 0.5.0
- New UI: animated particle-mesh globe stage, glass cards, restyled chat panel.
- Neural router: signals light up CHAT / WEB / MEMORY / VISION / VOICE / ACTION as each feature is used.
- Chat web search: start a message with `search ...` (or use the Web button / Ctrl+K). AURIX fetches DuckDuckGo results, gives them to the local model, and lists clickable sources.
- Streaming replies, Markdown rendering (bold, lists, code), `<think>` blocks hidden.
- Clickable start tiles; right-click a session to delete it; Ctrl+N new session.
- Fixes: session titles overwritten on every message; empty "New conversation" pile-up; activity-log spam and status flicker from background polling; Stop button for voice input; mic hand-off from wake word; threads now stop cleanly on exit; SQLite connections closed; literal `\n` in update dialog.

# Changelog

## 0.4.0
- Refreshed the dark command-cockpit styling and expanded the workspace.
- Added opt-in offline Vosk speech input with transcript review before sending.
- Added offline Windows SAPI speech output.
- Added optional openWakeWord ONNX listener, disabled by default and visibly controlled.
- Added manually curated local memory in SQLite and local-only retrieval context.
- Added update checking, HTTPS ZIP download, SHA-256 comparison, archive testing, and staging for manual review.
- Retained local llamafile chat, web research, local screenshot analysis, and approval-gated allow-listed actions.
- Kept LFM Omni optional and unstarted.
