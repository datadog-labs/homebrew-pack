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
      url "https://github.com/DataDog/pup/releases/download/v2.5.2/pup_2.5.2_Darwin_arm64.tar.gz"
      sha256 "992da2107b3761ce4f23806f01ba50dc1d70fe1f8381055f8c00e0297bf8ae96"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.5.2/pup_2.5.2_Darwin_x86_64.tar.gz"
      sha256 "6008bd3733fdbc05526f19da9af76d1f70c3c55afb0fe61c0cee10c31b072db0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.5.2/pup_2.5.2_Linux_arm64.tar.gz"
      sha256 "9112737cf4c1503307b9b0d185e0c63a985d7c50a010232ccc8613a209a266ce"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.5.2/pup_2.5.2_Linux_x86_64.tar.gz"
      sha256 "235232257cf661fa93e6dc3bb9f3fc359b79cc88c2e776df6f98651b206499e6"
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
