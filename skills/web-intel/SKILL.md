---
name: web-intel
description: Smart web tool router — automatically picks the best tool for any web task. Use FIRST for any web interaction, research, scraping, or browsing need. Routes to web_fetch, agent-browser, SearXNG, or OpenClaw browser based on the task.
---

# Web Intelligence — Tool Router

**Read this BEFORE using any web tool.** Pick the right one for the job.

## Decision Tree

```
What do you need to do?
│
├─ SEARCH for information?
│  └─ SearXNG (fastest, aggregates Google+Bing+DDG)
│     curl "${SEARXNG_URL:-http://localhost:8890}/search?q=QUERY&format=json"
│
├─ READ a page (get text/content)?
│  └─ web_fetch (zero setup, fast, markdown output)
│     web_fetch(url, extractMode="markdown")
│
├─ INTERACT with a page (click, fill, navigate)?
│  └─ agent-browser (CLI, fast, ref-based interaction)
│     agent-browser open URL → snapshot → click/fill → get text
│
├─ SCREENSHOT or visual inspection?
│  └─ agent-browser (built-in screenshot)
│     agent-browser open URL → screenshot page.png
│
├─ JAVASCRIPT-HEAVY SPA (React, Vue, etc)?
│  └─ agent-browser (renders JS, full browser)
│     agent-browser open URL → wait → snapshot
│
└─ COMPLEX MULTI-TAB or long session?
   └─ OpenClaw browser tool (persistent tabs, managed sessions)
      browser(action="open", url=URL) → snapshot → act
```

## Tool Quick Reference

### 1. SearXNG — Search the Web
**When:** Finding information, research, fact-checking
**Speed:** ~200ms | **Cost:** Zero (self-hosted)
```bash
curl -s "${SEARXNG_URL:-http://localhost:8890}/search?q=QUERY&format=json" | jq '.results[:5]'
```
Categories: `general`, `news`, `images`, `videos`, `science`, `it`
Time filters: `day`, `week`, `month`, `year`

### 2. web_fetch — Read a Page
**When:** Getting page content, articles, docs, READMEs
**Speed:** ~500ms | **Cost:** Zero
```
web_fetch(url="https://example.com", extractMode="markdown", maxChars=5000)
```

### 3. agent-browser — Interact with Pages
**When:** Clicking, forms, SPAs, screenshots, multi-step navigation
**Speed:** ~1-2s | **Cost:** Zero (local Chrome)
```bash
agent-browser open "https://example.com"
agent-browser snapshot -i          # Get interactive elements
agent-browser click @e5            # Click by ref
agent-browser fill @e3 "text"      # Fill input
agent-browser screenshot page.png  # Capture
agent-browser get text "main"      # Extract content
agent-browser close
```

### 4. OpenClaw Browser — Complex Sessions
**When:** Multi-tab work, long browser sessions, managed state
```
browser(action="open", url="https://example.com")
browser(action="snapshot")
browser(action="act", kind="click", ref="e5")
```

## Rules
1. **Always try the simplest tool first** — SearXNG → web_fetch → agent-browser → OpenClaw browser
2. **Don't use a browser to read a static page** — web_fetch is 5x faster
3. **Don't use web_fetch for SPAs** — JavaScript won't render, use agent-browser
4. **SearXNG for search, ALWAYS** — don't Google through a browser
5. **agent-browser over OpenClaw browser** for quick interactions — lighter, faster
