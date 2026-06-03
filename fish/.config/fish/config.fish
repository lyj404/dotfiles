if status is-interactive
    # Commands to run in interactive sessions can go here

    # Disable the  fish welcome message
    set -g fish_greeting ""
end

# use proxy
function proxy
    set -gx http_proxy "http://127.0.0.1:7890"
    set -gx https_proxy "http://127.0.0.1:7890"
    echo "✅ Proxy started"
end

# cancel proxy
function unproxy
    set -e http_proxy
    set -e https_proxy
    echo "❌ Proxy stopped"
end

set -gx V_API_KEY "sk-ksAoE8Drz8FQHGb82wWGqtCNO4tI4qwEbVjEpbrS0fTBdAWq"

# setting alias
alias sem="sudo -E emacs"
alias sn="sudo -E nano"
alias ls="exa --icons"
alias lsa="exa -a --icons"
alias cat="bat --style=plain"
alias claude-any="claude --settings ~/.claude/settings.anyrouter.json"
alias claude-mimo="claude --settings ~/.claude/settings.mimo.json"

starship init fish | source
vfox activate fish | source