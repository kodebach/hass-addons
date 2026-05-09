#!/usr/bin/with-contenv bashio
# ==============================================================================
# Configures NGINX for use with this add-on.
# ==============================================================================
declare cmi
declare user
declare password

cmi=$(bashio::config 'cmi')
user=$(bashio::config 'user')
password=$(bashio::config 'password')

bashio::var.json \
    entry "$(bashio::addon.ingress_entry)" \
    server "$cmi"
    | tempio \
        -template /etc/nginx/templates/ingress.gtpl \
        -out /etc/nginx/servers/ingress.conf

bashio::var.json \
    server "$cmi" \
    | tempio \
        -template /etc/nginx/templates/upstream.gtpl \
        -out /etc/nginx/includes/upstream.conf

bashio::var.json \
    server "$cmi" \
    user "$user" \
    password "$password"
    | tempio \
        -template /etc/nginx/templates/auth_params.gtpl \
        -out /etc/nginx/includes/auth_params.conf