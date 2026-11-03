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
      url "https://github.com/DataDog/pup/releases/download/v2.4.1/pup_2.4.1_Darwin_arm64.tar.gz"
      sha256 "d5352a80bba8052750ba1f5fb63fcc1ea1c8fd7f104f8772a519a555bfe73a5d"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.1/pup_2.4.1_Darwin_x86_64.tar.gz"
      sha256 "4185c86ae3c98f2835dfdd31d87fa57e82aeb75509504dd838a88c02f4d9ea69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.4.1/pup_2.4.1_Linux_arm64.tar.gz"
      sha256 "4a3b0e8aa6425a0e29be31bf18ca36e50ae87941ae74c73a8e0596632b62b69a"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.4.1/pup_2.4.1_Linux_x86_64.tar.gz"
      sha256 "f84f72ade2b92cb46cf02e063467caaf00c63d0f8f9d5c1232ca558b42e971b1"
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
