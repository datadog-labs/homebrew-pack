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
      url "https://github.com/DataDog/pup/releases/download/v2.0.1/pup_2.0.1_Darwin_arm64.tar.gz"
      sha256 "49f9b370141e3e0850fd650b34ba6262fc011319726d3403e6317ec542ce3573"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.0.1/pup_2.0.1_Darwin_x86_64.tar.gz"
      sha256 "4f27cc19e12aac5e16e44be7944b4403465139f48c8d07314099b311fe756640"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.0.1/pup_2.0.1_Linux_arm64.tar.gz"
      sha256 "a7a0bd038e6d63f836a4d6c307091182c0b344ee7f535829a4271151aaea4b76"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.0.1/pup_2.0.1_Linux_x86_64.tar.gz"
      sha256 "02e53b9ff176dc2cff81b9736a7cecf550f0e3eedbd0d994ae38c1f9fd3ae6b5"
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
