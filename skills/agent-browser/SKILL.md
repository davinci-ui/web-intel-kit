---
name: agent-browser
description: Browse the web, scrape pages, automate UI, and interact with websites using the agent-browser CLI. Use for web interaction, form filling, screenshots, SPA navigation, or any task requiring a real browser.
---

# agent-browser — Web Automation CLI

## Install

```bash
npm i -g agent-browser
agent-browser install              # Downloads Chrome
agent-browser install --with-deps  # + system libraries (Linux)
```

## Quick Start

```bash
agent-browser open <url>          # Navigate
agent-browser snapshot -i         # Interactive elements with refs
agent-browser click @e2           # Click by ref
agent-browser fill @e3 "text"     # Fill input
agent-browser get text @e1        # Extract text
agent-browser screenshot page.png # Capture
agent-browser close               # Done
```

## Common Workflows

### Read a page (JS-rendered)
```bash
agent-browser open "https://example.com"
agent-browser snapshot              # Full accessibility tree
agent-browser get text "main"       # Get main content text
agent-browser close
```

### Fill and submit a form
```bash
agent-browser open "https://example.com/login"
agent-browser snapshot -i           # See interactive refs
agent-browser fill @e5 "username"   # Fill username
agent-browser fill @e6 "password"   # Fill password
agent-browser click @e7             # Click submit
agent-browser snapshot              # See result
agent-browser close
```

### Screenshot
```bash
agent-browser open "https://example.com"
agent-browser screenshot full-page.png --full
agent-browser close
```

### Navigate multi-page
```bash
agent-browser open "https://example.com"
agent-browser click @e10            # Click a link
agent-browser snapshot              # New page content
agent-browser back                  # Go back
agent-browser close
```

## Key Commands

| Command | Purpose |
|---------|---------|
| `open <url>` | Navigate to URL |
| `snapshot` | Full accessibility tree |
| `snapshot -i` | Interactive elements only |
| `click @ref` | Click element by ref |
| `fill @ref "text"` | Type into input |
| `get text <selector>` | Extract text content |
| `screenshot <file>` | Save screenshot |
| `back` / `forward` | Navigate history |
| `close` | Close browser |

## Tips
- Use `snapshot -i` to see only clickable/fillable elements (saves tokens)
- Refs like `@e5` are stable within a page load
- After clicking, always `snapshot` again to see the new state
- Use `--full` flag on screenshot for full-page capture

## Links
- npm: https://www.npmjs.com/package/agent-browser
- Requires: Node.js 18+, Chrome (auto-installed)
