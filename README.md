# Web Intel Kit for OpenClaw

The complete web toolkit for [OpenClaw](https://github.com/openclaw/openclaw) agents. Three tools, one smart router — your agent always picks the fastest option.

## The Three Tools

| Tool | Best For | Speed | Install |
|------|----------|-------|---------|
| 🔍 **SearXNG** | Searching the web | ~200ms | `docker compose up -d` |
| 📖 **web_fetch** | Reading pages | ~500ms | Built into OpenClaw |
| 🌐 **agent-browser** | Clicking, forms, SPAs, screenshots | ~1-2s | `npm i -g agent-browser` |

Plus OpenClaw's built-in browser for complex multi-tab sessions.

## How It Works

The `web-intel` skill is a decision tree that teaches your agent to route automatically:

```
Search? → SearXNG (fastest, aggregates Google+Bing+DDG)
Read a page? → web_fetch (zero setup, markdown output)
Click/interact? → agent-browser (refs, forms, screenshots)
Complex session? → OpenClaw browser (persistent tabs)
```

**Rule: simplest tool first, escalate only when needed.**

---

## Install Everything

### 1. SearXNG — Self-Hosted Search (Docker)

Free, unlimited web search. No API keys, no rate limits.

```bash
cd docker
docker compose up -d
```

Verify:
```bash
curl -s "http://localhost:8890/search?q=hello+world&format=json" | jq '.results[:3][] | {title, url}'
```

**What you get:** Google + Bing + DuckDuckGo + Wikipedia results in one JSON API call. Zero cost.

### 2. agent-browser — Web Automation CLI (npm)

Headless Chrome controlled via CLI. Click, fill forms, take screenshots — all by reference.

```bash
npm i -g agent-browser
agent-browser install
```

> **Linux servers** may need Chrome dependencies:
> ```bash
> agent-browser install --with-deps
> # If that fails, install manually:
> apt-get install -y libnspr4 libnss3 libatk1.0-0 libatk-bridge2.0-0 \
>   libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 \
>   libgbm1 libpango-1.0-0 libcairo2 libasound2 libxshmfence1 libxfixes3
> ```

Verify:
```bash
agent-browser open "https://example.com"
agent-browser snapshot
agent-browser close
```

### 3. web_fetch — Built-in

Already included with OpenClaw. No setup needed.

---

## Install the Skills

Copy the skills into your OpenClaw skills directory:

```bash
cp -r skills/* /path/to/your/skills/
```

Or point OpenClaw at this repo directly:

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

Then add the skills to your agent config:

```json5
{
  agents: {
    list: [{
      id: "main",
      skills: ["web-intel", "searxng", "agent-browser"]
    }]
  }
}
```

---

## Configure SearXNG URL

If SearXNG isn't on localhost:

```bash
export SEARXNG_URL="http://your-server:8890"
```

Edit `docker/searxng/settings.yml` to:
- Enable/disable search engines
- Change the default language
- Adjust safe search
- Add more engines ([full list](https://docs.searxng.org/user/configured_engines.html))

**Important:** Change `secret_key` in `settings.yml` before deploying to a public network.

---

## Structure

```
web-intel-kit/
├── README.md
├── docker/
│   ├── docker-compose.yml        # SearXNG container
│   └── searxng/
│       └── settings.yml          # Engine config (JSON API enabled)
└── skills/
    ├── web-intel/
    │   └── SKILL.md              # The router — picks the right tool
    ├── searxng/
    │   └── SKILL.md              # SearXNG search reference
    └── agent-browser/
        └── SKILL.md              # agent-browser CLI reference
```

## Links

| Tool | Homepage | Package |
|------|----------|---------|
| **SearXNG** | [docs.searxng.org](https://docs.searxng.org/) | [Docker Hub](https://hub.docker.com/r/searxng/searxng) |
| **agent-browser** | [GitHub](https://github.com/ApeironOne/web-intel-kit) | [npm](https://www.npmjs.com/package/agent-browser) |
| **OpenClaw** | [docs.openclaw.ai](https://docs.openclaw.ai) | [GitHub](https://github.com/openclaw/openclaw) |

## Requirements

- [OpenClaw](https://github.com/openclaw/openclaw) gateway
- Docker (for SearXNG)
- Node.js 18+ (for agent-browser)

## License

MIT
