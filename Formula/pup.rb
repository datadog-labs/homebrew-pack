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
      url "https://github.com/DataDog/pup/releases/download/v2.5.0/pup_2.5.0_Darwin_arm64.tar.gz"
      sha256 "33b0c38a5e1a1eb2c884ffd3c1ec1245ff305859680c5d2d5d11e3108ef065b5"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.5.0/pup_2.5.0_Darwin_x86_64.tar.gz"
      sha256 "8d3293f8df0c184b718b60471aea81edf8de928b0effee0a77a09a6925de3877"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.5.0/pup_2.5.0_Linux_arm64.tar.gz"
      sha256 "99b6c4634a2122b501f9b95b342c5cd3e9c8bac54d847227f385dce5a4c913ea"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.5.0/pup_2.5.0_Linux_x86_64.tar.gz"
      sha256 "ba332d6d504d959289ca8410cbc24af134f8cd54857a3e703ad7716a058ec636"
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
