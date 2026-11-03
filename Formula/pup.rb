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
      url "https://github.com/DataDog/pup/releases/download/v2.4.0/pup_2.4.0_Darwin_arm64.tar.gz"
      sha256 "15dc6701ddd9b273efe7678e52d54a901870833104685d29b1f4a3c358d3f662"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.0/pup_2.4.0_Darwin_x86_64.tar.gz"
      sha256 "dbaf074a05d9088eab3839833a8581675754aa0ecc51d8a870460890056771a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.4.0/pup_2.4.0_Linux_arm64.tar.gz"
      sha256 "64924d5758146ea0ea46c1954139ed32077fbb736bd967c0e1323cd2f9d70dfa"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.0/pup_2.4.0_Linux_x86_64.tar.gz"
      sha256 "9621c0c6d8cc143fab0cc6f3faef022b8bb90603421d538c0ba701bf6b7f19d2"
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
