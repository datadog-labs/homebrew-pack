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
      url "https://github.com/DataDog/pup/releases/download/v1.23.5/pup_1.23.5_Darwin_arm64.tar.gz"
      sha256 "f854172902de7ead277e970b44e3820ac99a7d47e52eeb6f96154cbbdd1ad147"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.5/pup_1.23.5_Darwin_x86_64.tar.gz"
      sha256 "9a5e061372bf174a139822bfba6ba0dcd386c580b17fffc5e24a883b6d8bdd4a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.23.5/pup_1.23.5_Linux_arm64.tar.gz"
      sha256 "0f3843e5d97e4b5816d6050ac626fd899d6a971286a98a10a21023acbeddfb83"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.5/pup_1.23.5_Linux_x86_64.tar.gz"
      sha256 "1372763c58a0d2dd01312205ba55299b0566dd6d06b86510db78c7314adbf5d4"
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
