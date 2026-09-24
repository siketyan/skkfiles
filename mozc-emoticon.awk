# Convert Mozc's emoticon.tsv into an SKK dictionary.
# Based on https://github.com/Endered/skk-emoticon-from-mozc

# gsub's handling of backslashes in the replacement differs across awk implementations.
function replace(s, from, to,    r, i) {
	while ((i = index(s, from)) > 0) {
		r = r substr(s, 1, i - 1) to
		s = substr(s, i + length(from))
	}
	return r s
}

BEGIN {
	FS = "\t"
	print ";; -*- mode: fundamental; coding: utf-8 -*-"
	print ";; okuri-ari entries."
	print ";; okuri-nasi entries."
}

NR > 1 && $1 != "" {
	c = $1
	if (c ~ /[\/;]/) {
		c = replace(replace(c, "/", "\\057"), ";", "\\073")
		c = "(concat \"" c "\")"
	}

	n = 0
	delete seen
	split($2 " かお かおもじ", ks, " ")
	for (i = 1; i in ks; i++) {
		if (ks[i] == "" || ks[i] ~ /[A-Za-z]/ || ks[i] in seen) continue
		seen[ks[i]] = 1
		keys[++n] = ks[i]
	}

	for (i = 1; i <= n; i++) {
		a = ""
		for (j = 1; j <= n; j++) if (j != i) a = a (a == "" ? "" : " ") keys[j]
		out[keys[i]] = out[keys[i]] "/" c (a == "" ? "" : ";" a)
	}
}

END {
	for (k in out) print k " " out[k] "/" | "LC_ALL=C sort"
	close("LC_ALL=C sort")
}
