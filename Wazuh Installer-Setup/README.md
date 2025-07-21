# Wazuh Installation Script

## Purpose

This script automates the installation and configuration of Wazuh, a powerful security monitoring and threat detection platform. It simplifies the process of setting up Wazuh components across multiple nodes, including the indexer, manager, and dashboard.

## Basic Working

1. **User Input**: The script prompts the user for IP addresses of the indexer, manager, and dashboard nodes.
2. **File Download**: It downloads the necessary installation scripts and configuration files.
3. **Configuration**: The script modifies the configuration file to include the specified IP addresses.
4. **Installation Process**: It initializes and sets up Wazuh components, retrieves the admin password, and performs connectivity tests.
5. **Output**: Finally, it provides the user with the dashboard URL and login credentials.

## Features

- **Automated Installation**: Sets up Wazuh components with minimal user intervention.
- **Dynamic Configuration**: Automatically updates configuration files based on user input.
- **Password Retrieval**: Extracts and displays the admin password for easy access.
- **Connectivity Testing**: Verifies the setup by checking the status of the indexer and cluster nodes.
- **User-Friendly Output**: Provides clear instructions and information upon completion.

## How to Use

### Prerequisites

- A compatible operating system (e.g., Ubuntu, CentOS).
- Sufficient permissions to execute installation commands.
- Internet access to download necessary files.

### Steps

1. **Download the Script**: Save the script to your local machine.

2. **Make the Script Executable**:
   ```bash
   chmod +x <script-name>.sh
   ```

3. **Run the Script**:
   ./<script.sh

4. **Enter IP Addresses**: When prompted, input the IP addresses for:
   - Indexer Node
   - Manager Node
   - Dashboard Node

Note: If setting it up on the single machine, just enter you current machine's IP for all three of them.

5. **Completion**: After the script completes, note the admin password and dashboard URL provided in the output.

### Example

$ ./wazuh-install.sh
Enter Indexer node IP: 192.168.1.10
Enter Manager node IP: 192.168.1.20
Enter Dashboard node IP: 192.168.1.30
🟢 Admin password: your_password_here
✅ All set! Dashboard URL: https://192.168.1.30
   Username: admin
   Password: your_password_here
   (Expect self-signed certificate warnings.)
