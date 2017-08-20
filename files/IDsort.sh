#!/bin/bash
# Find all ID's and sort them in order. Remove any duplicate entries and sort in ascending or descending orders. 
# Find min and max ID values.

# Find all directories 3 levels deep in Customer logs.
# Note that this path is for hwy90 server and GCC location.
#y=$(find ~/2TB/GCC/Files/CustomerLogs/ -maxdepth 3 -type d)
y=$(find ~/GCC/Files/CustomerLogs/ -maxdepth 3 -type d)

# Filter those directories for ones that have 'ID' and exclude dataBackup dirs.
z=$(echo "${y}" | grep "ID" | grep -v "dataBackup" | cut -d '/' -f 8) # field 9 on hwy90 server

# This trims off 'ID' from the numbers. 
x=$(echo "${z}" | cut -d 'D' -f 2)

# This will list what ID directories we have in ascending order. 
# Note that there are missing numbers as certain IDs were skipped or do not exist.
w=$(echo "${x}" | sort -V)

# pipe results of the sorted numbers to less for easy viewing.
echo "${w}" | less

# Find min value
min=$(echo "${w}" | head -1)

# Find max value
max=$(echo "${w}" | tail -1)


# echo min and max values
echo "Your Min ID directory found is: "${min}""
echo "Your Max ID directory found is: "${max}""

# Once range is defined, ex. ID1 ID200. Make a loop that checks for 1..200 if each ID is
# true or not. Does that directory exist? Or if false, make an error output that displays the
# missing ID numbers so that we are aware. ID99 is missing from the current list, as that 
# directory does not exist, so it has either been deleted or was skipped during creation. 


