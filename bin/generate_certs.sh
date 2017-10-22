#!/usr/bin/env bash

BASE_DOMAIN="${1:-localhost.dev}"
cd /usr/local/etc/httpd

# Days for the cert to live
DAYS=3650

# A blank passphrase
PASSPHRASE=""

# Generated configuration file
CONFIG_FILE="certs/config.txt"

cat > $CONFIG_FILE <<-EOF
[req]
default_bits = 4096
prompt = no
default_md = sha256
x509_extensions = v3_req
distinguished_name = dn

[dn]
C = IN
ST = Rajasthan
L = Jaipur
O = Localhost, LLC
OU = Testing Domain
emailAddress = webmaster@$BASE_DOMAIN
CN = $BASE_DOMAIN

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = $BASE_DOMAIN
DNS.2 = *.$BASE_DOMAIN
EOF

# The file name can be anything
FILE_NAME="certs/$BASE_DOMAIN"

# Remove previous keys
echo "Removing existing certs from Keychain"
sudo security remove-trusted-cert -d "$FILE_NAME.crt"
echo "Removing existing certs like $FILE_NAME.*"
chmod 770 $FILE_NAME.*
rm $FILE_NAME.*

echo "Generating certs for $BASE_DOMAIN"

# Generate our Private Key, CSR and Certificate
# Use SHA-2 as SHA-1 is unsupported from Jan 1, 2017

openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout "$FILE_NAME.key" -days $DAYS -out "$FILE_NAME.crt" -passin pass:$PASSPHRASE -config "$CONFIG_FILE"

# OPTIONAL - write an info to see the details of the generated crt
openssl x509 -noout -fingerprint -text < "$FILE_NAME.crt" > "$FILE_NAME.info"

# Protect the key
chmod 400 "$FILE_NAME.key"

# Add to Keychain
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$FILE_NAME.crt"

# Apache Config

echo "
<VirtualHost *:80>
    ServerAdmin webmaster@${BASE_DOMAIN}
    ServerName ${BASE_DOMAIN}
    ServerAlias www.${BASE_DOMAIN}
    DocumentRoot \"/Users/nikhgupta/Code/websites/${BASE_DOMAIN}\"
    ErrorLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-error_log\"
    CustomLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-access_log\" common
</VirtualHost>

<VirtualHost *:443>
    ServerAdmin webmaster@${BASE_DOMAIN}
    ServerName ${BASE_DOMAIN}
    ServerAlias www.${BASE_DOMAIN}
    DocumentRoot \"/Users/nikhgupta/Code/websites/${BASE_DOMAIN}\"
    ErrorLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-error_log\"
    CustomLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-access_log\" common
    SSLCertificateFile \"/usr/local/etc/httpd/${FILE_NAME}.crt\"
    SSLCertificateKeyFile \"/usr/local/etc/httpd/${FILE_NAME}.key\"
</VirtualHost>

<VirtualHost *:80>
    ServerAdmin webmaster@${BASE_DOMAIN}
    ServerName ${BASE_DOMAIN}
    ServerAlias *.${BASE_DOMAIN}
    VirtualDocumentRoot \"/Users/nikhgupta/Code/websites/%2+/%1\"
    ErrorLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-error_log\"
    CustomLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-access_log\" common
</VirtualHost>

<VirtualHost *:443>
    ServerAdmin webmaster@${BASE_DOMAIN}
    VirtualDocumentRoot \"/Users/nikhgupta/Code/websites/%2+/%1\"
    ServerName ${BASE_DOMAIN}
    ServerAlias *.${BASE_DOMAIN}
    ErrorLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-error_log\"
    CustomLog \"/usr/local/var/log/httpd/${BASE_DOMAIN}-access_log\" common
    SSLCertificateFile \"/usr/local/etc/httpd/${FILE_NAME}.crt\"
    SSLCertificateKeyFile \"/usr/local/etc/httpd/${FILE_NAME}.key\"
</VirtualHost>
" >> "/usr/local/etc/httpd/domains/$BASE_DOMAIN.conf"

echo "Generated config in: /usr/local/etc/httpd/domains/${BASE_DOMAIN}.conf"
echo "Creating directory: /Users/nikhgupta/Code/websites/${BASE_DOMAIN}"
mkdir -p "/Users/nikhgupta/Code/websites/${BASE_DOMAIN}"
echo "Restarting apache.."
sudo apachectl restart
