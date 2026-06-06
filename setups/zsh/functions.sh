function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

function mpass() {
	PASS=$(echo -n $2$1 | md5)
	echo "ALTER USER $1 ENCRYPTED PASSWORD 'md5$PASS';"
}

function extract_issues_id() {
	echo $1 | tail -1 | grep -oe '\(DSF.*\)$'
}

function git_main_branch () {
    command git rev-parse --git-dir &> /dev/null || return
    local ref
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}
    do
        if command git show-ref -q --verify $ref
        then
            echo ${ref:t}
            return
        fi
    done
    echo master
}
