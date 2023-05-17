all: rfsoc2x2 rfsoc4x2 zcu111 zcu208 tarball

rfsoc2x2:
	$(MAKE) -C boards/RFSoC2x2/rfsoc_sdfec/

zcu208:
	$(MAKE) -C boards/ZCU208/rfsoc_sdfec/

rfsoc4x2:
	$(MAKE) -C boards/RFSoC4x2/rfsoc_sdfec/

zcu111:
	$(MAKE) -C boards/ZCU111/rfsoc_sdfec/

tarball:
	tar -czvf rfsoc_sdfec.tar.gz .
