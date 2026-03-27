---
name: genspark
description: Automate GenSpark AI Workspace tasks via agent-browser. Use for AI Slides, AI Docs, AI Sheets, AI Chat, AI Designer, AI Image, or any GenSpark tool. Triggers on "genspark", "create slides", "genspark presentation", "AI slides", "genspark docs". Also use to check GenSpark credit/token usage.
---

# GenSpark — AI Workspace Automation

## Prerequisites
- `agent-browser` CLI installed and working
- Browser profile with GenSpark login at: `/Users/davinci/.openclaw/workspace/browser-profiles/meta`
- GenSpark account (free or Pro)

## Quick Start

```bash
# Open GenSpark with saved profile (GUI mode for login)
agent-browser open "https://www.genspark.ai/" --profile /Users/davinci/.openclaw/workspace/browser-profiles/meta --headed

# If already running, just navigate
agent-browser open "https://www.genspark.ai/"
```

## Token/Credit Tracking

Before and after any GenSpark task, check credits:

```bash
# Navigate to account/credits page
agent-browser open "https://www.genspark.ai/"
agent-browser eval "document.body.innerText.split('\\n').filter(l => l.match(/credit|token|usage|plan|remaining|quota/i)).join('\\n')"
```

Record before/after values to track consumption per task.

## Available Tools

| Tool | Trigger via prompt bar | Use case |
|------|----------------------|----------|
| AI Slides | "Create slides about..." | Presentations |
| AI Docs | "Create a document about..." | Documents |
| AI Sheets | "Create a spreadsheet..." | Data/tables |
| AI Designer | "Design a..." | Graphics |
| AI Chat | Direct questions | Q&A |
| AI Image | "Generate an image of..." | Image generation |
| AI Music | "Create music..." | Audio |
| AI Video | "Create a video..." | Video |

## Core Workflow

### 1. Open & Authenticate
```bash
agent-browser close  # Kill any stale session
agent-browser open "https://www.genspark.ai/" --profile /Users/davinci/.openclaw/workspace/browser-profiles/meta --headed
```

If Cloudflare challenge appears, ask user to click "Verify you are human" in the browser window.

### 2. Submit Prompt
```bash
agent-browser snapshot -i  # Find the search box ref
agent-browser fill @e<N> "Your prompt here"
agent-browser press Enter
```

The search box is labeled "Ask anything, create anything".

### 3. Wait for Generation
GenSpark Super Agent processes requests in stages:
- **Thinking** (10-30s) — researching and planning
- **Creating** (30-120s) — generating content, may show "Tasks Remaining" counter
- **Preview** — final result displayed

Poll with screenshots every 30-60s. Do not navigate away during generation.

```bash
sleep 30 && agent-browser screenshot /tmp/genspark-progress.png
```

### 4. Edit/Refine
Use the chat input to request changes:
```bash
agent-browser snapshot -i  # Find chat input ref
agent-browser fill @e<N> "Make the text on slide 2 larger"
agent-browser press Enter
```

Note: Edits may regenerate the entire artifact. Wait for completion.

### 5. Download/Export
Look for download buttons in the UI after generation completes.

## Common Issues

| Issue | Fix |
|-------|-----|
| Cloudflare challenge | Ask user to click verify in GUI browser |
| Browser session conflicts | `agent-browser close` then reopen with profile |
| 3pm cron kills browser | Cron scrape shares the meta profile — avoid overlap |
| Generation stalls | Wait 3+ min, then retry. Check for "network error" banner |
| Empty/black screen | Page navigated to about:blank — reopen GenSpark URL |

## Cron Conflict Warning
The SNS scraper cron (10:00 and 15:00 JST) uses the same `meta` browser profile. If running GenSpark during these times, the scraper will close the browser. Either:
- Pause the cron before using GenSpark
- Use GenSpark outside cron windows
