# ベースイメージ
FROM nginx:1.25.4

# Nginxをフォアグラウンド起動(デフォルトでは、デーモンで起動されるが、コンテナが止まるため)
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
