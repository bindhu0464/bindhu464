#!/bin/bash

# ===============================
# LOG FILE ANALYZER SCRIPT
# ===============================


if [ $# -ne 1 ]; then
    echo "Usage: ./q3_log_analyzer.sh <logfile>"
    exit 1
fi

logfile="$1"


if [ ! -f "$logfile" ]; then
    echo "Error: File '$logfile' not found."
    exit 1
fi

if [ ! -s "$logfile" ]; then
    echo "Error: Log file is empty."
    exit 1
fi

echo ""
echo "=== LOG FILE ANALYSIS ==="
echo "Log File: $logfile"
echo ""

total_entries=$(wc -l < "$logfile")
echo "Total Entries: $total_entries"

echo ""
echo "Unique IP Addresses:"
unique_ips=$(awk '{print $1}' "$logfile" | sort | uniq)
ip_count=$(echo "$unique_ips" | wc -l)
echo "Count: $ip_count"
echo "$unique_ips" | sed 's/^/ - /'

echo ""
echo "Status Code Summary:"
awk '{print $NF}' "$logfile" | sort | uniq -c | \
while read count code
do
    echo " $code: $count requests"
done

echo ""
echo "Most Frequently Accessed Page:"
awk -F'"' '{print $2}' "$logfile" | awk '{print $2}' | \
sort | uniq -c | sort -rn | head -1 | \
awk '{print " "$2" - "$1" requests"}'

echo ""
echo "Top 3 IP Addresses:"
awk '{print $1}' "$logfile" | sort | uniq -c | sort -rn | head -3 | \
awk '{print NR". "$2" - "$1" requests"}'
