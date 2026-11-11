# AGENTS.md

Operating contract for bots/agents (e.g. Grok) working in this repo. Work is tracked in Linear (team `MCP-Graph`, prefix `MGR`) and delivered through GitHub PRs.

## Direction

Evolve from a raw Microsoft Graph proxy into a **safe, policy-governed Graph tool layer for agents**: read-only by default, scoped capability packs, full audit trail, remote-ready with per-user auth.

## Rules for every agent

1. Pick issues in state `Ready` carrying your lane label. One lane per session.
2. Touch only your lane's paths. If a change is needed elsewhere, create a linked issue in that lane, then set yours to `Blocked`.
3. One issue = one PR. Branch `mgr-<n>-<slug>`; PR title starts with `MGR-<n>`. Include acceptance criteria and how it was tested.
4. Never self-merge. `server`, `identity` and `mcp-spec` PRs need approval from `sec:review` and `quality`.
5. Never put tenant IDs, client IDs, secrets, or local paths in code, docs, issues, PRs, or logs.
6. Credential rotation, Entra app changes, and publishing are always `Needs Human` (assign @MSSecCSA); they skip the advisor.
7. Do not add write capabilities without the write-mode flag, an allowlist entry, and tests.
8. Follow the escalation ladder below instead of guessing or stalling.

## Escalation ladder

1. **Bot decides** when confidence is high and the change is in-lane.
2. **Advisor (GitHub Copilot)** is pulled in when the bot has low confidence: ambiguous requirements, conflicting reviews, unfamiliar Graph/MCP behavior, or a security tradeoff. Bot sets label `needs-advisor`, states the question, its options, and its confidence. The advisor assesses and replies with a recommendation and its own confidence (high/medium/low).
3. **Human (@MSSecCSA)** is the tiebreaker. Escalate with `needs-human` when the advisor's confidence is low, the advisor and bot or two reviewers disagree after one round, or the issue is in the always-human list (rule 6).

Notes:
- The advisor advises; it does not merge, and its recommendation does not replace the `sec:review` and `quality` approvals on `server`, `identity` and `mcp-spec` PRs.
- One advisor round per question. No loops: if unresolved, go to the human.
- Escalation messages must be self-contained (question, options, evidence, confidence) so the human can decide in one read.
- Linear: `needs-advisor` and `needs-human` map to the `Blocked` and `Needs Human` states respectively.

## Lanes

| Lane / label | Paths | Responsibility |
|---|---|---|
| `sec:secrets` | repo-wide, read-only | Detect leaked identifiers/secrets; open rotation issues. No code edits. |
| `docs` | `*.md` (root), `docs/` | Consolidate status docs into README/QUICKSTART/`docs/`; remove identifiers. |
| `server` | `McpServerGraphAPI/**` | Read-only default, allowlist, encoding, paging/retry, typed tools, SDK upgrade. |
| `mcp-spec` | `McpServerGraphAPI/Transport/` | Streamable HTTP, OAuth 2.1, elicitation, tool annotations; track spec changes. |
| `graph-api` | `McpServerGraphAPI/Packs/` | Capability packs, least-privilege permission per tool, v1.0 vs beta drift. |
| `identity` | `McpServerGraphAPI/Auth/` | Managed identity, certificate, OBO; retire secret-only auth. |
| `sec:review` | review-only | Threat model and review injection/SSRF/over-permission on server PRs. |
| `quality` | `tests/`, `evals/` | Mock Graph handler, unit tests, agent evals incl. negative write cases. |
| `release` | `.github/workflows/`, `Dockerfile` | CI, CodeQL, container, NuGet/MCP registry publishing, SBOM/signing. |
| `deps` | `*.csproj` | Dependabot NuGet/Actions updates. |
| `client` | `McpClient/`, `docs/clients/` | Reference client only; env/Key Vault keys; client config snippets. |
| `observability` | `McpServerGraphAPI/Telemetry/` | OpenTelemetry audit log, redaction. |
| triage | Linear / GitHub issues | Maintain labels, milestones, escalate cross-lane conflicts. |

## Linear workflow

States: `Backlog → Ready → In Progress → In Review → Done`, plus `Blocked` and `Needs Human`. Projects map to phases P0–P5. Cross-lane work is a parent issue with one sub-issue per lane. The Linear GitHub integration moves issues on PR open/merge.

## Phases and gates

- **P0 Stabilize** → **Gate A:** secrets rotated, CI green, single consolidated README. P1 stays in `Backlog` until passed.
- **P1 Safe Core** → **Gate B:** no write call runs without the flag; allowlist tests pass; approved by `sec:review` and `quality`.
- **P2** Typed tools · **P3** Remote & identity · **P4** Governance & evals · **P5** Differentiate (security-posture packs).

## Seed backlog

| ID | Phase | Lane | Issue |
|---|---|---|---|
| MGR-1 | P0 | sec:secrets | Rotate client secret; scrub IDs from `GEMINI.md`/docs (`Needs Human`) |
| MGR-2 | P0 | docs | Consolidate status docs |
| MGR-3 | P0 | release | CI (build, test, CodeQL) + security policy |
| MGR-4 | P0 | deps | Dependabot |
| MGR-5 | P1 | server | Read-only default; write behind flag |
| MGR-6 | P1 | server | Path/method allowlist; URL/query encoding |
| MGR-7 | P1 | server | Paging, 429 retry, response size caps |
| MGR-8 | P1 | mcp-spec | Tool annotations |
| MGR-9 | P1 | quality | Mock Graph handler + allowlist tests |
| MGR-10 | P1 | sec:review | Passthrough threat model |
| MGR-11 | P2 | graph-api | Capability packs + permission matrix |
| MGR-12 | P3 | identity | Managed identity / certificate credentials |
| MGR-13 | P3 | mcp-spec | Streamable HTTP + OAuth 2.1 |
| MGR-14 | P4 | observability | OpenTelemetry audit logging |

## Reporting

Weekly Linear project update: done, blocked, and `Needs Human` items. Slipped issues return to `Backlog` with a reason.
