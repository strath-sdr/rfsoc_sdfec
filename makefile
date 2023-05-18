all: rfsoc2x2 rfsoc4x2 zcu111 zcu208 tarball

rfsoc2x2:
	$(MAKE) -C boards/RFSoC2x2/strath_sdfec/
	$(MAKE) -C boards/RFSoC2x2/strath_sdfec_hw/

zcu208:
	$(MAKE) -C boards/ZCU208/strath_sdfec/
	$(MAKE) -C boards/ZCU208/strath_sdfec_hw/

rfsoc4x2:
	$(MAKE) -C boards/RFSoC4x2/strath_sdfec/
	$(MAKE) -C boards/RFSoC4x2/strath_sdfec_hw/

zcu111:
	$(MAKE) -C boards/ZCU111/strath_sdfec/
	$(MAKE) -C boards/ZCU111/strath_sdfec_hw/

tarball:
	tar -czvf rfsoc_sdfec.tar.gz .
