server {
    listen 8555 default_server;

    include /etc/nginx/includes/server_params.conf;

    location / {
        allow   172.30.32.2;
        deny    all;

        proxy_pass http://backend/;
        proxy_set_header X-Ingress-Path {{ .entry }};
        include /etc/nginx/includes/proxy_params.conf;
        include /etc/nginx/includes/auth_params.conf;
    }

    location /INCLUDE/ {
        allow   172.30.32.2;
        deny    all;

        proxy_pass http://backend/INCLUDE/;
        proxy_set_header X-Ingress-Path {{ .entry }};
        proxy_set_header Referer "http://{{ .server }}/schema.html";
        include /etc/nginx/includes/proxy_params.conf;
        include /etc/nginx/includes/auth_params.conf;
    }
}
