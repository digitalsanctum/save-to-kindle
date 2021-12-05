#!/bin/bash

# Send a local *.mobi file to Kindle via Gmail SMTP (max 40MB).
# Prerequisites: 
#   - swaks
#   - internet access
#   - gmail account with SMTP access
#   - Kindle account with @kindle.com email configured
#      (see https://www.amazon.com/gp/help/customer/display.html?nodeId=G7NECT4B4ZWHQ8WV)

set -e

usage() {
    echo >&2 "$@"    
    exit 1
}

[ "$#" -eq 1 ] || usage "usage: ./save.sh [MOBI]"


# TODO: add validation for file size and type

ATTACHMENT_FILE="$1"

function send_gmail() {
    swaks --to ${KINDLE_EMAIL} \
    --from "${GMAIL_USERNAME}" \
    --server "smtp.gmail.com:587" \
    --auth LOGIN \
    --auth-user "${GMAIL_USERNAME}" \
    --auth-password "${GMAIL_PASSWORD}" \
    --attach ${ATTACHMENT_FILE} \
    -tls
}

send_gmail 
