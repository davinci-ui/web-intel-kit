---
name: searxng
description: Web search via self-hosted SearXNG. Use for any web search, research, fact-checking, or current information lookup. Unlimited, zero cost, aggregates Google + Bing + DuckDuckGo.
---

# SearXNG — Self-Hosted Web Search

## Quick Search

```bash
curl -s "${SEARXNG_URL:-http://localhost:8890}/search?q=URL_ENCODED_QUERY&format=json" | jq '.results[:5][] | {title, url, content}'
```

## Python

```python
import os, urllib.request, json, urllib.parse
base = os.environ.get("SEARXNG_URL", "http://localhost:8890")
q = urllib.parse.quote("your search query")
results = json.loads(urllib.request.urlopen(f"{base}/search?q={q}&format=json").read())
for r in results["results"][:5]: print(f"- {r['title']}: {r['url']}")
```

## Parameters

| Param | Values | Default |
|-------|--------|---------|
| `q` | search query (URL-encoded) | required |
| `format` | `json`, `html`, `rss` | `html` |
| `categories` | `general`, `images`, `news`, `videos`, `music`, `files`, `it`, `science` | `general` |
| `language` | `en`, `ja`, `all` | auto |
| `time_range` | `day`, `week`, `month`, `year` | none |
| `pageno` | page number | `1` |

## Environment

| Variable | Default | Purpose |
|----------|---------|---------|
| `SEARXNG_URL` | `http://localhost:8890` | SearXNG instance URL |
