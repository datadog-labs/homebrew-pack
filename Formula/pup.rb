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
      url "https://github.com/DataDog/pup/releases/download/v2.7.0/pup_2.7.0_Darwin_arm64.tar.gz"
      sha256 "cd69d0e971da7a6aaea9774b5b1e022f1479789db7ea2b427141f099755eb4e6"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.7.0/pup_2.7.0_Darwin_x86_64.tar.gz"
      sha256 "9ddddfd8430f48977d83bcfedf10e3692ecc0d7d57534b2892e16aefc5f22488"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.7.0/pup_2.7.0_Linux_arm64.tar.gz"
      sha256 "53e4db1b610280b84e7b9992e28ee2ee1ab8e7dd7aa16f3933b70ba3c468ea06"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.7.0/pup_2.7.0_Linux_x86_64.tar.gz"
      sha256 "3c73bee24bced0a6194c8f620af61547119dbe5c10b66055f07b6cc8006bbb0c"
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
