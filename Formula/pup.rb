# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  license "Apache-2.0"
  # Some 1.10.0 installs recorded their keg as version "64", which Homebrew
  # compares as newer than any 1.x release and so would never be upgraded.
  version_scheme 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.24.0/pup_1.24.0_Darwin_arm64.tar.gz"
      sha256 "ad0b33953b51b825aba5213ab8ca7f3a5185d1486144fd000c55210e7756c6f6"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.24.0/pup_1.24.0_Darwin_x86_64.tar.gz"
      sha256 "357e4f998dc091ef5f1156165c3a68aa2115d1352c93eaddef7992d383a89ad7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.24.0/pup_1.24.0_Linux_arm64.tar.gz"
      sha256 "23632e567c0935a790468de6080a078fb9999a65fd2c53fd0ddada01d2cd28ee"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.24.0/pup_1.24.0_Linux_x86_64.tar.gz"
      sha256 "bf6387ce33deee3bf2b8fbb72ec32387cd6a52ac9ce19f4fdaadc85c2c4b3b18"
    end
  end

  def install
    bin.install "pup"

    # `pup completions <shell>` prints a completion script generated from the
    # binary's own command tree, so the installed completions match the shipped
    # CLI exactly and are refreshed on every upgrade. Installed for the shells
    # Homebrew supports by default (bash, zsh, fish); `pup completions
    # <shell> --install` remains available for elvish/powershell and for an
    # auto-refreshing loader outside the keg.
    generate_completions_from_executable(bin/"pup", "completions")
  end

  test do
    assert_match "Datadog API CLI", shell_output("#{bin}/pup --help")

    assert_path_exists bash_completion/"pup"
    assert_path_exists zsh_completion/"_pup"
    assert_path_exists fish_completion/"pup.fish"
  end
end
