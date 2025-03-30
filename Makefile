ASSETS_SRC := assets
ASSETS_DEST := example/build/assets

copy-assets:
	mkdir -p $(ASSETS_DEST)
	cp -r $(ASSETS_SRC)/* $(ASSETS_DEST)/

.PHONY: copy-assets