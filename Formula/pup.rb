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
      url "https://github.com/DataDog/pup/releases/download/v2.4.2/pup_2.4.2_Darwin_arm64.tar.gz"
      sha256 "ecf081017fc9ed30cc5415e308642e3b7feccabade84a3300e22b012b97f30b0"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.2/pup_2.4.2_Darwin_x86_64.tar.gz"
      sha256 "39f3eaf86a971ab888b0cf2d5c86080e3d333e82ba2c01a943f5c9299398a3c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.4.2/pup_2.4.2_Linux_arm64.tar.gz"
      sha256 "d32e814ccc965dc5abef445c5c4247a3479e268cd5d2621cb8f2ea7bc0708e00"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.2/pup_2.4.2_Linux_x86_64.tar.gz"
      sha256 "b2f093c04f02398ac4dd0a5d1278bedd6f4ad1b81840ed2b186d9d2782e99782"
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
