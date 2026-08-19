class Ecko < Formula
  desc "AI-native scripting language in one batteries-included binary"
  homepage "https://ecko.sh"
  license "MIT"

  # Apple Silicon only. Intel macOS is deliberately not shipped: the macos-13
  # runner is retired, and an arm64 binary cannot run on an Intel Mac.
  on_macos do
    on_arm do
      url "https://ecko.sh/dl/v0.14.0/ecko-aarch64-macos.tar.gz"
      sha256 "f053ef100249698041f41d31885378a1207d2179a8dd3e3017bfd882ea171656"
    end
    on_intel do
      odie "Ecko does not ship an Intel macOS build. Apple Silicon only."
    end
  end

  def install
    bin.install "ecko"
  end

  test do
    assert_match "ecko v#{version}", shell_output("#{bin}/ecko --version")

    (testpath/"hello.ecko").write <<~ECKO
      print("hello from the formula test")
    ECKO
    assert_match "hello from the formula test", shell_output("#{bin}/ecko #{testpath}/hello.ecko")
  end
end
