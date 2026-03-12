#!/bin/bash

# --- Configuration & Paths ---
CONFIG_DIR="./config"
HOSTS_FILE="$CONFIG_DIR/hosts.txt"
RELATORIO_DIR="../relatorios"
LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/service.log"

# --- Infrastructure Setup (The "Self-Healing" Part) ---
# Create all necessary directories at once
mkdir -p "$CONFIG_DIR" "$RELATORIO_DIR" "$LOG_DIR"

# Create a template hosts file if missing
if [ ! -f "$HOSTS_FILE" ]; then
    echo "8.8.8.8" > "$HOSTS_FILE"
    echo "google.com" >> "$HOSTS_FILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO: Created default hosts.txt" >> "$LOG_FILE"
fi

# Initialize Log File if it doesn't exist
touch "$LOG_FILE"

# --- Function for Logging ---
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log_message "INFO: Starting connectivity check."

# --- Main Script Logic ---
DATA=$(date +"%Y-%m-%d")
HORA=$(date +"%H:%M:%S")
RELATORIO="$RELATORIO_DIR/relatorio_${DATA}.txt"

total=0
up=0
down=0
instavel=0

# Start Report
{
    printf "RELATORIO DE CONECTIVIDADE\n"
    printf "Data: %s | Hora: %s\n\n" "$DATA" "$HORA"
    printf "%-15s %-10s %-10s\n" "HOST" "STATUS" "TENTATIVAS"
} > "$RELATORIO"

# Process Hosts
while read -r host || [[ -n "$host" ]]
do
    [[ -z "$host" || "$host" =~ ^# ]] && continue # Skip empty lines and comments

    total=$((total+1))
    tentativa=1
    sucesso=0

    log_message "DEBUG: Checking $host..."

    until [ $tentativa -gt 3 ]
    do
        if ping -c 1 -W 1 "$host" > /dev/null 2>&1
        then
            sucesso=1
            break
        fi
        log_message "WARN: Attempt $tentativa failed for $host"
        tentativa=$((tentativa+1))
    done

    # Determine Status
    if [ $sucesso -eq 1 ]; then
        if [ $tentativa -eq 1 ]; then
            status="UP"
            up=$((up+1))
        else
            status="INSTAVEL"
            instavel=$((instavel+1))
            log_message "NOTICE: $host is UNSTABLE (reached on attempt $tentativa)"
        fi
    else
        status="DOWN"
        down=$((down+1))
        tentativa=3
        log_message "ERROR: $host is DOWN after 3 attempts"
    fi

    printf "%-15s %-10s %d/3\n" "$host" "$status" "$tentativa" >> "$RELATORIO"

done < "$HOSTS_FILE"

# Finalize Report
printf "\nTOTAL: %d | UP: %d | DOWN: %d | INSTAVEL: %d\n" \
"$total" "$up" "$down" "$instavel" >> "$RELATORIO"

log_message "INFO: Report generated at $RELATORIO. Process finished."

# Display result to terminal
cat "$RELATORIO"
