# Copyright 2023-* izzy Meyer <izder456@disroot.org>

EAPI=8

inherit cmake xdg

MY_PN=OttoMatic

DESCRIPTION="Pangea Software’s Otto Matic"
HOMEPAGE="https://github.com/jorio/OttoMatic/"
SRC_URI="
	https://github.com/jorio/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/jorio/Pomme/archive/master.tar.gz -> Pomme.tar.gz
"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libsdl2
	virtual/opengl
"
DEPEND="
	${RDEPEND}
"


DOCS=( README.md )

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}/extern/Pomme" || die "Couldn't change to extern/Pomme."
	unpack "Pomme.tar.gz"
	mv "Pomme-master"/* ./ || die
	rm -r "Pomme-master" || die
}

src_compile() {
	cmake_src_compile
}

src_install() {
	exeinto "/usr/$(get_libdir)/${MY_PN}"
	doexe "${BUILD_DIR}/${MY_PN}"
	doexe "${BUILD_DIR}/extern/Pomme/libPomme.so"

	dosym "../$(get_libdir)/${MY_PN}/${MY_PN}" "${EPREFIX}/usr/bin/${MY_PN}"

	insinto "/usr/share/${MY_PN}"
	doins -r "${BUILD_DIR}/Data"/*

	einstalldocs

	insinto "/usr/share/pixmaps"
	doins "${S}/packaging/io.jor.ottomatic.png"

	insinto "/usr/share/applications"
	doins "${S}/packaging/io.jor.ottomatic.desktop"
}

