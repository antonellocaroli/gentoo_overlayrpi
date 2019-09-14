# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="irqtop is a simple monitor for /proc/interrupts."
HOMEPAGE="https://gitlab.com/elboulangero/irqtop/"
SRC_URI="https://gitlab.com/elboulangero/irqtop/repository/archive.tar.gz?ref=0.3 -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-2a902c5cbc50f79392f0506a6ed8383b05a1bf32"

PATCHES=( "${FILESDIR}/irqtop-0.3_remove_Werror.patch" )

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
}
