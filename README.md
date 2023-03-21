# Docker Compose Configuration for VNC Desktop Devbox

This Docker Compose configuration provides a basic development environment with a desktop interface accessible via VNC. It uses the \`ubuntu:20.04\` base image and installs commonly used tools and applications such as the XFCE desktop environment, Firefox browser, Visual Studio Code, NetBeans, and various development tools.

## Usage

To use this configuration, follow these steps:

1. Clone the repository: \`git clone https://github.com/hung135/vnc-desktop-devbox.git\`.
2. Navigate to the project directory: \`cd vnc-desktop-devbox\`.
3. Start the container: \`docker-compose up -d\`.
4. Connect to the desktop interface using a VNC client on \`<your server ip>:5900\`. The default password is \`vncpassword\`.
5. Access noVNC web interface by visiting \`https://<your server ip>:6081\` in your web browser.

## Configuration

The following configuration options can be set in the \`.env\` file:

- \`VNC_PASSWORD\`: The password to use for VNC authentication. Defaults to \`vncpassword\`.
- \`VNC_RESOLUTION\`: The resolution to use for the VNC desktop. Defaults to \`1280x720\`.
- \`TZ\`: The timezone to use in the container. Defaults to \`America/Los_Angeles\`.

## Installed Applications

This configuration installs the following applications:

- XFCE desktop environment
- Firefox browser
- Visual Studio Code
- NetBeans
- Terminator terminal emulator
- Git version control system
- Python 3 and pip package manager
- Node.js JavaScript runtime and npm package manager

## Troubleshooting

If you are unable to connect to the VNC desktop interface or noVNC web interface, try the following steps:

- Check that the container is running: \`docker ps\`.
- Check the logs for any errors: \`docker logs vnc-desktop-devbox\`.
- Make sure that your VNC client and web browser are configured to use the correct IP address (\`<your server ip>\`) and ports (\`5900\` and \`6081\` respectively).
- Ensure that port \`6081\` is open and accessible from your network.
