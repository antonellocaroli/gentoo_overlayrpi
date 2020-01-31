# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils user systemd

MY_PN="${PN/-bin}"

PERL_VER="5.30"

if [[ ${PV} == *_pre* ]] ; then
	HASHID="d1ead103d426f8e1ae66bd3eaafac03890e9f042"
	BUILDID="1580338236"
	MY_PV="${PV/_pre*}"
	SRC_URI="http://downloads.slimdevices.com/nightly/7.9/sc/${HASHID}/${MY_PN}-${MY_PV}-${BUILDID}.tgz"
#	SRC_URI="https://www.dropbox.com/s/ghkkob0aw3nfyug/${MY_PN}-${MY_PV}-${BUILDID}.tgz"
	S="${WORKDIR}/${MY_PN}-${MY_PV}-${BUILDID}"
	KEYWORDS="~amd64 ~arm64"
elif [[ ${PV} == "9999" ]] ; then
	EGIT_BRANCH="public/7.9"
	EGIT_REPO_URI="https://github.com/Logitech/slimserver.git"
	S="${WORKDIR}/slimserver"
	inherit git-3
else
	SRC_URI="http://downloads.slimdevices.com/LogitechMediaServer_v${PV}/${MY_PN}-${PV}.tgz"
	S="${WORKDIR}/${MY_PN}-${PV}"
	KEYWORDS="~amd64 ~arm64"
fi

DESCRIPTION="Logitech Media Server (streaming audio server)"
HOMEPAGE="http://github.com/Logitech/slimserver"
LICENSE="${PN}"
RESTRICT="bindist mirror"
SLOT="0"
IUSE=""

# Installation dependencies.
DEPEND="
	!media-sound/squeezecenter
	!media-sound/squeezeboxserver
	app-arch/unzip
	media-video/ffmpeg
	media-sound/sox-dsd
	"

# Runtime dependencies.
RDEPEND="
	!prefix? ( >=sys-apps/baselayout-2.0.0 )
	!prefix? ( virtual/logger )
	app-admin/logrotate
	=dev-lang/perl-${PERL_VER}*[ithreads]
	>=dev-perl/Data-UUID-1.202
	>=dev-perl/Audio-Scan-0.930.0
	>=virtual/perl-IO-Compress-2.015
	>=dev-perl/Class-C3-XS-0.13
	>=dev-perl/Class-XSAccessor-1.03
	>=dev-perl/DBI-1.607
	>=dev-perl/DBD-SQLite-1.350.0
	>=dev-perl/Digest-SHA1-2.11
	>=dev-perl/EV-4.150.0
	>=dev-perl/Encode-Detect-1.01
	>=dev-perl/HTML-Parser-3.56
	>=dev-perl/Image-Scale-0.80.0
	>=virtual/perl-IO-Compress-2.015
	>=dev-perl/IO-String-1.08
	>=dev-perl/JSON-XS-2.2.3.1
	>=dev-perl/Sub-Name-0.04
	>=dev-perl/Template-Toolkit-2.19
	>=dev-perl/XML-Parser-2.36
	>=dev-perl/YAML-LibYAML-0.410.0
	>=dev-perl/IO-Socket-SSL-2.24.0
	"

	QA_PREBUILT="
		opt/logitechmediaserver/Bin/i386-linux/faad
		opt/logitechmediaserver/Bin/i386-linux/flac
		opt/logitechmediaserver/Bin/i386-linux/mac
		opt/logitechmediaserver/Bin/i386-linux/mppdec
		opt/logitechmediaserver/Bin/i386-linux/sls
		opt/logitechmediaserver/Bin/i386-linux/sox
		opt/logitechmediaserver/Bin/i386-linux/wvunpack
		opt/logitechmediaserver/Bin/x86_64-linux/faad
		opt/logitechmediaserver/Bin/x86_64-linux/flac
		opt/logitechmediaserver/Bin/x86_64-linux/mac
		opt/logitechmediaserver/Bin/x86_64-linux/sox
		opt/logitechmediaserver/Bin/x86_64-linux/wvunpack
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.10/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.10/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.12/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.12/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.14/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.14/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.16/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.16/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.18/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.18/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.20/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.22/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.22/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.24/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.24/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.26/i386-linux-thread-multi-64int/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.26/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.28/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.30/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Class/C3/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.8/i386-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Class/C3/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Class/XSAccessor/XSAccessor.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Compress/Raw/Zlib/Zlib.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/DBD/SQLite/SQLite.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/DBI/DBI.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Digest/SHA1/SHA1.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/EV/EV.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Encode/Detect/Detector/Detector.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Font/FreeType/FreeType.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/HTML/Parser/Parser.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/IO/AIO/AIO.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/IO/Interface/Interface.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Image/Scale/Scale.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/JSON/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Linux/Inotify2/Inotify2.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Locale/Hebrew/Hebrew.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/MP3/Cut/Gapless/Gapless.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Media/Scan/Scan.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Sub/Name/Name.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/Template/Stash/XS/XS.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/XML/Parser/Expat/Expat.so
		opt/logitechmediaserver/CPAN/arch/5.8/x86_64-linux-thread-multi/auto/YAML/XS/LibYAML/LibYAML.so
	"

