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
      url "https://github.com/DataDog/pup/releases/download/v2.3.10/pup_2.3.10_Darwin_arm64.tar.gz"
      sha256 "fa0714eb7f5323b939587787a3eedb56838be6e1501fa659254e1ab7d3135a2d"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.10/pup_2.3.10_Darwin_x86_64.tar.gz"
      sha256 "ce7b35e7ec06d56e773bc8552ede50a93f724ea8024f8af9dc0c4f0d918d8aa0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.3.10/pup_2.3.10_Linux_arm64.tar.gz"
      sha256 "64c0022953592c4ebc4b163ae016216d041fe9218eb1daefba52273f377b9071"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.3.10/pup_2.3.10_Linux_x86_64.tar.gz"
      sha256 "75e75477c5195e94b93be6685bd69ff4869785f4643d578a5fe538c13a6a5be9"
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
