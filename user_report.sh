#!/bin/bash

echo "=== USER STATISTICS ==="

total_users=$(wc -l < /etc/passwd)
echo "Total Users: $total_users"

system_users=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)
echo "System Users (UID < 1000): $system_users"

regular_users=$(awk -F: '$3 >= 1000 {count++} END {print count}' /etc/passwd)
echo "Regular Users (UID >= 1000): $regular_users"

logged_in=$(who | wc -l)
echo "Currently Logged In: $logged_in"

echo ""
echo "=== REGULAR USER DETAILS ==="
printf "%-15s %-6s %-20s %-15s %-20s\n" "Username" "UID" "Home Directory" "Shell" "Last Login"
printf "%-15s %-6s %-20s %-15s %-20s\n" "--------" "---" "--------------" "-----" "----------"


awk -F: '$3 >= 1000 {print $1,$3,$6,$7}' /etc/passwd | while read user uid home shell
do
    last_login=$(lastlog -u "$user" | awk 'NR==2 {print $4,$5,$6,$7,$8}')
    printf "%-15s %-6s %-20s %-15s %-20s\n" "$user" "$uid" "$home" "$shell" "${last_login:-Never}"
done

echo ""
echo "=== GROUP INFORMATION ==="


while IFS=: read group x gid members
do
    if [ -z "$members" ]; then
        count=0
    else
        count=$(echo "$members" | tr ',' '\n' | wc -l)
    fi
    echo "$group - $count members"
done < /etc/group

echo ""
echo "=== SECURITY ALERTS ==="

uid_zero=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
echo "Users with root privileges (UID 0):"
echo "$uid_zero" | sed 's/^/ - /'


