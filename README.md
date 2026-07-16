# Fekri's Agent Skills

A curated, team-installable bundle of agent skills for Codex and Claude Code.

The repository contains:

- Fekri's skills: `implement`, `pr-code-review`, and `orchestrate-models`.
- Selected skills from [Matt Pocock's skills repository](https://github.com/mattpocock/skills): `grill-with-docs`, `domain-modeling`, `grilling`, `to-spec`, `to-tickets`, and `setup-matt-pocock-skills`.

`domain-modeling` and `grilling` are included because `grill-with-docs` invokes them. Matt renamed the older `to-prd` and `to-issues` skills to `to-spec` and `to-tickets`; this bundle follows the current upstream names.

## Install

Interactive install:

```bash
npx skills@latest add fdarkaou/agent-skills
```

Install every skill globally for Codex:

```bash
npx skills@latest add fdarkaou/agent-skills \
  --skill '*' \
  --global \
  --agent codex \
  --yes
```

For Claude Code, use the interactive installer and select the compatible skills you want:

```bash
npx skills@latest add fdarkaou/agent-skills \
  --global \
  --agent claude-code
```

Do not select `orchestrate-models` for Claude Code: it describes Codex's in-app subagent and model-routing surface. The first command lets each teammate select both skills and agents. The Codex command installs the complete bundle without prompts.

## Update installed skills

After this repository changes, each teammate updates their installed global skills with:

```bash
npx skills@latest update --global --yes
```

This updates consumers from their recorded source. It does not fetch changes from Matt's repository into this repository; that is a separate publisher operation below.

## Update Matt Pocock's skills in this repository

### From GitHub

1. Open **Actions** in `fdarkaou/agent-skills`.
2. Select **Sync Matt Pocock skills**.
3. Click **Run workflow**.
4. Review the pull request the workflow opens.
5. Merge it when the prompt changes look correct.

The same operation from the GitHub CLI is:

```bash
gh workflow run sync-matt-skills.yml --repo fdarkaou/agent-skills
```

The workflow also runs every Monday. It records the exact upstream commit and opens a PR only when selected files changed. It never auto-merges prompt changes.

### Locally

```bash
git clone https://github.com/fdarkaou/agent-skills.git
cd agent-skills
./scripts/sync-matt-skills.sh
./scripts/validate-skills.sh
git diff
```

Review the diff, then commit and push it normally.

## Bundle policy

- Matt-derived directories are replaced from upstream as complete directories, including supporting files and Codex metadata.
- `upstream/matt-pocock.commit` records the exact source commit.
- `upstream/MATT-POCOCK-LICENSE` preserves Matt Pocock's MIT license.
- `tdd` and `nodebt` are intentionally not duplicated in the default bundle because `implement` already applies their test-first and end-state-quality principles.
- Upstream prompt changes require human review before they reach teammates.

## Validate

```bash
./scripts/validate-skills.sh
```

The validator checks the expected bundle, skill frontmatter, unique names, and the recorded upstream provenance.
