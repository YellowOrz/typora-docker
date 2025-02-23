[中文](./README.md)

# Typora Docker

> Translated by Deepseek R1

This image is based on linuxserver/baseimage-kasmvnc:ubuntunoble with Typora installed, accessible via web browser.

## Credits

[https://github.com/linuxserver/docker-baseimage-kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc)  
[https://github.com/linuxserver/docker-freecad](https://github.com/linuxserver/docker-freecad)  
[https://github.com/linuxserver/docker-gimp](https://github.com/linuxserver/docker-gimp)

## Docker Deployment

- **Build Image** 
  - Automatically downloads latest Typora package
  - Specify version: Add build arg like `--build-arg 1.10.7`
  - If download fails, modify download URLs in Dockerfile (e.g., change https://typora.io to https://typoraio.cn, change https://download.typora.io to https://download2.typoraio.cn)
  ```sh
  docker build -t orz2333/typora:latest -f Dockerfile .
  ```
  Or you can pull pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/orz2333/typora):

  ```bash
  docker pull orz2333/typora:latest
  ```

- **Create Container**
  ```bash
  docker create --name=typora \
      --cap-add=SYS_ADMIN \
      --cap-add=SYS_NICE \
      --security-opt seccomp=unconfined \
      -p CUSTOM_PORT:3000 \
      -v CUSTOM_PATH:/config \
      --restart unless-stopped \
      orz2333/typora:latest
  ```
  > The --cap-add and --security-opt parameters resolve namespace permission errors, from DeepSeek R1

  To support Chinese, you need to add several environment variables. The complete command is as follows. For other languages (such as Japanese and Korean), refer to [here](https://github.com/linuxserver/docker-baseimage-kasmvnc/tree/master?tab=readme-ov-file#language-support---internationalization).
  ```bash
  docker create --name=typora \
      --cap-add=SYS_ADMIN \
      --cap-add=SYS_NICE \
      --security-opt seccomp=unconfined \
      -p CUSTOM_PORT:3000 \
      -v CUSTOM_PATH:/config \
      -e DOCKER_MODS="linuxserver/mods:universal-package-install" \
      -e INSTALL_PACKAGES="fonts-noto-cjk" \
      -e LC_ALL="zh_CN.UTF-8" \
      --restart unless-stopped \
      orz2333/typora:latest
  ```
  > Detailed environment variables: [linuxserver/docker-baseimage-kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc)

- **Container Management**
  ```bash
  # Start
  docker start typora
  
  # Stop
  docker stop typora
  
  # Remove container
  docker rm typora
  
  # Remove image
  docker rmi typora-zh
  ```

## Usage

1. Access via browser: `IP:3000` (using your custom port)
2. For local input method (e.g., Chinese IME):
   - Sidebar → Settings → Enable Local Input Method