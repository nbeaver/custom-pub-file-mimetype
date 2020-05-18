MIMETYPE_KEY:=application/pgp-keys
MIMETYPE_MS :=application/vnd.ms-publisher
MIMEINFO:=pgp-keys.xml
DESKTOP:=org.kde.kate.desktop
PUB_KEY:=intel-product-security-incident-response-team-current.pub
PUB_MS:=testPUBLISHER.pub

# See shared-mime-info:
# /usr/share/mime/packages/freedesktop.org.xml

.PHONY: open
open :
	xdg-open $(PUB_KEY)
	xdg-open $(PUB_MS)

.PHONY: open-kde
open-kde :
	kde-open5 $(PUB_KEY)
	kde-open5 $(PUB_MS)

.PHONY: open-gio
open-gio :
	gio open $(PUB_KEY)
	gio open $(PUB_MS)

.PHONY: get-mimetype
get-mimetype :
	-xdg-mime query filetype $(PUB_KEY)
	-mimetype $(PUB_KEY)
	-gio info -a 'standard::content-type' $(PUB_KEY)
	-file -i $(PUB_KEY)
	-xdg-mime query filetype $(PUB_MS)
	-mimetype $(PUB_MS)
	-gio info -a 'standard::content-type' $(PUB_MS)
	-file -i $(PUB_MS)

check-handler:
	-xdg-mime query default $(MIMETYPE_KEY)
	-gio mime $(MIMETYPE_KEY)
	-xdg-mime query default $(MIMETYPE_MS)
	-gio mime $(MIMETYPE_MS)

.PHONY: install
install :
	xdg-mime install --mode user $(MIMEINFO)
	xdg-mime default $(DESKTOP) $(MIMETYPE_KEY)
	update-mime-database ~/.local/share/mime
