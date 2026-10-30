#!/bin/bash

LOG_FILE="network.report.log"
exec > >(tee -a "$LOG_FILE") 2>&1

check_ip() {
    echo
    echo "===== 1. NETWORK INTERFACE AND IP ====="
    ip -4 addr show scope global
}

check_mac() {
    echo
    echo "===== 2. MAC ADDRESS ====="
    ip link show
}

check_gateway() {
    echo
    echo "===== 3. DEFAULT GATEWAY ====="
    ip route show default
}

check_internet() {
    echo
    echo "===== 4. INTERNET CONNECTIVITY ====="
    read -r -p "Enter test IP address: " TEST_IP

    if [[ -z "$TEST_IP" ]]; then
        echo "WARNING: IP address cannot be empty"
    else
        PING_RESULT=$(ping -c 4 -W 2 "$TEST_IP" 2>&1)
        PING_STATUS=$?
        echo "$PING_RESULT"

        if [[ $PING_STATUS -eq 0 ]]; then
            echo "PASS: Internet connectivity is working"
        else
            echo "WARNING: Internet connectivity check failed"
        fi
    fi
}

check_dns() {
    echo
    echo "===== 5. DNS RESOLUTION ====="
    read -r -p "Enter domain name: " DOMAIN

    if [[ -z "$DOMAIN" ]]; then
        echo "WARNING: Domain name cannot be empty"
    else
        DNS_RESULT=$(getent hosts "$DOMAIN" 2>&1)

        if [[ -n "$DNS_RESULT" ]]; then
            echo "$DNS_RESULT"
            echo "PASS: DNS resolution successful"
        else
            echo "WARNING: DNS resolution failed"
        fi
    fi
}

check_https() {
    echo
    echo "===== 6. HTTPS CONNECTIVITY ====="
    read -r -p "Enter website URL: " WEBSITE

    if [[ -z "$WEBSITE" ]]; then
        echo "WARNING: Website URL cannot be empty"
    elif [[ "$WEBSITE" != https://* ]]; then
        echo "WARNING: Please enter a valid HTTPS URL"
    else
        HTTPS_RESULT=$(curl -I -sS --connect-timeout 5 --max-time 10 "$WEBSITE" 2>&1)
        CURL_STATUS=$?
        echo "$HTTPS_RESULT"

        if [[ $CURL_STATUS -eq 0 ]]; then
            echo "PASS: HTTPS connection successful"
        else
            echo "WARNING: HTTPS connection failed"
        fi
    fi
}

check_ports() {
    echo
    echo "===== 7. LISTENING PORTS ====="
    ss -tuln
}

check_ram() {
    echo
    echo "===== 8. RAM MONITORING ====="
    free -h
}

check_disk() {
    echo
    echo "===== 9. DISK MONITORING ====="
    read -r -p "Enter filesystem path: " FILESYSTEM

    if [[ -z "$FILESYSTEM" ]]; then
        echo "WARNING: Filesystem path cannot be empty"
    elif [[ ! -e "$FILESYSTEM" ]]; then
        echo "WARNING: Filesystem path does not exist"
    else
        df -h "$FILESYSTEM"
        echo "PASS: Disk information collected"
    fi
}

check_uptime() {
    echo
    echo "===== 10. SYSTEM UPTIME ====="
    uptime
}

run_all() {
    echo
    echo "===== RUN ALL MONITORING ====="
    check_ip
    check_mac
    check_gateway
    check_internet
    check_dns
    check_https
    check_ports
    check_ram
    check_disk
    check_uptime
    echo
    echo "===== ALL CHECKS COMPLETED ====="
}

echo "Date: $(date)"
echo "Hostname: $(hostname)"

while true
do
    echo
    echo "======================================"
    echo "     LINUX NETWORK MONITORING SYSTEM"
    echo "======================================"

    echo "1. Network Interface and IP"
    echo "2. MAC Address"
    echo "3. Default Gateway"
    echo "4. Internet Connectivity"
    echo "5. DNS Resolution"
    echo "6. HTTPS Connectivity"
    echo "7. Listening Ports"
    echo "8. RAM Monitoring"
    echo "9. Disk Monitoring"
    echo "10. System Uptime"
    echo "11. Run All Monitoring"
    echo "12. Exit"

    echo
    read -r -p "Enter your choice: " choice

    case "$choice" in
        1) check_ip ;;
        2) check_mac ;;
        3) check_gateway ;;
        4) check_internet ;;
        5) check_dns ;;
        6) check_https ;;
        7) check_ports ;;
        8) check_ram ;;
        9) check_disk ;;
        10) check_uptime ;;
        11) run_all ;;
        12)
            echo "Monitoring program closed"
            break
            ;;
        *)
            echo "Invalid choice! Select 1 to 12."
            ;;
    esac
done
