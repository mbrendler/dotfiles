if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%m%{${fg_bold[blue]}%}:%{$reset_color%}%{${fg_bold[blue]}%}:%{$reset_color%}%{${fg[green]}%}%~ %{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

RPS1="${return_code}"
