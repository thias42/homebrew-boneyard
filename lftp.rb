class Lftp < Formula
  desc "Sophisticated file transfer program"
  homepage "https://lftp.yar.ru/"
  # Can't get 4.7.x to build on OS X/macOS. Pull requests welcome!
  # https://github.com/Homebrew/homebrew-core/pull/1509
  url "https://lftp.yar.ru/ftp/lftp-4.6.6.tar.xz"
  sha256 "d6215e9bff744f29383fb11c61262b7545b2b5a551e1011e85f428669506d05c"

  depends_on "pkg-config" => :build
  depends_on "readline"
  depends_on "openssl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-openssl=#{Formula["openssl"].opt_prefix}"
    system "make", "install"
  end

  test do
    system bin/"lftp", "-c", "open ftp://mirrors.kernel.org; ls"
  end
end
