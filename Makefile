REPO_ROOT=$(shell git rev-parse --show-toplevel)

LAST_ROAM_EXPORT_ZIP?=$(shell ls $(REPO_ROOT)/_roam_exports/*.zip | tail -n1)

all: move-sites-to-repos

clean-sites:
	rm -rf $(REPO_ROOT)/_sites
clean-unzipped-export:
	rm -rf $(REPO_ROOT)/_unzipped_export/

unzip-export: $(LAST_ROAM_EXPORT_ZIP) clean-unzipped-export
	unzip $(LAST_ROAM_EXPORT_ZIP) -d $(REPO_ROOT)/_unzipped_export/

harvest-sites-from-brain: unzip-export clean-sites
	$(REPO_ROOT)/hack/harvest-sites-from-brain.sh

move-sites-to-repos: harvest-sites-from-brain
	$(REPO_ROOT)/hack/move-sites-to-repos.sh
