class Gwenhywfar < Formula
  desc "Utility library required by aqbanking and related software"
  homepage "http://www.aqbanking.de/"
  url "http://www2.aquamaniac.de/sites/download/download.php?package=01&release=201&file=01&dummy=gwenhywfar-4.15.3.tar.gz"
  sha256 "6a0e8787c99620414da6140e567c616b55856c5edf8825a9ebc67431923ee63a"

  head "http://git.aqbanking.de/git/gwenhywfar.git"

  option "without-cocoa", "Build without cocoa support"
  option "with-test", "Run build-time check"

  deprecated_option "with-check" => "with-test"

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gnutls"
  depends_on "openssl"
  depends_on "libgcrypt"
  depends_on "gtk+" => :optional
  depends_on "qt" => :optional

  def install
    guis = []
    guis << "gtk2" if build.with? "gtk+"
    guis << "qt4" if build.with? "qt"
    guis << "cocoa" if build.with? "cocoa"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-guis=#{guis.join(" ")}"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <gwenhywfar/gwenhywfar.h>

      int main()
      {
        GWEN_Init();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}/gwenhywfar4", "-L#{lib}", "-lgwenhywfar", "-o", "test"
    system "./test"
  end
end
