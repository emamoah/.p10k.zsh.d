# SPDX-License-Identifier: MIT
#
# A proxychains module for .p10k.zsh.d
#
# Copyright (C) 2025 Emmanuel Amoah

prompt_proxychains() {
	local TOR_HOST=127.0.0.1
	local TOR_PORT=9050

	[[ -n $PROXYCHAINS_CONF_FILE ]] && {
		local CHAIN=$(grep -E '^\s*(socks[45]|http|raw)' $PROXYCHAINS_CONF_FILE)

		if grep -qE "^socks[45]\\s+$TOR_HOST\\s+$TOR_PORT" <<< $CHAIN; then
			local STATE=TOR
			local ICON=''
			local FOREGROUND=129
			local TEXT=Tor
		else
			local CHAINLEN=$(grep -c '.' <<< $CHAIN)

			local STATE=NOTOR
			local ICON=''
			local FOREGROUND=255
			local TEXT=$CHAINLEN
		fi

		p10k segment -s $STATE -f "$FOREGROUND" -i "$ICON" -t "$TEXT"
	}
}