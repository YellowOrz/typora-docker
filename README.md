[English](./README-en.md)

# Typora Docker

本镜像基于linuxserver/baseimage-kasmvnc:ubuntunoble，安装typora，通过浏览器访问

## 感谢以下项目:

[https://github.com/linuxserver/docker-baseimage-kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc)                
[https://github.com/linuxserver/docker-freecad](https://github.com/linuxserver/docker-freecad)  
[https://github.com/linuxserver/docker-gimp](https://github.com/linuxserver/docker-gimp)


## 部署docker

- 编译镜像：运行如下命令，其中会自动下载最新的typora安装包
  
  - 想要指定安装包版本，添加参数例如`--build-arg 1.10.7`
  
  - 若下载失败，可以将Dockerfile中的下载地址换成可用的地址。例如，把https://typora.io换成https://typoraio.cn，把https://download.typora.io换成https://download2.typoraio.cn

  ```sh
  docker build -t orz2333/typora:latest -f Dockerfile .
  ```

  如果不想自己编译，也可以从[docker hub](https://hub.docker.com/repository/docker/orz2333/typora)上拉取

  ```bash
  docker pull orz2333/typora:latest
  ```

- 创建typora容器

  ```bash
    docker create --name=typora \
        --cap-add=SYS_ADMIN \
        --cap-add=SYS_NICE \
        --security-opt seccomp=unconfined \
        -p 自定义端口:3000 \
        -v 自定义路径:/config \
        --restart unless-stopped \
        orz2333/typora:latest
  ```

  > --cap-add和--security-opt是为了解决报错"Failed to move to new namespace: PID namespaces supported, Network namespace supported, but failed: errno = Operation not permitted"，来自DeepSeek R1

  如果想要支持中文，需要添加几个环境变量，完整命令如下，其他语言（日文、韩文等）参考[这里](https://github.com/linuxserver/docker-baseimage-kasmvnc/tree/master?tab=readme-ov-file#language-support---internationalization)

  ```bash
    docker create --name=typora \
        --cap-add=SYS_ADMIN \
        --cap-add=SYS_NICE \
        --security-opt seccomp=unconfined \
        -p 自定义端口:3000 \
        -v 自定义路径:/config \
        -e DOCKER_MODS="linuxserver/mods:universal-package-install" \
        -e INSTALL_PACKAGES="fonts-noto-cjk" \
        -e LC_ALL="zh_CN.UTF-8" \
        --restart unless-stopped \
        orz2333/typora:latest
  ```

  > 环境变量的详细说明见[linuxserver/docker-baseimage-kasmvnc](https://github.com/linuxserver/docker-baseimage-kasmvnc/tree/master?tab=readme-ov-file#options)

- 运行typora容器：

  ```bash
  docker start typora
  ```

  若添加了其他语言，第一次运行时间会比较久，因为会安装字体

- 停止typora容器

  ```bash
  docker stop typora
  ```

- 删除typora容器

  ```bash
  docker rm typora
  ```

- 删除镜像

  ```bash
  docker image typora-zh
  ```

## 使用说明

- 在浏览器中访问ip:3000（即上面的“自定义端口”），即可使用typora
  
- 若想要使用本地输入法（比如中文输入法），侧边工具栏=>设置=>启用本地输入法