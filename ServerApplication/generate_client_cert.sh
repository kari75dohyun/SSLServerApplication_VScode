#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "사용법: $0 [클라이언트 이름]"
    exit 1
fi

CLIENT_NAME=$1
DAYS=365

# CA 키/인증서 없으면 생성
if [ ! -f ca.key ] || [ ! -f ca.pem ]; then
    echo "[+] CA 키/인증서 생성"
    openssl genrsa -out ca.key 2048
    openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.pem -subj "/C=KR/ST=Seoul/O=MyOrg/OU=Dev/CN=MyServerCA"
else
    echo "[*] 기존 CA 인증서 사용"
fi

# 클라이언트 키/CSR/CRT 생성
echo "[+] $CLIENT_NAME 키/CSR/CRT 생성"
openssl genrsa -out "$CLIENT_NAME.key" 2048
openssl req -new -key "$CLIENT_NAME.key" -out "$CLIENT_NAME.csr" -subj "/C=KR/ST=Seoul/O=Client/OU=Users/CN=$CLIENT_NAME"
openssl x509 -req -in "$CLIENT_NAME.csr" -CA ca.pem -CAkey ca.key -CAcreateserial -out "$CLIENT_NAME.crt" -days $DAYS -sha256

echo "[✓] $CLIENT_NAME 인증서 발급 완료: $CLIENT_NAME.crt"
