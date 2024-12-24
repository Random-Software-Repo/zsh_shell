#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH whois helpers 
##	helpers for looking up data through whois
##
##*********************************************
##*********************************************
#


# lookup ip address in Europe
alias weu='whois -h whois.ripe.net '

# lookup ip address in North America
alias wna='whois -h whois.arin.net '

# lookup ip address in the Caribbean and South/Latin America
alias wla='whois -h whois.lacnic.net '
alias wsa=wla

