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
      url "https://github.com/DataDog/pup/releases/download/v2.3.1/pup_2.3.1_Darwin_arm64.tar.gz"
      sha256 "315f73c7726db7714f26a0e728c58107a540ba3e484c0170e5eb9e6521b80a11"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.1/pup_2.3.1_Darwin_x86_64.tar.gz"
      sha256 "ea81b31ee12b813e7f2af6cdefdd5c938ef14cfed273ae5f6ce4d235a0bcdba2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.3.1/pup_2.3.1_Linux_arm64.tar.gz"
      sha256 "e807d5f7c27538cff7da80149cf501d16700b5f5c64a2c1374ef4f554e5a2118"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.1/pup_2.3.1_Linux_x86_64.tar.gz"
      sha256 "5063acb6793b26f101d9f7fd3dd57357efd98affee0b854e9dbcfdf70edf2226"
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