RUN_UID=logitechmediaserver
RUN_GID=logitechmediaserver

# Installation locations
OPTDIR="/opt/${MY_PN}"
VARDIR="/var/lib/${MY_PN}"
CACHEDIR="${VARDIR}/cache"
USRPLUGINSDIR="${VARDIR}/Plugins"
SVRPLUGINSDIR="${CACHEDIR}/InstalledPlugins"
CLIENTPLAYLISTSDIR="${VARDIR}/ClientPlaylists"
PREFSDIR="/etc/${MY_PN}"
LOGDIR="/var/log/${MY_PN}"
SVRPREFS="${PREFSDIR}/server.prefs"

# Old Squeezebox Server file locations
SBS_PREFSDIR='/etc/squeezeboxserver/prefs'
SBS_SVRPREFS="${SBS_PREFSDIR}/server.prefs"
SBS_VARLIBDIR='/var/lib/squeezeboxserver'
SBS_SVRPLUGINSDIR="${SBS_VARLIBDIR}/cache/InstalledPlugins"
SBS_USRPLUGINSDIR="${SBS_VARLIBDIR}/Plugins"

DOCS="Changelog?.html Installation.txt"

pkg_setup() {
	enewgroup ${RUN_GID}
	enewuser ${RUN_UID} -1 -1 "/dev/null" ${RUN_GID}
}

src_prepare() {
	epatch "${FILESDIR}/${P}-uuid-gentoo.patch"
	epatch "${FILESDIR}/${P}-client-playlists-gentoo.patch"
	(cd CPAN && rm -rf Image)
	(cd CPAN/arch && rm -rf 5.10 5.12 5.14 5.16 5.18 5.20 5.22 5.24 5.26 5.28 5.30 5.8)
	(cd CPAN/arch/${PERL_VER} && rm -rf arm-linux* i386-linux* x86_64* aarch64-linux*)
	(cd Bin && rm -rf arm*-linux i86pc-solaris* sparc-linux i386-linux powerpc-linux x86_64*)
	eapply_user
}

