#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPOSITORY_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
readonly EXPECTED_SKILLS="domain-modeling
grill-with-docs
grilling
implement
implement-with-validation
orchestrate-models
pr-code-review
setup-matt-pocock-skills
to-spec
to-tickets
triage"

declare -a skill_files=()
while IFS= read -r skill_file; do
  skill_files+=("${skill_file}")
done < <(
  find "${REPOSITORY_ROOT}/skills" -mindepth 3 -maxdepth 3 \
    -type f -name SKILL.md | sort
)

if [[ "${#skill_files[@]}" -ne 11 ]]; then
  echo "Expected 11 skills, found ${#skill_files[@]}" >&2
  exit 1
fi

declare -a names=()
for skill_file in "${skill_files[@]}"; do
  if [[ "$(sed -n '1p' "${skill_file}")" != "---" ]]; then
    echo "Missing YAML frontmatter: ${skill_file}" >&2
    exit 1
  fi

  name="$(sed -n 's/^name:[[:space:]]*//p' "${skill_file}" | head -n 1)"
  description="$(sed -n 's/^description:[[:space:]]*//p' "${skill_file}" | head -n 1)"

  if [[ -z "${name}" || -z "${description}" ]]; then
    echo "Missing name or description: ${skill_file}" >&2
    exit 1
  fi

  directory_name="$(basename "$(dirname "${skill_file}")")"
  if [[ "${name}" != "${directory_name}" ]]; then
    echo "Skill name '${name}' does not match directory '${directory_name}'" >&2
    exit 1
  fi

  names+=("${name}")
done

actual_skills="$(printf '%s\n' "${names[@]}" | sort)"
if [[ "${actual_skills}" != "${EXPECTED_SKILLS}" ]]; then
  echo "Skill set does not match the expected bundle" >&2
  diff -u <(printf '%s\n' "${EXPECTED_SKILLS}") <(printf '%s\n' "${actual_skills}") || true
  exit 1
fi

if [[ "$(printf '%s\n' "${names[@]}" | sort -u | wc -l | tr -d ' ')" -ne 11 ]]; then
  echo "Duplicate skill names found" >&2
  exit 1
fi

if ! grep -Eq '^[0-9a-f]{40}$' "${REPOSITORY_ROOT}/upstream/matt-pocock.commit"; then
  echo "Invalid upstream commit provenance" >&2
  exit 1
fi

test -s "${REPOSITORY_ROOT}/upstream/MATT-POCOCK-LICENSE"
test -f "${REPOSITORY_ROOT}/skills/matt/domain-modeling/ADR-FORMAT.md"
test -f "${REPOSITORY_ROOT}/skills/matt/setup-matt-pocock-skills/issue-tracker-github.md"
test -f "${REPOSITORY_ROOT}/skills/matt/triage/AGENT-BRIEF.md"

echo "Validated ${#skill_files[@]} skills"
