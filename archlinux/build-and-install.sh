#! /bin/bash

set -x

[ -r "$HOME/.makepkg.conf" ] && . "$HOME/.makepkg.conf"

cd "$(dirname "$0")" &&
. ./PKGBUILD &&
version="$(cd "$OLDPWD" && python2 ./setup.py --version)" &&
version_commit="$(cd "$OLDPWD" && git log -1 --pretty="tformat:%H" -S"version='$version'" ./setup.py)" &&
head_commit="$(cd "$OLDPWD" && git rev-parse --short=7 HEAD)" &&
rev_count="$(cd "$OLDPWD" && git rev-list --count $version_commit..HEAD)" &&
pkgver="$version.$rev_count.g$head_commit" &&
src="src/subprocess32-$pkgver" &&
rm -rf src pkg &&
mkdir -p "$src" &&
sed "s/^pkgver=.*\$/pkgver=$pkgver/" PKGBUILD >PKGBUILD.tmp &&
(cd "$OLDPWD" && git ls-files -z | xargs -0 cp -a --no-dereference --parents --target-directory="$OLDPWD/$src") &&
export PACKAGER="${PACKAGER:-`git config user.name` <`git config user.email`>}" &&
makepkg --noextract --force -p PKGBUILD.tmp &&
rm -rf src pkg PKGBUILD.tmp &&
sudo pacman -U --noconfirm "$pkgname-$pkgver-$pkgrel-any${PKGEXT:-.pkg.tar.xz}"

