# 構築手順

**MaxOSを前提としています。**

まずはここのRepositoryをcloneしてください。

1. build.shを実行してください。
2. `ssh root@localhost -p 12222`を実行してください。
3. ログインパスワードに`./sshd_image/.root_password`の値を入れてください。
4. ログインできることを確認したら、`exit`を入力し接続を一旦終了します。
5. `brew install ansible`を行い、インストールされるのを待ちましょう。
6. インストールが完了したら`ansible --version`と入力し、パスが通っていることとインストールが正常に完了していることを確かめましょう。
7. `brew install http://git.io/sshpass.rb`と入力し、sshpassをインストールしましょう（鍵認証ではなくパスワード認証を行うので必須です）。
8. `cd ansible && ansible-playbook -i localhost site.yml`を実行してください。
9. その後、SSH接続し`cat /tmp/hello.txt`の標準出力が「Hello World!」であることを確認してください。
10. ここまでの操作で問題がなければAnsibleが無事に動作しています。
