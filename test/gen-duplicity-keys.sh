#!/usr/bin/env bash
set -e

# Arch is special and calls gpg 1.4 gpg1
if which gpg1 &>/dev/null; then
  OUR_GPG=gpg1
else
  OUR_GPG=gpg
fi

generate_keypair() {
  TARGET="$1"

  GPG_HOME=$(mktemp -d)

  $OUR_GPG --homedir "$GPG_HOME" --gen-key --batch <<EOGPG
  Key-Type: RSA
  Subkey-Type: RSA
  Key-Length: 4096
  Subkey-Length: 4096

  Name-Real: Squidy T. Squid
  Name-Email: supersquid@theocean.net

  Expire-Date: 0

EOGPG

  $OUR_GPG --homedir "$GPG_HOME" --export --armor Squidy > "$TARGET-public.key"
  $OUR_GPG --homedir "$GPG_HOME" --export-secret-keys --armor Squidy > "$TARGET-private.key"
}

generate_keypair $(dirname $0)/backup-encryption
generate_keypair $(dirname $0)/backup-signing
