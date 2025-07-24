# SPDX-License-Identifier: MIT
#
# A proxychains module for .p10k.zsh.d
#
# Copyright (C) 2025 Emmanuel Amoah

prompt_proxychains() {
	local TOR_HOST=127.0.0.1
	local TOR_PORT=9050

	[[ -n $PROXYCHAINS_CONF_FILE ]] && {
		local CHAIN=(${${${(M)${(Af)"$(<$PROXYCHAINS_CONF_FILE)"}:#[[:space:]]#(socks[45]|http|raw)*}##[[:space:]]#}%%[[:space:]]#})

		if (( ${(M)#CHAIN:#socks[45][[:space:]]##${TOR_HOST}[[:space:]]##${TOR_PORT}} )); then
			local STATE=TOR
			local ICON=''
			local FOREGROUND=129
			local TEXT=Tor
		else
			local STATE=NOTOR
			local ICON=''
			local FOREGROUND=255
			local TEXT=$#CHAIN
		fi

		p10k segment -s $STATE -f "$FOREGROUND" -i "$ICON" -t "$TEXT"
	}
}

