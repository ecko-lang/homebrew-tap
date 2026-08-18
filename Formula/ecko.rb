class Ecko < Formula
  desc "AI-native scripting language in one batteries-included binary"
  homepage "https://ecko.sh"
  license "MIT"

  # Apple Silicon only. Intel macOS is deliberately not shipped: the macos-13
  # runner is retired, and an arm64 binary cannot run on an Intel Mac.
  on_macos do
    on_arm do
      url "https://ecko.sh/dl/v0.12.0/ecko-aarch64-macos.tar.gz"
      sha256 "ceda80f9c6c0cf29dbbdcb29c69b239bda67be58dcfcc29eeaf0a2c1649dfd11"
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
