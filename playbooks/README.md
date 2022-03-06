# 创建密码

``` shell
ansible-vault encrypt_string --vault-id pwd@prompt '<密码>' --name "ansible_password"
```

将生成的内容放在 inventory.yaml:all.vars.下

同样生成 inventory.yaml:all.vars.ansible_become_password

# 验证

``` shell
ansible localhost -m ansible.builtin.debug -a var="all.vars.ansible_password" -e "@inventory.yaml" --vault-id pwd@prompt
```

# 试运行

``` shell
ansible-playbook basics.yaml -i inventory.yaml --vault-id pwd@prompt --diff --check
```

# 正式运行

``` shell
ansible-playbook basics.yaml -i inventory.yaml --vault-id pwd@prompt --diff
```
