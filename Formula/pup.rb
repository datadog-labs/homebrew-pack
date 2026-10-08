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
      url "https://github.com/DataDog/pup/releases/download/v1.26.0/pup_1.26.0_Darwin_arm64.tar.gz"
      sha256 "73635a547142f5b40dc7255af2555419d0f6ab52991a1974f9ee5e3397e57aa2"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.26.0/pup_1.26.0_Darwin_x86_64.tar.gz"
      sha256 "1e1ff5e689302d152121e12336823d91552ed4d8c7d492c658b324c61f86c94a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.26.0/pup_1.26.0_Linux_arm64.tar.gz"
      sha256 "602912dc6a4ae4b5806d13156e33958c9702a13bab03825059c3a4e3534b1d42"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.26.0/pup_1.26.0_Linux_x86_64.tar.gz"
      sha256 "40459bac784a9991df44685f0286b14d79ad3f33fd01445aa4b2858d22770061"
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
