

basedir = ${HOME}
dir = $(basedir)

default:
	@echo "Installs shells to $(dir)/.shells."
	@echo ""
	@echo "To install run:"
	@echo "	make install"
	@echo ""

install:
	@if [ ! -d "$(dir)/.shells" ]; \
	then \
		mkdir "$(dir)/.shells"; \
	fi
	@if [ -d "$(dir)/.shells" ]; \
	then \
		cp -f -p -r . "$(dir)/.shells/"; \
		cd ${dir};ln -sf "./.shells/.zshenv"; \
		cd ${dir};ln -sf "./.shells/.bash_logout"; \
		cd ${dir};ln -sf "./.shells/.bash_profile"; \
		cd ${dir};ln -sf "./.shells/.bashrc"; \
		cd ${dir};ln -sf "./.shells/.profile"; \
		cd ${dir};ln -sf "./.shells/.screenrc"; \
		rm "${dir}/.shells/.gitignore"; \
		rm "${dir}/.shells/Makefile"; \
	else \
		echo "Error: could not create $(dir)/.shells"; \
	fi

