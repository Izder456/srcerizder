# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A tiling window manager extended from ratpoison"
HOMEPAGE="https://github.com/jcs/sdorfehs"
SRC_URI="https://github.com/jcs/sdorfehs/archive/v1.5.tar.gz"

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
