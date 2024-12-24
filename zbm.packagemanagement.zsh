#!/usr/bin/zsh

## package management aliases
if (( $+commands[dnf] ))
then
	## Assume this is an RPM based system using dnf as the package manager
	alias -g 'NOWEAK=--setopt=install_weak_deps=False'
	alias -g 'TREPOS=--enablerepo=updates-testing --enablerepo=rpmfusion-free-updates-testing --enablerepo=rpmfusion-nonfree-updates-testing'
	alias -g "XKERNEL=--exclude='kernel*' --exclude='kmod*'"
	alias dfiles='rpm -ql'
	alias whatprovides='sudo dnf provides' #shows which package(s) installed a given file, if any
	alias what=whatprovides #shows which package(s) installed a given file, if any
	alias whatprovided='rpm -qf' #same as whatprovides, just using rpm directly rather than dnf
	alias lastinstalled='rpm -qa --queryformat "%{installtime} (%{installtime:date}) %{name} %{version} %{release} %{vendor}\n" | sort -n| tail -10'
	alias installdate=wheninstalled

	alias dnfl="dnf list"                       # List packages
	alias dnfli="dnf list installed"            # List installed packages
	alias dnfgl="dnf grouplist"                 # List package groups
	alias dnfp="dnf info"                       # Show package information
	alias dnfs="dnf search"                     # Search package
	alias dnfmc="sudo dnf makecache"                # Generate metadata cache

	## DNF Upgrade and install and remove aliases. Install / upgrade aliases
	## ignore weak dependencies
	alias dnfu="sudo dnf NOWEAK upgrade"               # Upgrade package(s)
	alias dnfi="sudo dnf NOWEAK install"               # Install package(s)
	alias dnfgi="sudo dnf NOWEAK groupinstall"         # Install package group
	alias dnfr="sudo dnf remove --noautoremove"                # Remove package(s)
	alias dnfgr="sudo dnf groupremove --noautoremove"          # Remove package group
	alias dnfc="sudo dnf clean all"             # Clean cache
	## Force cleaning of local dnf cache, and (thus) re-downloading all repo metadata before 
	## performing an update. Forced updates ignore weak dependencies and skip kernel updates
	#dnfuf : forced refresh update, exclude kernel updates (formerly ddu)
	alias dnfuf='sudo dnf clean all; sudo dnf NOWEAK XKERNEL upgrade'
	#dnfut : forced refresh update including testing repos, excluding kernels (formerly dduu)
	alias dnfut='sudo dnf TREPOS clean all; sudo dnf NOWEAK TREPOS XKERNEL upgrade'
	#:dnfuk : forced refresh update, including kernel updates (formerly dusk)
	alias dnfuk="sudo dnf clean all; sudo dnf NOWEAK update "


	## DNFGREP list all packages and greps over the list.
	function dnfgrep()
	{
		sudo dnf list |grep -i "${@}"
	}

elif (( $+commands[yum] ))
then
	## Assume this is an RPM based system using yum as the package manager
	alias yusk="sudo yum update --exclude=kernel\* --exclude=kmod\* "
	alias yus="sudo yum update --skip-broken"
	alias pfiles='rpm -ql'
	alias whatprovides='yum whatprovides' #shows which package(s) installed a given file, if any
	alias what=whatprovides #shows which package(s) installed a given file, if any
	alias whatprovided='rpm -qf' #same as whatprovides, just using rpm directly rather than yum
	alias lastinstalled='rpm -qa --queryformat "%{installtime} (%{installtime:date}) %{name} %{version} %{release} %{vendor}\n" | sort -n| tail -10'
	alias plast=lastinstalled
	alias installdate=wheninstalled
	alias pvendor='rpm -qa --queryformat "%{name} %{vendor}\n" | sort | uniq | grep  "^kernel " | awk "-Fkernel " "{print \$2}" '
	## YUMGREP list all packages and greps over the list.
	function yumgrep()
	{
		sudo yum list |grep -i "${@}"
	}
