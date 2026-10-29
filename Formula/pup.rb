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
      url "https://github.com/DataDog/pup/releases/download/v2.3.6/pup_2.3.6_Darwin_arm64.tar.gz"
      sha256 "274b68ee1e194be43974ed99ee0b3e631cc395bab7cbc21901cf97a9bed2e0c9"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.6/pup_2.3.6_Darwin_x86_64.tar.gz"
      sha256 "0a42062f200ba6f54731df135be9c86105548158d4edcbeedb34116f76e86bfc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.3.6/pup_2.3.6_Linux_arm64.tar.gz"
      sha256 "e4acc28242046aa15b818ad09e4097b5c55f1dea2f27db78ba341c8ae8ffb5e3"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.6/pup_2.3.6_Linux_x86_64.tar.gz"
      sha256 "d3aea126ae07ea6f509b75ca3366653fcd751d5631be74b6adbe7e02620a2a76"
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
