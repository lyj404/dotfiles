if status is-interactive
    # Commands to run in interactive sessions can go here

    # Disable the  fish welcome message
    set -g fish_greeting ""
end

# 设置代理
function proxy
    set -gx http_proxy "http://127.0.0.1:12334"
    set -gx https_proxy "http://127.0.0.1:12334"
    echo "✅ Proxy started"
end

function unproxy
    set -e http_proxy
    set -e https_proxy
    echo "❌ Proxy stopped"
end

# 设置别名
alias sem="sudo -E emacs"
alias sn="sudo -E nano"
alias cl="clear"
alias la="ls -a"