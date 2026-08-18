DICT_URL := https://github.com/skk-dev/dict.git
DICT_FILES := /SKK-JISYO.L

.PHONY: dict
dict:
	@mkdir -p dict
	@if [ ! -e dict/.git ]; then \
		git -C dict init -q; \
		git -C dict remote add origin $(DICT_URL); \
	fi
	git -C dict sparse-checkout set --no-cone $(DICT_FILES)
	git -C dict fetch --depth 1 --filter=blob:none origin $$(git rev-parse :dict)
	git -C dict checkout -q --detach FETCH_HEAD
	git submodule init dict
	git submodule absorbgitdirs dict
