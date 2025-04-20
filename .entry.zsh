# SPDX-License-Identifier: MIT
#
# .p10k.zsh.d - A modular extension for Powerlevel10k configuration.
#
# Copyright (C) 2025 Emmanuel Amoah
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

p10k_d_prompt_edit() {
	(( $# < 3 )) && { echo "$0: Too few arguments." >&2; return 1; }

	local side=$1
	local action=$2
	local item=$3

	case $side in
	left)
		local array=POWERLEVEL9K_LEFT_PROMPT_ELEMENTS
	;;
	right)
		local array=POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS
	;;
	*)
		echo "$0: Invalid argument: $side" >&2; return 1
	;;
	esac

	case $action in
	add)
		if (( $# > 3 )); then
			eval 'local index_of_last=${'$array'[(i)'$@[-1]']}'
			eval $array'['$index_of_last']=('$@[3,-2]' '$@[-1]')'
		else
			eval "$array+=$item"
      		fi
	;;
	replace)
		(( $# < 4 )) && { echo "$0: Too few arguments." >&2; return 1; }
		eval 'local index=${'$array'[(i)'$3']}'
		eval 'local arrlen=$#'$array
		(( $index > $arrlen )) && { echo "$0: Item $3 doesn't exist." >&2; return 1; }
		eval $array'['$index']=('$@[4,-1]')'
	;;
	remove)
		local excl=($@[3,-1])
		eval $array'=(${'$array':|excl})'
	;;
	*)
		echo "$0: Invalid argument: $action" >&2; return 1
	;;
	esac
}

alias p10k_d_left_add='p10k_d_prompt_edit left add'
alias p10k_d_left_remove='p10k_d_prompt_edit left remove'
alias p10k_d_left_replace='p10k_d_prompt_edit left replace'
alias p10k_d_right_add='p10k_d_prompt_edit right add'
alias p10k_d_right_remove='p10k_d_prompt_edit right remove'
alias p10k_d_right_replace='p10k_d_prompt_edit right replace'

local f;
for f in ~/.p10k.zsh.d/*.zsh(N^D) ; do . $f ; done