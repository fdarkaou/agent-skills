#!/usr/bin/env bash
set -euo pipefail

readonly REPOSITORY_URL="https://github.com/mattpocock/skills.git"
readonly MATT_REF="${MATT_REF:-main}"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPOSITORY_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
readonly TEMPORARY_DIRECTORY="$(mktemp -d)"

cleanup() {
  rm -rf "${TEMPORARY_DIRECTORY}"
}
trap cleanup EXIT

fingerprint_bundle() {
  {
    if [[ -d "${REPOSITORY_ROOT}/skills/matt" ]]; then
      find "${REPOSITORY_ROOT}/skills/matt" -type f | LC_ALL=C sort |
        while IFS= read -r file; do
          relative_path="${file#"${REPOSITORY_ROOT}/"}"
          checksum="$(shasum -a 256 "${file}" | awk '{print $1}')"
          printf '%s %s\n' "${checksum}" "${relative_path}"
        done
    fi

    if [[ -f "${REPOSITORY_ROOT}/upstream/MATT-POCOCK-LICENSE" ]]; then
      shasum -a 256 "${REPOSITORY_ROOT}/upstream/MATT-POCOCK-LICENSE"
    fi
  } | shasum -a 256 | awk '{print $1}'
}

readonly BEFORE_FINGERPRINT="$(fingerprint_bundle)"

git clone --quiet --depth 1 --branch "${MATT_REF}" \
  "${REPOSITORY_URL}" "${TEMPORARY_DIRECTORY}/upstream"

declare -a SOURCE_MAPPINGS=(
  "skills/engineering/grill-with-docs:grill-with-docs"
  "skills/engineering/domain-modeling:domain-modeling"
  "skills/productivity/grilling:grilling"
  "skills/engineering/to-spec:to-spec"
  "skills/engineering/to-tickets:to-tickets"
  "skills/engineering/setup-matt-pocock-skills:setup-matt-pocock-skills"
)

for mapping in "${SOURCE_MAPPINGS[@]}"; do
  source_path="${mapping%%:*}"
  destination_name="${mapping##*:}"
  source_directory="${TEMPORARY_DIRECTORY}/upstream/${source_path}"
  destination_directory="${REPOSITORY_ROOT}/skills/matt/${destination_name}"

  if [[ ! -f "${source_directory}/SKILL.md" ]]; then
    echo "Missing upstream skill: ${source_path}" >&2
    exit 1
  fi

  rm -rf "${destination_directory}"
  cp -R "${source_directory}" "${destination_directory}"
done

cp "${TEMPORARY_DIRECTORY}/upstream/LICENSE" \
  "${REPOSITORY_ROOT}/upstream/MATT-POCOCK-LICENSE"

readonly AFTER_FINGERPRINT="$(fingerprint_bundle)"
if [[ "${BEFORE_FINGERPRINT}" == "${AFTER_FINGERPRINT}" ]]; then
  "${SCRIPT_DIR}/validate-skills.sh"
  echo "Selected Matt Pocock skills are already current."
  exit 0
fi

git -C "${TEMPORARY_DIRECTORY}/upstream" rev-parse HEAD \
  > "${REPOSITORY_ROOT}/upstream/matt-pocock.commit"

"${SCRIPT_DIR}/validate-skills.sh"

echo "Synced Matt Pocock skills at $(<"${REPOSITORY_ROOT}/upstream/matt-pocock.commit")"