src_install() {

	# The custom OS module for Gentoo - provides OS-specific path details
	cp "${FILESDIR}/gentoo-filepaths.pm" "Slim/Utils/OS/Custom.pm" || die "Unable to install Gentoo custom OS module"

	# Everthing into our package in the /opt hierarchy (LHS)
	dodir "${OPTDIR}"
	cp -aR "${S}"/* "${ED}${OPTDIR}" || die "Unable to install package files"

	dodoc ${DOCS}
	dodoc "${FILESDIR}/Gentoo-plugins-README.txt"
	dodoc "${FILESDIR}/Gentoo-detailed-changelog.txt"

	# Preferences directory
	dodir "${PREFSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${PREFSDIR}"
	fperms 770 "${PREFSDIR}"

	# Install init scripts (OpenRC)
	newconfd "${FILESDIR}/logitechmediaserver.conf.d" "${MY_PN}"
	newinitd "${FILESDIR}/logitechmediaserver.init.d" "${MY_PN}"

	# Install unit file (systemd)
	systemd_dounit "${FILESDIR}/${MY_PN}.service"

	# Initialize server cache directory
	dodir "${CACHEDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${CACHEDIR}"
	fperms 770 "${CACHEDIR}"

	# Initialize the log directory
	dodir "${LOGDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}"
	fperms 770 "${LOGDIR}"
	touch "${ED}/${LOGDIR}/server.log"
	touch "${ED}/${LOGDIR}/scanner.log"
	touch "${ED}/${LOGDIR}/perfmon.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/server.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/scanner.log"
	fowners ${RUN_UID}:${RUN_GID} "${LOGDIR}/perfmon.log"

	# Initialise the user-installed plugins directory
	dodir "${USRPLUGINSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${USRPLUGINSDIR}"
	fperms 770 "${USRPLUGINSDIR}"

	# Initialise the client playlists directory
	dodir "${CLIENTPLAYLISTSDIR}"
	fowners ${RUN_UID}:${RUN_GID} "${CLIENTPLAYLISTSDIR}"
	fperms 770 "${CLIENTPLAYLISTSDIR}"

	# Install logrotate support
	insinto /etc/logrotate.d
	newins "${FILESDIR}/logitechmediaserver.logrotate.d" "${MY_PN}"

	#symlink
	dodir /opt/logitechmediaserver/CPAN/arch/5.30
	dosym /usr/lib64/perl5/vendor_perl/5.30.1/aarch64-linux-thread-multi /opt/logitechmediaserver/CPAN/arch/5.30/aarch64-linux-thread-multi
	dosym /usr/lib64/perl5/vendor_perl/5.30.1/aarch64-linux-thread-multi/Image /opt/logitechmediaserver/CPAN/Image
}

lms_starting_instr() {
	elog "Logitech Media Server can be started with the following command (OpenRC):"
	elog "\t/etc/init.d/logitechmediaserver start"
	elog "or (systemd):"
	elog "\tsystemctl start logitechmediaserver"
	elog ""
	elog "Logitech Media Server can be automatically started on each boot"
	elog "with the following command (OpenRC):"
	elog "\trc-update add logitechmediaserver default"
	elog "or (systemd):"
	elog "\tsystemctl enable logitechmediaserver"
	elog ""
	elog "You might want to examine and modify the following configuration"
	elog "file before starting Logitech Media Server:"
	elog "\t/etc/conf.d/logitechmediaserver"
	elog ""

	# Discover the port number from the preferences, but if it isn't there
	# then report the standard one.
	httpport=$(gawk '$1 == "httpport:" { print $2 }' "${ROOT}${SVRPREFS}" 2>/dev/null)
	elog "You may access and configure Logitech Media Server by browsing to:"
	elog "\thttp://localhost:${httpport:-9000}/"
	elog ""
}

pkg_postinst() {
	#remove bin
        rm /opt/logitechmediaserver/Bin/x86_64-linux/*
        rm /opt/logitechmediaserver/Bin/aarch64-linux/fl*
				rm /opt/logitechmediaserver/Bin/aarch64-linux/s*
				rm /opt/logitechmediaserver/Bin/aarch64-linux/w*


	# Point user to database configuration step, if an old installation
	# of SBS is found.
	if [ -f "${SBS_SVRPREFS}" ]; then
		elog "If this is a new installation of Logitech Media Server and you"
		elog "previously used Squeezebox Server (media-sound/squeezeboxserver)"
		elog "then you may migrate your previous preferences and plugins by"
		elog "running the following command (note that this will overwrite any"
		elog "current preferences and plugins):"
		elog "\temerge --config =${CATEGORY}/${PF}"
		elog ""
	fi

	# Tell use user where they should put any manually-installed plugins.
	elog "Manually installed plugins should be placed in the following"
	elog "directory:"
	elog "\t${USRPLUGINSDIR}"
	elog ""

	# Show some instructions on starting and accessing the server.
	lms_starting_instr

	elog "Support thread at: http://forums.slimdevices.com/showthread.php?107110-Logitech-Media-Server-7-9-is-out!"
}

lms_remove_db_prefs() {
	MY_PREFS=$1

	einfo "Correcting database connection configuration:"
	einfo "\t${MY_PREFS}"
	TMPPREFS="${T}"/lmsserver-prefs-$$
	touch "${EROOT}${MY_PREFS}"
	sed -e '/^dbusername:/d' -e '/^dbpassword:/d' -e '/^dbsource:/d' < "${EROOT}${MY_PREFS}" > "${TMPPREFS}"
	mv "${TMPPREFS}" "${EROOT}${MY_PREFS}"
	chown ${RUN_UID}:${RUN_GID} "${EROOT}${MY_PREFS}"
	chmod 660 "${EROOT}${MY_PREFS}"
}

pkg_config() {
	einfo "Press ENTER to migrate any preferences from a previous installation of"
	einfo "Squeezebox Server (media-sound/squeezeboxserver) to this installation"
	einfo "of Logitech Media Server."
	einfo ""
	einfo "Note that this will remove any current preferences and plugins and"
	einfo "therefore you should take a backup if you wish to preseve any files"
	einfo "from this current Logitech Media Server installation."
	einfo ""
	einfo "Alternatively, press Control-C to abort now..."
	read

	# Preferences.
	einfo "Migrating previous Squeezebox Server configuration:"
	if [ -f "${SBS_SVRPREFS}" ]; then
		[ -d "${EROOT}${PREFSDIR}" ] && rm -rf "${EROOT}${PREFSDIR}"
		einfo "\tPreferences (${SBS_PREFSDIR})"
		cp -r "${EROOT}${SBS_PREFSDIR}" "${EROOT}${PREFSDIR}"
		chown -R ${RUN_UID}:${RUN_GID} "${EROOT}${PREFSDIR}"
		chmod -R u+w,g+w "${EROOT}${PREFSDIR}"
		chmod 770 "${EROOT}${PREFSDIR}"
	fi

	# Plugins installed through the built-in extension manager.
	if [ -d "${EROOT}${SBS_SVRPLUGINSDIR}" ]; then
		einfo "\tServer plugins (${SBS_SVRPLUGINSDIR})"
		[ -d "${EROOT}${SVRPLUGINSDIR}" ] && rm -rf "${EROOT}${SVRPLUGINSDIR}"
		cp -r "${EROOT}${SBS_SVRPLUGINSDIR}" "${EROOT}${SVRPLUGINSDIR}"
		chown -R ${RUN_UID}:${RUN_GID} "${EROOT}${SVRPLUGINSDIR}"
		chmod -R u+w,g+w "${EROOT}${SVRPLUGINSDIR}"
		chmod 770 "${EROOT}${SVRPLUGINSDIR}"
	fi

	# Plugins manually installed by the user.
	if [ -d "${EROOT}${SBS_USRPLUGINSDIR}" ]; then
		einfo "\tUser plugins (${SBS_USRPLUGINSDIR})"
		[ -d "${EROOT}${USRPLUGINSDIR}" ] && rm -rf "${EROOT}${USRPLUGINSDIR}"
		cp -r "${EROOT}${SBS_USRPLUGINSDIR}" "${EROOT}${USRPLUGINSDIR}"
		chown -R ${RUN_UID}:${RUN_GID} "${EROOT}${USRPLUGINSDIR}"
		chmod -R u+w,g+w "${EROOT}${USRPLUGINSDIR}"
		chmod 770 "${EROOT}${USRPLUGINSDIR}"
	fi

	# Remove the existing MySQL preferences from Squeezebox Server (if any).
	lms_remove_db_prefs "${SVRPREFS}"

	# Phew - all done. Give some tips on what to do now.
	einfo "Done."
	einfo ""
}
