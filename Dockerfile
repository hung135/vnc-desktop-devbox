# Use dorowu/ubuntu-desktop-lxde-vnc as the base image
FROM dorowu/ubuntu-desktop-lxde-vnc

RUN sed -i '/dl\.google\.com\/linux\/chrome\/deb/ s/^/#/' /etc/apt/sources.list.d/google-chrome.list 
# Install SSL support
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends ssl-cert && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Generate a self-signed SSL certificate and store it in the correct Nginx path
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=California/L=San Francisco/O=Example Company/OU=IT Department/CN=example.com"

# Set default environment variables
ENV USER abcuser
ENV PASSWORD abc123
RUN apt-get install wget gpg
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN rm -f packages.microsoft.gpg
RUN sudo apt install apt-transport-https -y
RUN sudo  apt update -y
RUN sudo apt install code -y # or code-insiders
RUN sudo sed -i 's|Exec=/usr/share/code/code|Exec=/usr/share/code/code --no-sandbox|g' /usr/share/applications/code.desktop
RUN apt-get install openjdk-11-jdk unzip -y
# Download and install NetBeans 17
RUN wget https://dlcdn.apache.org/netbeans/netbeans/17/netbeans-17-bin.zip -P /tmp && \
    unzip /tmp/netbeans-17-bin.zip -d /opt && \
    rm /tmp/netbeans-17-bin.zip

# Add NetBeans to PATH
ENV PATH $PATH:/opt/netbeans-17/bin
# Create NetBeans desktop launcher
RUN echo '[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=NetBeans\n\
Comment=NetBeans IDE\n\
Exec=/opt/netbeans/bin/netbeans\n\
Icon=/opt/netbeans/nb/netbeans.png\n\
Terminal=false\n\
Categories=Development;IDE;\n\
MimeType=text/plain;\n\
StartupNotify=true' > /usr/share/applications/netbeans.desktop

