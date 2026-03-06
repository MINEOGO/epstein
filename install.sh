#!/usr/bin/env bash
set -e
TMP="$(mktemp -d 2>/dev/null || mktemp -d -t epstein)"
DEB_URL="https://raw.githubusercontent.com/MINEOGO/epstein/main/epstein.deb"
BIN_URL="https://raw.githubusercontent.com/MINEOGO/epstein/main/epstein"
if [ -n "$PREFIX" ] && echo "$PREFIX" | grep -q "com.termux"; then
cd "$TMP"
curl -L "$BIN_URL" -o epstein || wget -O epstein "$BIN_URL"
chmod +x epstein
mv epstein "$PREFIX/bin/epstein"
elif command -v apt >/dev/null 2>&1; then
cd "$TMP"
curl -L "$DEB_URL" -o epstein.deb || wget -O epstein.deb "$DEB_URL"
sudo dpkg -i epstein.deb || sudo apt -f install -y
elif command -v pacman >/dev/null 2>&1; then
curl -L "$BIN_URL" -o epstein || wget -O epstein "$BIN_URL"
chmod +x epstein
sudo mv epstein /usr/local/bin/epstein
elif command -v dnf >/dev/null 2>&1 || command -v yum >/dev/null 2>&1; then
curl -L "$BIN_URL" -o epstein || wget -O epstein "$BIN_URL"
chmod +x epstein
sudo mv epstein /usr/local/bin/epstein
elif command -v brew >/dev/null 2>&1; then
curl -L "$BIN_URL" -o epstein || wget -O epstein "$BIN_URL"
chmod +x epstein
mv epstein /usr/local/bin/epstein
else
curl -L "$BIN_URL" -o epstein || wget -O epstein "$BIN_URL"
chmod +x epstein
mkdir -p "$HOME/.local/bin"
mv epstein "$HOME/.local/bin/epstein"
fi
rm -rf "$TMP"
