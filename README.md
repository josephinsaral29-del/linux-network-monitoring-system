# Linux Network Monitoring & Troubleshooting System

## Project Overview
This project is a Bash-based Linux network monitoring system.
It collects important network and system information and saves the monitoring output in a log file.

## Technologies Used
- Ubuntu Linux
- Bash Shell Scripting
- Networking Commands
- WSL (Windows Subsystem for Linux)

## Features
1. Network interface and IPv4 address monitoring
2. MAC address detection
3. Default gateway identification
4. Internet connectivity checking using ping
5. DNS resolution checking
6. HTTPS connectivity checking using curl
7. Listening TCP and UDP port monitoring
8. RAM usage monitoring
9. Disk usage monitoring
10. System uptime monitoring

## Project Files
- network.monitor.sh – Main monitoring script
- network.report.log – Monitoring output log
- README.md – Project documentation

## How to Run

Clone the repository:

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

Open the project directory:

```bash
cd linux-checking-monitor
```

Give execution permission:

```bash
chmod +x network.monitor.sh
```

Run the project:

```bash
./network.monitor.sh
```

## Output
The script displays network and system information and saves the output in network.report.log.

## Learning Outcomes
- Linux command-line operations
- Bash shell scripting
- Network monitoring and troubleshooting
- IP and MAC address identification
- DNS and HTTPS connectivity testing
- System resource monitoring
