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
      url "https://github.com/DataDog/pup/releases/download/v1.27.1/pup_1.27.1_Darwin_arm64.tar.gz"
      sha256 "526a865fd4e7c89dab1dbf95651bb696d561b8ae3d95513ad321f5eb32c483b8"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.27.1/pup_1.27.1_Darwin_x86_64.tar.gz"
      sha256 "4a1ce738a98eda50fb54afe571b0ff70fdcd120e286b0123aace502d987c9c15"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.27.1/pup_1.27.1_Linux_arm64.tar.gz"
      sha256 "15da6667da76f773d7d2d3a20b4198642fbf7d9349ae097d8d446e6bb157861e"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.27.1/pup_1.27.1_Linux_x86_64.tar.gz"
      sha256 "a240b87dc19b699aa5689513a64896cb4d13f9acfb386a123946d6c0d9d0b831"
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
