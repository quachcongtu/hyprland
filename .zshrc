# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git zsh-autosuggestions)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load syntax highlighting
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Keybinding
bindkey -v
bindkey ^F autosuggest-accept

alias vi="nvim"
alias off="poweroff"
alias cl="clear"
alias clt="tmux kill-server"

# Tích hợp fzf vào Zsh (cho tự động tìm lịch sử, thư mục, v.v.)
source <(fzf --zsh)

# Alias mở nhanh fzf
alias f='fzf'

# Xem nội dung file với màu
alias fp='fzf --preview="bat --color=always {}"'

# Mở file chọn bằng nvim (có preview nội dung)
alias fv='nvim $(fzf -m --preview="bat --color=always {}")'

# Duyệt nhanh thư mục home (bỏ qua ẩn)
op() {
  local user_dir="$HOME"
  local dir
  dir=$(find "$user_dir" -mindepth 1 -maxdepth 1 -type d ! -name '.*' | fzf) && cd "$dir"
}

