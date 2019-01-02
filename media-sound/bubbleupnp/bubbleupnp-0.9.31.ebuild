# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils unpacker user


DESCRIPTION="music player"
HOMEPAGE="https://roonlabs.com/index.html"
SRC_URI="https://bubblesoftapps.com/bubbleupnpserver/BubbleUPnPServer-distrib.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror bindist"

RDEPEND=">=media-libs/alsa-lib-1.0.27"

DEPEND="${RDEPEND}"


S="${WORKDIR}"
QA_PREBUILT="usr/sbin/bubbleunp"

pkg_setup() {
		enewuser bubbleupnp -1 -1 "/dev/null" "bubbleupnp,audio,realtime"
      }


src_install() {
    chmod +x launch.sh
    dodir /bubbleupnp
    cp * /bubbleunp/
    newinitd "${FILESDIR}/bubbleupnp.init.d" "bubbleupnp"
}

pkg_postinst() {
	# Provide some post-installation tips.
	elog""
	elog""
	elog""
	elog "If you want start RoonBridge automatically on system boot:"
	elog "  rc-update add roonbridge default"
	elog""
	elog""
}
