

function hg_prompt_info() {
  hg prompt --angle-brackets "\
$ZSH_THEME_HG_PROMPT_PREFIX\
<<branch>>\
<status|modified|unknown><update><\
patches: <patches|join( → )>>\
$ZSH_THEME_HG_PROMPT_SUFFIX" 2>/dev/null
}
