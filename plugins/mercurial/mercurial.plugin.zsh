
# Mercurial
alias hc='hg commit'
alias hgb='hg branch'
alias hgba='hg branches'
alias hgbk='hg bookmarks'
alias hgco='hg checkout'
alias hd='hg diff'
alias hged='hg diffmerge'
# pull and update
alias hin='hg incoming'
alias hpu='hg pull -u'
alias hpr='hg pull --rebase'
alias hou='hg outgoing'
alias hp='hg push'
alias hs='hg status'
# this is the 'git commit --amend' equivalent
alias hgca='hg qimport -r tip ; hg qrefresh -e ; hg qfinish tip'

function hg_current_branch() {
  if [ -d .hg ]; then
    echo hg:$(hg branch)
  fi
}
