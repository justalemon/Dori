pkgname=dori
pkgver=r1.7c3040d
pkgrel=1
pkgdesc="Easy to use shortcuts for Docker and Docker Compose"
arch=("any")
url="https://github.com/justalemon/Dori"
license=("MIT")
depends=(bash python python-ruamel-yaml)
makedepends=()
provides=("${pkgname%-git}")
source=("src-$pkgname::git+${url}.git")
sha256sums=('SKIP')

pkgver() {
    cd "src-$pkgname"
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
}

package() {
    cd "src-$pkgname"
    install -m 775 -DT "$startdir/$pkgname.sh" "$pkgdir/usr/bin/$pkgname"
}
