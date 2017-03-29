class Libtomcrypt < Formula
  desc "Modular and portable cryptographic toolkit"
  homepage "http://www.libtom.net/LibTomCrypt/"
  url "https://github.com/libtom/libtomcrypt/releases/download/1.17/crypt-1.17.tar.bz2"
  mirror "https://distfiles.macports.org/libtomcrypt/crypt-1.17.tar.bz2"
  sha256 "e33b47d77a495091c8703175a25c8228aff043140b2554c08a3c3cd71f79d116"
  head "https://github.com/libtom/libtomcrypt.git"

  depends_on "libtommath"

  def install
    ENV["DESTDIR"] = prefix
    ENV["EXTRALIBS"] = "-ltommath"
    ENV.append "CFLAGS", "-DLTM_DESC -DUSE_LTM -DLTC_NO_ROLC"

    system "make", "library"
    include.install Dir["src/headers/*"]
    lib.install "libtomcrypt.a"
  end
end
