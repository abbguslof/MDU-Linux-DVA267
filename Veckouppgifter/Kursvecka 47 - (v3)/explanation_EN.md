This Bash script is designed to display system information based on the options provided. Here's a breakdown of how it works:

1. **`set -e`**: Enables the "exit on error" option. If any command in the script fails (returns a non-zero exit status), the script will terminate immediately.

2. **Command-line arguments parsing using a `while` loop and `case` statement:**
   - The script uses a `while` loop to iterate through the command-line arguments.
   - The `case` statement checks each argument (`$1`) and sets corresponding flags (`VERSION`, `IP`, `MAC`, `HELP`) accordingly.
   - The `shift` command is used to shift the argument list to the left, effectively removing the processed argument.

3. **Help Message:**
   - If the `--help` option is specified, or if no valid options are provided, a help message is displayed, and the script exits.

4. **Display System Information:**
   - The script checks each flag (`VERSION`, `IP`, `MAC`) and, if set to true, displays the corresponding system information.

5. **Linux Version:**
   - If the `--version` option is specified, it uses `lsb_release -d` to get the Linux distribution description.

6. **IP Address:**
   - If the `--ip` option is specified, it determines the network interface with internet connectivity (in this case, using `8.8.8.8` as a test IP). It then uses `ip addr` to get the IP address associated with that interface.

7. **MAC Address:**
   - If the `--mac` option is specified, it determines the network interface with internet connectivity and uses `ip addr` to get the MAC (Ethernet) address associated with that interface.

Overall, this script provides a flexible way to obtain specific system information based on user-specified options. The available options include displaying the Linux version, IP address, MAC address, or a combination of these. The `--help` option provides information on how to use the script.