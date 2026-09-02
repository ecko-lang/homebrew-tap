class Ecko < Formula
  desc "AI-native scripting language in one batteries-included binary"
  homepage "https://ecko.sh"
  # Ecko is proprietary and has no SPDX identifier - free for personal,
  # educational and evaluation use, commercial licence for business use.
  # See https://ecko.sh/enterprise. This said "MIT" until 2026-08-29, which
  # was wrong: `brew info` asserted an open-source licence for software whose
  # LICENSE file states it is not open source.
  license :cannot_represent

  # Apple Silicon only. Intel macOS is deliberately not shipped: the macos-13
  # runner is retired, and an arm64 binary cannot run on an Intel Mac.
  on_macos do
    on_arm do
      url "https://ecko.sh/dl/v0.20.0/ecko-aarch64-macos.tar.gz"
      sha256 "a070b7a07b4dcbbdfed6e178aa027d7e52561a1c49a2372cd1f65cb88bb364a0"
    end
    on_intel do
      odie "Ecko does not ship an Intel macOS build. Apple Silicon only."
    end
  end

  def install
    bin.install "ecko"
  end

  def caveats
    <<~EOS
      Ecko is an AI-native language: `ai` is a keyword, not a
      library, and it ships as one binary with no runtime deps.

      Get started:
        ecko                  start the REPL
        ecko script.ecko      run a file

      Docs and guides:  https://ecko.sh/docs
      First program:    https://ecko.sh/docs/start/first-program
      Browser sandbox:  https://ecko.sh/play

      Ecko is free for personal, educational and evaluation
      use. Business use needs a license: ecko.sh/enterprise
    EOS
  end

  test do
    assert_match "ecko v#{version}", shell_output("#{bin}/ecko --version")

    (testpath/"hello.ecko").write <<~ECKO
      print("hello from the formula test")
    ECKO
    assert_match "hello from the formula test", shell_output("#{bin}/ecko #{testpath}/hello.ecko")
  end
end
