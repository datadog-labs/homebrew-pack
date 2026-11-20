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
      url "https://github.com/DataDog/pup/releases/download/v2.6.1/pup_2.6.1_Darwin_arm64.tar.gz"
      sha256 "89c991add481dd7442fe6b587b82f439d41ce48de35db935af98aa196c881cab"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.6.1/pup_2.6.1_Darwin_x86_64.tar.gz"
      sha256 "0ae03d5b5b2cd1f31e4049577460c2a30255f6134ab6487f31a32a458be02583"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.6.1/pup_2.6.1_Linux_arm64.tar.gz"
      sha256 "12f929447ea809925a5b7c9e82b645c203a99a0e06b328b44aa463e4242ef629"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.6.1/pup_2.6.1_Linux_x86_64.tar.gz"
      sha256 "784a862178cbb60ea1522acf5e459db199e7da763c46915641e0a5488cdb6f9c"
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
