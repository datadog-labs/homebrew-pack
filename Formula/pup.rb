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
      url "https://github.com/DataDog/pup/releases/download/v2.3.9/pup_2.3.9_Darwin_arm64.tar.gz"
      sha256 "4dd19d0f6857499c715050bf087c9c56b069d36b478a7237e0922f30f57336fe"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.9/pup_2.3.9_Darwin_x86_64.tar.gz"
      sha256 "2dd8040dd27c21f2fc50862b74f7757bae10a7924b45a5192b4718cae8550338"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.3.9/pup_2.3.9_Linux_arm64.tar.gz"
      sha256 "bd332c39bd71564cbee61e6be58cdd4e2000ebd25f705c90fb58a6ad3525e8fc"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.9/pup_2.3.9_Linux_x86_64.tar.gz"
      sha256 "2ff589ea4125cd04ae630595f77f729f7942fb1cf0f6979184228df9803a1a9c"
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
