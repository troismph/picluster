# 安装说明

直接按 [官方文档](https://kubesphere.io/docs/installing-on-linux/introduction/multioverview/) 无法正常完成, 因为 ks-installer 没有 arm64 版镜像. 我们需要在经修改的 ks-installer 仓库中构建 arm64 镜像.

1. 确保已执行 git submodule update --recursive --init
1. 进入 ks-installer 目录, 按 README.arm.md 指示操作, 构建镜像
1. 将上述镜像推送到所有节点上
1. 若已按官方文档安装, 请先清除 deployment ks-installer

    ```shell
    kubectl -n kubesphere-system delete deployment ks-installer
    ```

1. 安装修改版 ks-installer

    ```shell
    kubectl apply -f kubesphere-installer.yaml
    kubectl apply -f cluster-configuration.yaml
    ```

1. 请按 [Minimal Kubesphere 文档](https://kubesphere.io/docs/quick-start/minimal-kubesphere-on-k8s) 指示查看进展
