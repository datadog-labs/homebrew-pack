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
      url "https://github.com/DataDog/pup/releases/download/v2.4.7/pup_2.4.7_Darwin_arm64.tar.gz"
      sha256 "754044d0ec0461d0d8ac6b764a64b95a85f2ad0ab5e53a2b40d0eef725bb04c3"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.7/pup_2.4.7_Darwin_x86_64.tar.gz"
      sha256 "783f74705d1600e0ba282805cdef4f278a4de1ee8b1b6919fe31a6b7c85d2473"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.4.7/pup_2.4.7_Linux_arm64.tar.gz"
      sha256 "0dc402f9ab7df9b12160ebc454c2b425084608908c5f20da40535b4c46f0a882"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.7/pup_2.4.7_Linux_x86_64.tar.gz"
      sha256 "d685fa6f3ee07a7b0f5fd9518a3d872a9966d192c2cf8e9bd1b8e80fc3268504"
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
