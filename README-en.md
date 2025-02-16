# Typora Docker

This Docker image is based on jlesage/docker-baseimage-gui:ubuntu24.04, with Typora pre-installed. After deployment, you can access via web browser.

Note: The Chinese version includes additional steps for installing the Chinese input method and configuring Chinese language settings compared to the English version.

## Credits to following projects:

[https://github.com/jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)  
[https://github.com/gshang2017/docker/tree/master/baidunetdisk](https://github.com/gshang2017/docker/tree/master/baidunetdisk)

## Docker Deployment

- **Build Image**: Run the following command (will automatically download latest Typora package)
  
  ```sh
  docker build -t typora-en -f Dockerfile-en .
  ```
  > 

- **Create Container**
  ```bash
  docker create --name=typora \
        --cap-add=SYS_ADMIN \
        --cap-add=SYS_NICE \
        --security-opt seccomp=unconfined \
        -p 5800:5800 \
        -p 5900:5900 \
        -v ./data:/config \
        --restart unless-stopped \
        typora-en
  ```

- **Start Container**
  ```bash
  docker start typora
  ```

- **Stop Container**
  ```bash
  docker stop typora
  ```

- **Remove Container**
  ```bash
  docker rm typora
  ```

- **Remove Image**
  ```bash
  docker image rm typora-en
  ```

## Configuration Parameters

| Parameter | Description |
|:-|:-|
| `--name=typora` | Container name |
| `-p 5800:5800` | Web interface access port [ip:5800](ip:5800) |
| `-p 5900:5900` | VNC protocol port (optional if not using VNC client) [ip:5900](ip:5900) |
| `-v /path/to/config:/config` | Typora configuration directory |
| `-e VNC_PASSWORD=your_password` | VNC access password |
| `-e USER_ID=1000` | User ID (default: 1000) |
| `-e GROUP_ID=1000` | Group ID (default: 1000) |

For more parameters see:  
[https://registry.hub.docker.com/r/jlesage/baseimage-gui](https://registry.hub.docker.com/r/jlesage/baseimage-gui)