# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-benchmarks/rt-tests/rt-tests-0.93.ebuild,v 1.1 2015/08/16 Exp $

EAPI=5
KEYWORDS="~amd64 ~x86 ~arm64"
SRC_URI="https://www.dropbox.com/s/2f48u443a886s48/rtapp.tar.gz"

inherit eutils user systemd

DESCRIPTION="Realtime application thread priority tuning"
HOMEPAGE="http://www.audio-linux.com"

LICENSE="custom"
SLOT="0"
IUSE="systemd"

RDEPEND="app-shells/bash:=
	sys-process/rtirq:=
	sys-apps/util-linux:=
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}"

PATCHES=("${FILESDIR}/${PN}-openrc.patch")
DOCS=( readme.txt )

#pkg_setup()
#{
#	if use !systemd; then
#		enewgroup rtapp
#		enewuser rtapp -1 -1 "/dev/null" "rtapp,audio"
#	fi
#}

src_unpack()
{
	mkdir "${S}"
	tar -xzvf "${DISTDIR}"/"rtapp.tar.gz" -C "${S}" --strip-components=1 &> /dev/null || die "unpack failed"
}

src_prepare()
{
	if use !systemd; then
		epatch "${PATCHES[@]}"
	fi
	epatch_user
}

src_install()
{
	dobin ${PN}
	for FILE in rtmonitorirq rtreset rtstatus rtcards; do
		dobin "${FILE}"
		insinto "/usr/share/applications/"
		sed -e "s,;\$SHELL,,g" \
			-e "s,'${FILE}',\"/usr/bin/${FILE};bash\",g" \
			-e "s,TerminalOptions=,,g" -i "${FILE}.desktop"
		doins "${FILE}.desktop"
	done
	dobin "${FILESDIR}/${PN}-timer"
	insinto "/etc/rtapp/"
	doins rtapp.conf

	if use systemd; then
		systemd_dounit "${FILESDIR}/${PN}.service"
		systemd_dounit "${FILESDIR}/${PN}-timer"
	else
		newconfd "${FILESDIR}/${PF}.conf.d" "${PN}-timer"
		newinitd "${FILESDIR}/${PF}.init.d" "${PN}-timer"
	fi

	dodoc "${DOCS[@]}"
}
