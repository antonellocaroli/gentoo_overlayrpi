# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

MY_PN=${PN/-bin/}

DESCRIPTION="Stream content to Android devices over the Internet"
HOMEPAGE="https://bubblesoftapps.com/bubbleupnpserver/"
SRC_URI="https://bubblesoftapps.com/bubbleupnpserver/BubbleUPnPServer-distrib.zip -> ${P}.zip"



LICENSE="BubbleUPnP-Server"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="systemd"

DEPEND="virtual/jre:1.8
	media-video/ffmpeg
	dev-libs/nss"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto "/opt/${MY_PN}/"
	doins BubbleUPnPServerLauncher.jar
	doins bcprov-jdk16-146.jar
	insopts -m755
	doins launch.sh
	doins "${FILESDIR}/startService.sh"
	if use systemd; then
		systemd_dounit "${FILESDIR}/${MY_PN}.service"
	else
	newinitd "${FILESDIR}/${MY_PN}.init.d" "${MY_PN}"
  fi
}

pkg_postinst() {
	# Provide some post-installation tips.
	elog ""
	elog ""
	elog ""
  elog "BubbleUpnp can be started with the following command (OpenRC):"
  elog "\t/etc/init.d/bibbleupnp start"
  elog "or (systemd):"
  elog "\tsystemctl start bubbleupnp"
  elog ""
  elog "BubbleUpnp can be automatically started on each boot"
  elog "with the following command (OpenRC):"
  elog "\trc-update add bubbleupnp default"
  elog "or (systemd):"
  elog "\tsystemctl enable bubbleupnp"
  elog ""
  elog ""
	elog ""
	elog ""
}
