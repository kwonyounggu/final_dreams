# Makefile for deploying Flutter web app to GitHub Pages

#>make deploy-web OUTPUT=kwonyounggu.github.io

# See here for Makefile info
# https://chatgpt.com/c/690b677f-3a80-832b-afdd-bb6c0a78f34e
# https://www.google.com/search?q=a+flutter+web+project+in+vscode+environment+needs+to+make+a+Makefile+to+deploy+to+github&sourceid=chrome&ie=UTF-8&udm=50&aep=48&cud=0&qsubts=1769718696939&source=chrome.crn.obic&mtid=qcN7adOKIriv5NoPvtvsqQk&mstk=AUtExfDmbuqlUdiFfOudtDzACybyqwCAUg1SuCaYCmH-qmQ8YhUlPoOi1QsMGy9-Zt1gVRUo_rHjzvCjfyFcaRO81NGpL_8hcaDShnXCBZsP25-PTEjoBDTSYQHCnHjlET8z6KX2Ernl_ebhMkJ8SWMBjwUEeHI2XTPBAUA&csuir=1

# Update These Variables
#BASE_HREF = '/drskwon/'  #represent thename of repository
#GITHUB_REPO = git@github.com:jitendrakohar/Jitendra_kohar.git
BASE_HREF = /$(OUTPUT)/
GITHUB_USER = kwonyounggu
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

deploy-web:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif
	@echo "Clean existing repository..." #print the log
	flutter clean  #flutter command

	@echo "Getting packages..."  #print the log
	flutter pub get #flutter command

	@echo "Building for web..."  #print the log
	flutter build web --base-href $(BASE_HREF) --release   #this command using the Base_Href in your index.htm and base_href value is getting from the above variable

	@echo "Deploying to git repository"
	cd build/web && \
	echo "webmonster.ca" > CNAME && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u --force origin main

	cd ../..
	@echo "🟢 Finished Deploy"

.PHONY: deploy-web