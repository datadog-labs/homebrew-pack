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
      url "https://github.com/DataDog/pup/releases/download/v1.23.1/pup_1.23.1_Darwin_arm64.tar.gz"
      sha256 "21f03fb42939185af0ae88b0bc14e54d6e5d641bdbe23b404d9572519c30a07f"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.1/pup_1.23.1_Darwin_x86_64.tar.gz"
      sha256 "4dfc2a0bf8ca9a021887a50a19cf9a77869ab16cf308d4c78f554605dc68886a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.23.1/pup_1.23.1_Linux_arm64.tar.gz"
      sha256 "7f1d82f2f813ac1336ca3e47525a79e8c03d13759c7931e7219e3b79ee474cdb"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.1/pup_1.23.1_Linux_x86_64.tar.gz"
      sha256 "f1974c8480cce0b07f6fd312c534f05e086e20e7de93082cd7064fb70da44c0c"
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
