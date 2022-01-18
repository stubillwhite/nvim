"--format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %aN%C(reset)%C(bold yellow)%d%C(reset)' 
"| * 40d3991 - (4 years, 5 months ago) Setting version to 1.0.10-SNAPSHOT - Jenkins


syn match gitLgLine       /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLgHead       /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\> - ([^)]\+)\( ([^)]\+)\)\? \)\?/ contained containedin=gitLgLine
syn match gitLgDate       /(\u\l\l \u\l\l \d\=\d \d\d:\d\d:\d\d \d\d\d\d)/ contained containedin=gitLgHead nextgroup=gitLgRefs skipwhite
syn match gitLgRefs       /([^)]*)/ contained containedin=gitLgHead
syn match gitLgGraph      /^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite
syn match gitLgCommit     /^[^-]\+- / contained containedin=gitLgHead nextgroup=gitLgDate skipwhite
syn match gitLgIdentity   / - [^>]*$/ contained containedin=gitLgLine
hi def link gitLgGraph    Comment
hi def link gitLgDate     gitDate
hi def link gitLgRefs     gitReference
hi def link gitLgIdentity gitIdentity
