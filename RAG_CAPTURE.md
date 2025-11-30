# RAG capture note (MCP)
Intent: cache useful MCP responses (e.g., Microsoft Learn) locally to cut token cost/latency.
Steps:
- After each MCP call, persist {question, answer, source, url, timestamp, tags} as text.
- Embed with fastembed model BAAI/bge-small-en-v1.5; upsert to Qdrant (http://localhost:6333, collection: mcp_cache, cosine) with payload metadata.
- Optionally short-term store full raw answers in Redis (localhost:6379) keyed by normalized question.
- On new questions: embed → Qdrant top-k → build prompt with retrieved context; only call MCP if low confidence or stale.
- Keep source citations in prompts; revalidate stale entries periodically.
