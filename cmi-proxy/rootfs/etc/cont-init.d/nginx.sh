#!/usr/bin/with-contenv bashio
# ==============================================================================
# Configures NGINX for use with this add-on.
# ==============================================================================
declare cmi
declare user
declare password

bashio::var.json \
    entry "$(bashio::addon.ingress_entry)" \
    | tempio \
        -template /etc/nginx/templates/ingress.gtpl \
        -out /etc/nginx/servers/ingress.conf

cmi=$(bashio::config 'cmi')
user=$(bashio::config 'user')
password=$(bashio::config 'password')

echo '{"server":"'"$cmi"'"}' \
    | tempio \
        -template /etc/nginx/templates/upstream.gtpl \
        -out /etc/nginx/includes/upstream.conf

echo '{"user":"'"$user"'","password":"'"$password"'"}' \
    | tempio \
        -template /etc/nginx/templates/auth_params.gtpl \
        -out /etc/nginx/includes/auth_params.conf