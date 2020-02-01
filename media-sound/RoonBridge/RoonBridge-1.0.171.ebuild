# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit systemd


DESCRIPTION="music player"
HOMEPAGE="https://roonlabs.com/index.html"
SRC_URI="
  amd64? ( http://download.roonlabs.com/builds/RoonBridge_linuxx64.tar.bz2 -> ${P}_x64.tar.bz2 )
  arm64? ( http://download.roonlabs.com/builds/RoonBridge_linuxarmv8.tar.bz2 -> ${P}_armv8.tar.bz2 )
  arm?   ( http://download.roonlabs.com/builds/RoonBridge_linuxarmv7hf.tar.bz2 -> ${P}_armv7hf.tar.bz2 )
"

LICENSE="roonlabs"

SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm"
RESTRICT="mirror bindist"

IUSE="systemd"

RDEPEND=">=media-libs/alsa-lib-1.0.27"

DEPEND="${RDEPEND}"


S="${WORKDIR}"
MY_PN=RoonBridge

#src_install() {
#  cp -r RoonBridge "${D}"
#  if use systemd; then
#  systemd_dounit "${FILESDIR}/roonbridge.service"
#  else
#  newinitd "${FILESDIR}/roonbridge.init.d" "roonbridge"
#  fi
#}


src_install() {
  insinto "/opt/${PN}/"
  insopts -m755
  doins -r RoonBridge/*
  if use systemd; then
      systemd_dounit "${FILESDIR}/roonbridge.service"
  else
      newinitd "${FILESDIR}/roonbridge.init.d" "roonbridge"
  fi
}



pkg_postinst() {
	# Provide some post-installation tips.
	elog ""
	elog ""
	elog ""
  elog "RoonBridge can be started with the following command (OpenRC):"
  elog "\t/etc/init.d/roonbridge start"
  elog "or (systemd):"
  elog "\tsystemctl start roonbridge"
  elog ""
  elog "RoonBridge can be automatically started on each boot"
  elog "with the following command (OpenRC):"
  elog "\trc-update add roonbridge default"
  elog "or (systemd):"
  elog "\tsystemctl enable roonbridge"
  elog ""
  elog ""
	elog ""
	elog ""
}
