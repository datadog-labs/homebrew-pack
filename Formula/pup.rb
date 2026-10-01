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
      url "https://github.com/DataDog/pup/releases/download/v1.23.7/pup_1.23.7_Darwin_arm64.tar.gz"
      sha256 "0a0595757161fe28b4d3e7286a2b3e56f864832d1d9d7efb67387eb608f51b83"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.7/pup_1.23.7_Darwin_x86_64.tar.gz"
      sha256 "e1714e548eb50401aed6003e8bf5f88e4d9997a3809b7947176ff3f33995e57d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.23.7/pup_1.23.7_Linux_arm64.tar.gz"
      sha256 "66080e76a57ced9659f90b099608967554b3a295afc227c0a8c87c8988d56db3"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.23.7/pup_1.23.7_Linux_x86_64.tar.gz"
      sha256 "9d920c7548dc91f572528a911bc3ef9bdc0e106b7dba679c25079c793e383c0c"
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
