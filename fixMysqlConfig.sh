#!/bin/sh

# adding setting lower_case_table_names=1

# remove any line containing the 'lower_case_table_names' setting
sed --in-place 's/^\s*lower_case_table_names.*$//' $1

# add lower_case_table_names after [mysqld]
sed --in-place 's/\[mysqld\]/\[mysqld\]\nlower_case_table_names\t= 1/' $1

#crash if mysqld not found

COUNT=$(sudo sed '/\[mysqld\]/!d' $1 | sudo sed -n "$=")

if [ -z $COUNT ] || [ $COUNT -ne 1 ]
then
	echo "Expected to find [mysqld] in $1" >&2
	exit 1
fi
