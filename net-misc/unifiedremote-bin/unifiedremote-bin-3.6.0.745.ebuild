# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit

MY_PN=${PN/-bin/}

DESCRIPTION="Network AudUnified Remote Server for Linux. Easily the best way of controlling your PC from your smartphone."
HOMEPAGE="https://www.unifiedremote.com"
SRC_URI="
	amd64? ( https://www.unifiedremote.com/download/linux-x64-deb -> ${MY_PN}_${PV}.tar.bz2 )
	x86?   ( https://www.signalyst.eu/bins/naa/linux/stretch/${MY_PN}_${PV}-39_i386.deb )
	arm64? ( https://www.signalyst.eu/bins/naa/linux/stretch/${MY_PN}_${PV}-39_arm64.deb )
"

LICENSE="unifiedremote"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
RESTRICT="mirror bindist"


#RDEPEND=">=sys-devel/gcc-5.1.0[openmp]"

#DEPEND="${RDEPEND}"

S="${WORKDIR}"
QA_PREBUILT="usr/sbin/unifiedremote"

#pkg_setup() {
#	if use !systemd; then
#		enewgroup networkaudiod
#		enewuser networkaudiod -1 -1 "/dev/null" "networkaudiod,audio"
#	fi
#}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mv usr opt "${D}" || die
}
