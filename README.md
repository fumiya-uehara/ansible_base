# Ansible Base

Ansibleをローカルで動かすためのRepositoryです。

## 前提

- MacOSを前提としていますが、Linux環境でも動作するはずです（未検証）。
- Dockerがインストールされていることを前提としています。
- Ansibleがインストールされていることを前提としています。

## 注意点

このRepositoryは練習用となるため、利便性重視でパスワードや鍵情報をgitに含めています。
しかし、ProductionやStagingなどセキュリティを意識しなければならないような環境に置いては、
パスワードや鍵情報を含めることはセキュリティ上リスクの高い行為となるため、避けてください。

もしも、このRepositoryを元にAnsibleのコードを書く際はくれぐれも上記点に留意してください。

## 構築手順

```bash
# workdirには任意の作業ディレクトリを選択してください。
cd workdir
git clone git@github.com:fumiya-uehara/ansible_base.git
cd ansible_base 
./build.sh 
```

`build.sh`を実行後、コンテナが起動していれば構築は完了です。コンテナは以下のコマンドで確認可能です。

```bash
# [-l]オプションは最後に作成されたコンテナを表示します
docker container ls -l
CONTAINER ID        IMAGE                     COMMAND             CREATED             STATUS              PORTS                   NAMES
0804759edee5        local/c7.8-systemd-sshd   "/usr/sbin/init"    42 minutes ago      Up 42 minutes       0.0.0.0:12222->22/tcp   ansible_base
```

もしもコンテナに接続したい場合はdocker経由での接続とssh接続ができます。
しかしながらssh接続はCurrentDirectoryを変更する必要があることに注意してください。
これは、`ssh_config`に記載された`IdentityFile`のパスがsshを実行したCurrentDirectoryからの相対パスであることが原因です。

```bash
# Docker
docker container exec -it ansible_base bash

# ssh
cd ansible
# root login
ssh -F .ssh/ssh_config docker.root
ssh -F .ssh/ssh_config docker.deploy_user
```

Ansible実行後に以下のコマンドを実行し「Hello Ansible!」と標準出力されればAnsibleが反映されていることを確認できます。

```bash
docker container exec ansible_base cat /tmp/hello.txt
```
