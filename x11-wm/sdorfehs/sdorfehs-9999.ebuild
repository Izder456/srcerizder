# Copyright 2023-* izzy Meyer <izder456@disroot.org>

EAPI=8

DESCRIPTION="A tiling window manager extended from ratpoison"
HOMEPAGE="https://github.com/jcs/sdorfehs"
SRC_URI="https://github.com/jcs/sdorfehs/archive/v1.5.tar.gz"

if [[ ${PV} == 9999 ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/jcs/${PN}"
else
        SRC_URI="https://github.com/jcs/${PN}/archive/${P}.tar.gz"
        KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~ppc64 ~riscv ~x86"
fi


LICENSE="GPL-2.0"
SLOT="0"

KEYWORDS="amd64 ~hppa ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug emacs +history sloppy +xft +xrandr"

RDEPEND="
	history? ( sys-libs/readline:= )
	xft? ( x11-libs/libXft )
	xrandr? ( x11-libs/libXrandr )
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXres
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="virtual/pkgconfig"

src_compile() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]]; then
		emake || die "emake failed"
	fi
}
