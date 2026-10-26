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
      url "https://github.com/DataDog/pup/releases/download/v2.3.2/pup_2.3.2_Darwin_arm64.tar.gz"
      sha256 "5c8320d7c43a35796f836a6ca2e2fb21b1123f734f86c796849bcca18321a01c"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.2/pup_2.3.2_Darwin_x86_64.tar.gz"
      sha256 "1ac692aef078607dcce4dfa3d5d2b1dc11f32d8a6289aabf7d0ba0228b70de5d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.3.2/pup_2.3.2_Linux_arm64.tar.gz"
      sha256 "0c466b69f0128e9d88dd971aded867b70f6cb1e5a662831f7135d6729e7a72c1"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.2/pup_2.3.2_Linux_x86_64.tar.gz"
      sha256 "1456679cc4f22e9b8b068e4752804a42fe2a42f47d6dcfa71ddf8bb0d975cd4f"
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
