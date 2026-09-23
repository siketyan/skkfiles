DEST := ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents

.PHONY: install
install:
	install -d $(DEST)/{Dictionaries,Settings}
	install ../dict/SKK-JISYO.L $(DEST)/Dictionaries/SKK-JISYO.L
	install ../skk-emoji-jisyo/SKK-JISYO.emoji.utf8 $(DEST)/Dictionaries/SKK-JISYO.emoji.utf8
	install ./kana-rule-azik-us.conf $(DEST)/Settings/kana-rule-azik-us.conf
