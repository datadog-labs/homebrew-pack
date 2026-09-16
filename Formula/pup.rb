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
      url "https://github.com/DataDog/pup/releases/download/v1.21.0/pup_1.21.0_Darwin_arm64.tar.gz"
      sha256 "683e7b524ae602cc83090a75e733e3ddfa3a9b6c665cc900ec1f16399510ffa3"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.21.0/pup_1.21.0_Darwin_x86_64.tar.gz"
      sha256 "5d50e186d154d60a476f8b5071f3408695d72ef12243dc0925de7386a3a4cb31"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.21.0/pup_1.21.0_Linux_arm64.tar.gz"
      sha256 "bdfd65fa5b6dc7f688157b0bbd4a3894ab8a5fdad0c033e9a8868a66427d8f18"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.21.0/pup_1.21.0_Linux_x86_64.tar.gz"
      sha256 "79ca227a34e590d54b5503da7e4efc7f69a0a3cdf5a1688be30139e7cb343fc6"
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
