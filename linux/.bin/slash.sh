### Add trailing slash if needed

STR="/i/am/a/path"

length=${#STR}
last_char=${STR:length-1:1}

[[ $last_char != "/" ]] && STR="$STR/"; :

echo "$STR" # => /i/am/a/path/


### Remove trailing slash if given

STR="/i/am/a/path/"

length=${#STR}
last_char=${STR:length-1:1}

[[ $last_char == "/" ]] && STR=${STR:0:length-1}; :

echo "$STR" # => /i/am/a/path