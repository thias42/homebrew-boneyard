require "language/node"
class Bit < Formula
  desc "Distributed Code Component Manager"
  homepage "https://www.bitsrc.io"
  url "https://bitsrc.jfrog.io/bitsrc/bit-brew/stable/bit/0.1.31/bit-0.1.31-brew.tar.gz"
  sha256 "e4df0bdabd21c9f9af81850a044ad9ea61c4392fe1515538e3462c4a00772071"

  depends_on "node"

  def install
    system "npm", "install", "-g", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_equal "successfully initialized an empty bit scope.\n", shell_output("#{bin}/bit init")
  end
end
