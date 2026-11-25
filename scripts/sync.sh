#!/usr/bin/env bash
# ==============================================================================
# akkco-skills: Multi-Agent Skill Sync Manager
# Syncs skills between akkco-skills, OpenAI Codex, and Google Antigravity
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILLS_SRC="${REPO_ROOT}/skills"

# Target directories
CODEX_SKILLS_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
ANTIGRAVITY_SKILLS_DIR="${HOME}/.gemini/config/skills"
AGENTS_SKILLS_DIR="${HOME}/.agents/skills"

# Formatting
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RED="\033[31m"
RESET="\033[0m"

log_info() { echo -e "${CYAN}[INFO]${RESET} $*"; }
log_success() { echo -e "${GREEN}[OK]${RESET} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${RESET} $*"; }
log_error() { echo -e "${RED}[ERROR]${RESET} $*"; }

ensure_dirs() {
    mkdir -p "${SKILLS_SRC}"
    mkdir -p "${CODEX_SKILLS_DIR}"
    mkdir -p "${ANTIGRAVITY_SKILLS_DIR}"
    mkdir -p "${AGENTS_SKILLS_DIR}"
}

get_skills() {
    local skills=()
    for dir in "${SKILLS_SRC}"/*; do
        if [ -d "${dir}" ] && [ -f "${dir}/SKILL.md" ]; then
            skills+=("$(basename "${dir}")")
        fi
    done
    echo "${skills[@]}"
}

# ------------------------------------------------------------------------------
# Action: Symlink (Recommended - Live zero-lag updates)
# ------------------------------------------------------------------------------
cmd_link() {
    ensure_dirs
    local skills=($(get_skills))

    if [ ${#skills[@]} -eq 0 ]; then
        log_warn "No skills with SKILL.md found in ${SKILLS_SRC}"
        return 0
    fi

    echo -e "${BOLD}Linking skills to Codex and Antigravity...${RESET}"

    for skill in "${skills[@]}"; do
        local src="${SKILLS_SRC}/${skill}"

        # Codex (~/.codex/skills/)
        ln -sfn "${src}" "${CODEX_SKILLS_DIR}/${skill}"

        # Antigravity Global (~/.gemini/config/skills/)
        ln -sfn "${src}" "${ANTIGRAVITY_SKILLS_DIR}/${skill}"

        # Generic / Workspace Agent standard (~/.agents/skills/)
        ln -sfn "${src}" "${AGENTS_SKILLS_DIR}/${skill}"

        log_success "Linked: ${BOLD}${skill}${RESET} -> Codex, Antigravity, ~/.agents"
    done

    echo ""
    log_success "All ${#skills[@]} skills linked successfully! Any edits to skills will take effect immediately."
}

# ------------------------------------------------------------------------------
# Action: Copy / Rsync (Isolated standalone copies)
# ------------------------------------------------------------------------------
cmd_copy() {
    ensure_dirs
    local skills=($(get_skills))

    if [ ${#skills[@]} -eq 0 ]; then
        log_warn "No skills with SKILL.md found in ${SKILLS_SRC}"
        return 0
    fi

    echo -e "${BOLD}Copying skills to Codex and Antigravity...${RESET}"

    for skill in "${skills[@]}"; do
        local src="${SKILLS_SRC}/${skill}"

        for target in "${CODEX_SKILLS_DIR}/${skill}" "${ANTIGRAVITY_SKILLS_DIR}/${skill}" "${AGENTS_SKILLS_DIR}/${skill}"; do
            # If it's a symlink, remove it first
            if [ -L "${target}" ]; then
                rm -f "${target}"
            fi
            mkdir -p "${target}"
            cp -a "${src}/." "${target}/"
        done

        log_success "Copied: ${BOLD}${skill}${RESET}"
    done

    echo ""
    log_success "All ${#skills[@]} skills copied successfully."
}

# ------------------------------------------------------------------------------
# Action: Status
# ------------------------------------------------------------------------------
cmd_status() {
    local skills=($(get_skills))

    echo -e "${BOLD}Skill Status across Agents:${RESET}"
    echo "Source: ${SKILLS_SRC}"
    echo "------------------------------------------------------------------"
    printf "%-24s | %-12s | %-12s | %-12s\n" "Skill" "Codex" "Antigravity" ".agents"
    echo "------------------------------------------------------------------"

    for skill in "${skills[@]}"; do
        local status_codex="MISSING"
        local status_gemini="MISSING"
        local status_agents="MISSING"

        if [ -L "${CODEX_SKILLS_DIR}/${skill}" ]; then
            status_codex="LINKED"
        elif [ -d "${CODEX_SKILLS_DIR}/${skill}" ]; then
            status_codex="COPIED"
        fi

        if [ -L "${ANTIGRAVITY_SKILLS_DIR}/${skill}" ]; then
            status_gemini="LINKED"
        elif [ -d "${ANTIGRAVITY_SKILLS_DIR}/${skill}" ]; then
            status_gemini="COPIED"
        fi

        if [ -L "${AGENTS_SKILLS_DIR}/${skill}" ]; then
            status_agents="LINKED"
        elif [ -d "${AGENTS_SKILLS_DIR}/${skill}" ]; then
            status_agents="COPIED"
        fi

        printf "%-24s | %-12s | %-12s | %-12s\n" "${skill}" "${status_codex}" "${status_gemini}" "${status_agents}"
    done
    echo "------------------------------------------------------------------"
}

# ------------------------------------------------------------------------------
# Action: Uninstall (Removes only skills defined in this repo)
# ------------------------------------------------------------------------------
cmd_uninstall() {
    local skills=($(get_skills))

    echo -e "${BOLD}Uninstalling akkco skills from Codex and Antigravity...${RESET}"

    for skill in "${skills[@]}"; do
        for target in "${CODEX_SKILLS_DIR}/${skill}" "${ANTIGRAVITY_SKILLS_DIR}/${skill}" "${AGENTS_SKILLS_DIR}/${skill}"; do
            if [ -e "${target}" ] || [ -L "${target}" ]; then
                rm -rf "${target}"
            fi
        done
        log_info "Removed: ${skill}"
    done

    log_success "All akkco skills uninstalled from Codex, Antigravity, and ~/.agents."
}

# ------------------------------------------------------------------------------
# Action: Configure Antigravity Native skills.json
# ------------------------------------------------------------------------------
cmd_antigravity_json() {
    local config_file="${HOME}/.gemini/config/skills.json"
    mkdir -p "$(dirname "${config_file}")"

    cat <<EOF > "${config_file}"
{
  "entries": [
    {
      "path": "${SKILLS_SRC}"
    }
  ]
}
EOF
    log_success "Configured Antigravity native discovery: ${config_file}"
}

# ------------------------------------------------------------------------------
# Action: Install Git Hook (Auto-sync on git pull / merge)
# ------------------------------------------------------------------------------
cmd_install_git_hook() {
    if [ ! -d "${REPO_ROOT}/.git" ]; then
        log_warn "Repository at ${REPO_ROOT} is not yet a git repo. Initialize with 'git init' first."
        return 1
    fi

    local hook_file="${REPO_ROOT}/.git/hooks/post-merge"
    cat <<EOF > "${hook_file}"
#!/usr/bin/env bash
echo "Running akkco-skills sync..."
"${SCRIPT_DIR}/sync.sh" link
EOF
    chmod +x "${hook_file}"
    log_success "Git post-merge hook installed at ${hook_file}"
}

# ------------------------------------------------------------------------------
# CLI Dispatcher
# ------------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage: $(basename "$0") <command>

Commands:
  link (default)    Symlink all skills to Codex (~/.codex/skills), Antigravity
                    (~/.gemini/config/skills), and ~/.agents/skills.
                    Changes to skills reflect immediately without re-syncing.
  copy              Copy all skills directly (independent physical copies).
  status            Show installation status of each skill across agents.
  uninstall         Remove akkco skills from Codex and Antigravity.
  json              Configure Antigravity's native skills.json registry.
  hook              Install Git post-merge hook to auto-sync when pulling.

EOF
}

ACTION="${1:-link}"

case "${ACTION}" in
    link)
        cmd_link
        ;;
    copy)
        cmd_copy
        ;;
    status)
        cmd_status
        ;;
    uninstall)
        cmd_uninstall
        ;;
    json)
        cmd_antigravity_json
        ;;
    hook)
        cmd_install_git_hook
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        log_error "Unknown action: ${ACTION}"
        usage
        exit 1
        ;;
esac
