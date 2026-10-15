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
      url "https://github.com/DataDog/pup/releases/download/v2.0.0/pup_2.0.0_Darwin_arm64.tar.gz"
      sha256 "aa8d4f32e712f7eef940345662e0e9f71932bc02327ed32349cf130249dca848"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.0.0/pup_2.0.0_Darwin_x86_64.tar.gz"
      sha256 "f767f14276457360ac93b3c8c709dd6b787e348513b15281c72ac0fea17c58f0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v2.0.0/pup_2.0.0_Linux_arm64.tar.gz"
      sha256 "411f8dcb59de9d4ead7d50db3d146ec2192d26a9b7163333ec1ce78983931829"
    else
      url "https://github.com/DataDog/pup/releases/download/v2.0.0/pup_2.0.0_Linux_x86_64.tar.gz"
      sha256 "2f3eed56d39779424d61bcbb43113edcb891dfb87f683a19914de0681baf1f6e"
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
