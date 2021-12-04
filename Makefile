REPO_ROOT=$(shell git rev-parse --show-toplevel)

LAST_ROAM_EXPORT_ZIP?=$(shell ls $(REPO_ROOT)/_roam_exports/*.zip | tail -n1)

all: harvest-sites-from-brain

clean-unzipped-export:
	rm -rf $(REPO_ROOT)/_unzipped_export/

unzip-export: $(LAST_ROAM_EXPORT_ZIP) clean-unzipped-export
	unzip $(LAST_ROAM_EXPORT_ZIP) -d $(REPO_ROOT)/_unzipped_export/

harvest-sites-from-brain: unzip-export
	$(REPO_ROOT)/hack/harvest-sites-from-brain.sh
