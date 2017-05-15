V=20140119

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 archlinux32{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/archlinux32{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=archlinux32-keyring-$(V)/ $(V) | gzip -9 > archlinux32-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent archlinux32-keyring-$(V).tar.gz

upload:
	scp archlinux32-keyring-$(V).tar.gz archlinux32-keyring-$(V).tar.gz.sig leming@archlinux32.org:www/src

.PHONY: install uninstall dist upload