elif (( $+commands[apt] ))
then
	## assume this is a debian (or debian derived) distro using apt as the package manager
	alias apti='sudo apt install' #install package debian way
	alias aptr='sudo apt remove' #install package debian way
	#alias aptu='sudo apt upgrade' #upgrade all installed packages debian way
	function aptu
	{
		# "apt upgrade" will upgrade ALL packages. To upgrade a single (or specific list)
		# of packages, one uses "apt install [packages]" instead up upgrade. Not intuitive
		# at all, but it accomplishes the same thing. This function will, usually, do the
		# expected thing.
		if [[ $# -eq 0 ]]
		then
			sudo apt upgrade
		else
			sudo apt install "$@"
		fi
	}
	alias aptd='sudo apt update' #update apt repo metadata
	alias aptuu='sudo apt update;sudo apt upgrade' #update metadata upgrade all installed packages debian/ubuntu way
	alias aptus='sudo apt --skip-broken upgrade'
	alias aptli='apt list --installed' #list all installed packages from repos debian/ubuntu way
	alias aptfiles='dpkg-query -L'
	alias whatprovides='apt-file search'
	alias what=whatprovides #shows which package(s) installed a given file, if any
	alias lastinstalled='grep 'End-Date:' /var/log/apt/history.log| tail -1'
	alias plast=lastinstalled
	alias apth='sudo apt-mark hold' #locks specified packages to the current version (keeps them from being updated)
	alias aptuh='sudo apt-mark unhold' #unlocks specfied packages allowing them to be updated normally
	alias aptsh='apt-mark showhold' #list packages currently being held/locked
	function aptl
	{
		# list all packages from repos debian/ubuntu way
		# aptl will wrap all search parameters in \* wild cards
		apt list $(
		for d in "$@" 
		do
			# need a space after the print to separate multiple parameters
			if [[ "${d}" =~ "^-" ]]
			then
				print -n -- "${d} "
			else
				print -n -- "\*${d}\* "
			fi
		done)
	}
	function aptb
	{
		## upgrade or install packages from backports
		local stable=$(debian-distro-info --stable)
		if [[ "$#" -eq 0 ]]
		then
			print "Upgrading all packages from ${stable}-backports:"
			sudo apt -t ${stable}-backports upgrade
		else
			print "Upgrading / Installing $@ from ${stable}-backports:"
			sudo apt -t ${stable}-backports install "$@"
		fi
	}

	function aptlog
	{
		if [[ $# -eq 0 ]]
		then
			print "Usage:"
			print "	aptlog SEARCH_PATTER"
			print ""
			print "aptlog will search through apt logs (/var/log/apt/history.log*)"
			print "for records matching the SEARCH_PATTERN (regex) and print them"
			print "to standard out. Only a single pattern is supported at this time."
		else
			for d in /var/log/apt/history.log*(^-om)
			do
				filename="${d}"

				if [[ "${d:e}" == "gz" ]]
				then
					IFS=$'\n\n' parts=($(gunzip -c "${d}" 2> /dev/null ))
				else
					IFS=$'\n\n' parts=($(cat "${d}"))
				fi

				## apt history logs store records of each invocation on multiple lines, 
				## so we need to buffer each record in order to be able to print the while
				## record each time we find a match.
				## buffer = a buffer to hold elements of a apt histor record for a given invocation.
				buffer=
				## flag indicating whether we're currently in a record matching the command line param.
				found=

				for part in "$parts[@]"
				do
					if [[ "${part}" == "" ]]
					then
						## separator between apt history records is a double new line, so if we
						## have a blank element here, that indicates the beginning of a new record.
						## reset the record buffer and the "found" record flag
						buffer=
						found=
					else
						if [[ ${found} ]]
						then
							## if we're in a matching record (found), then print all remaining lines as we find them
							print "${part}"
						else
							## if we don't know if this record will match, concatonate the current record in buffer until we do know
							buffer="${buffer}\n${part}"
						fi
					fi
					## match the command line parameter with this line
					$(echo -n "${part}" | grep "${1}" &> /dev/null )
					if [[ $? -eq 0 ]]
					then
						#it matche, so print the buffer so far and set the found flag so the rest of the record will get printed
						print "${buffer}"
						found=1
					fi
				done
			done
		fi
	}
fi



if (( $+commands[rpm] ))
then
	function wheninstalled()
	{
		if [[ "${#@}" -gt 0 ]]
		then
			local grepexp="("
			local sep=""
			while [[ "$1" ]]
			do
				grepexp="${grepexp}${sep}${1}"
				sep="|"
				shift
			done
			grepexp="${grepexp})"
			#echo "grepexp=\"${grepexp}\""
			rpm -qa --queryformat '%{name} %{version} -- (%{installtime:date})\n' | grep -iP "${grepexp}"
			#rpm -qa --last | grep -i "$@"
		else
			echo "wheninstalled will extract the installation date for a package from the RPM database."
			echo "Usage:"
			echo "	wheninstalled <package-name> [<package-name> ...]"
			echo "where <package-name> is the partial or complete package name as stored in the RPM"
			echo "database. The query is case insensitive but otherwise, any perl-compatible reguaral"
			echo "expressions can be used."
		fi
	}

fi