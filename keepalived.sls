configure-base-repo:
  pkgrepo.managed:
    - file: /etc/apt/sources.list
    - name: deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.3/repository-base/          1.7_x86-64 main contrib non-free
    - clean_file: true
    - refresh: false
configure-ext-repo:
  pkgrepo.managed:
    - name: deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.3/repository-extended/      1.7_x86-64 main contrib non-free
    - refresh: false
configure-uu1-repo:
  pkgrepo.managed:
    - name: deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.3/uu/1/repository-base/     1.7_x86-64 main contrib non-free
    - refresh: true

install-pkg:
  pkg.installed:
    - pkgs:
      - keepalived
      - nginx

nginx-config-file-managed:
  file.managed:
    - name:     /etc/nginx/sites-available/default
    - user:     root
    - group:    root
    - template: jinja
    - source: salt:///nginx.conf.tmpl
    - context:
        config: nginx.config

nginx-service-running:
  service.running:
    - name: nginx.service
    - reload: True
    - watch:
      - file: /etc/nginx/sites-available/default

nginx-service-enabled:
  service.enabled:
    - name: nginx.service

keepalived-config-file-managed:
  file.managed:
    - name:     /etc/keepalived/keepalived.conf
    - user:     root
    - group:    root
    - template: jinja
    - source: salt:///keepalived.conf.tmpl
    - context:
        config: keepalived.config

keepalived-service-running:
  service.running:
    - name: keepalived.service

keepalived-service-enabled:
  service.enabled:
    - name: keepalived.service
