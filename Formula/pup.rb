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
      url "https://github.com/DataDog/pup/releases/download/v2.7.1/pup_2.7.1_Darwin_arm64.tar.gz"
      sha256 "5d19b8286b8a00e59ce1dd28a4d8773319ab3d35cab3972d49c0db50294adc28"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.7.1/pup_2.7.1_Darwin_x86_64.tar.gz"
      sha256 "d4fae7d442a819c09fd0a7886daa03dc0343099ba2c6292e6311e4327d987161"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.7.1/pup_2.7.1_Linux_arm64.tar.gz"
      sha256 "5d719b49565759dfbdf3ca9c2664c37d71445bf1dc239bf351e98dca6345b09a"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.7.1/pup_2.7.1_Linux_x86_64.tar.gz"
      sha256 "96c1bd9efc0bd784dafdbcdde4f772d307b6480c85c3a7a69b648a1cf1c9153a"
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
