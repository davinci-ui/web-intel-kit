# Web Intel Kit for OpenClaw

Smart web tool routing for [OpenClaw](https://github.com/openclaw/openclaw) agents. Four tools, one decision tree — your agent always picks the fastest option.

## The Tools

| Tool | Best For | Speed | Setup |
|------|----------|-------|-------|
| **SearXNG** | Searching the web | ~200ms | Docker |
| **web_fetch** | Reading pages | ~500ms | Built into OpenClaw |
| **agent-browser** | Clicking, forms, SPAs | ~1-2s | npm install |
| **OpenClaw browser** | Complex multi-tab sessions | Varies | Built into OpenClaw |

## How It Works

The `web-intel` skill teaches your agent to automatically pick the right tool:

```
Search? → SearXNG (fastest, aggregates Google+Bing+DDG)
Read a page? → web_fetch (zero setup, markdown output)
Click/interact? → agent-browser (refs, forms, screenshots)
Complex session? → OpenClaw browser (persistent tabs)
```

**Rule: simplest tool first, escalate only when needed.**

## Quick Install

### 1. SearXNG (Self-Hosted Search)

Free, unlimited web search. No API keys.

```bash
cd docker
docker compose up -d
```

Test it:
```bash
curl -s "http://localhost:8890/search?q=hello+world&format=json" | jq '.results[:3]'
```

### 2. agent-browser (Web Automation CLI)

Headless Chrome controlled via CLI. Click, fill, screenshot — all by reference.

```bash
npm i -g agent-browser
agent-browser install
```

> **Note:** On Linux servers, you may need Chrome dependencies:
> ```bash
> agent-browser install --with-deps
> # If that fails:
> apt-get install -y libnspr4 libnss3 libatk1.0-0 libatk-bridge2.0-0 \
>   libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 \
>   libgbm1 libpango-1.0-0 libcairo2 libasound2 libxshmfence1 libxfixes3
> ```

Test it:
```bash
agent-browser open "https://example.com"
agent-browser snapshot
agent-browser close
```

### 3. web_fetch (Built-in)

Already included with OpenClaw. No setup needed.

### 4. OpenClaw Browser (Built-in)

Already included with OpenClaw. No setup needed.

## Install the Skills

Copy the skills into your OpenClaw skills directory:

```bash
cp -r skills/* /path/to/your/skills/
```

Or point OpenClaw at this repo:

```json5
{
  skills: {
    load: {
      extraDirs: ["/path/to/web-intel-kit/skills"],
      watch: true
    }
  }
}
```

## Structure

```
web-intel-kit/
├── README.md
├── docker/
│   ├── docker-compose.yml        # SearXNG container
│   └── searxng/
│       └── settings.yml          # Engine config
└── skills/
    ├── web-intel/
    │   └── SKILL.md              # The router — picks the right tool
    ├── searxng/
    │   └── SKILL.md              # SearXNG search reference
    └── agent-browser/
        └── SKILL.md              # agent-browser CLI reference
```

## Links

| Tool | Homepage | Install |
|------|----------|---------|
| **SearXNG** | [searxng.org](https://docs.searxng.org/) | `docker compose up -d` |
| **agent-browser** | [npm](https://www.npmjs.com/package/agent-browser) | `npm i -g agent-browser` |
| **OpenClaw** | [openclaw.ai](https://docs.openclaw.ai) | [Install Guide](https://docs.openclaw.ai/getting-started/installation) |

## Requirements

- [OpenClaw](https://github.com/openclaw/openclaw) gateway
- Docker (for SearXNG)
- Node.js 18+ (for agent-browser)

## License

MIT
