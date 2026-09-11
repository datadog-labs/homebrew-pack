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
      url "https://github.com/DataDog/pup/releases/download/v1.19.1/pup_1.19.1_Darwin_arm64.tar.gz"
      sha256 "a0d359cc7b73af51b3bccf7c08447d3899ffc2560455c8b4a3b0517b68685893"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.19.1/pup_1.19.1_Darwin_x86_64.tar.gz"
      sha256 "66a0f5532ca34f9653d79dd66fc99059e33ff4266407e83a0858ff518d6840b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.19.1/pup_1.19.1_Linux_arm64.tar.gz"
      sha256 "960d59fb0085678b35c1592d48b82aaf19a663c5496444329c31b7909f8e8207"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.19.1/pup_1.19.1_Linux_x86_64.tar.gz"
      sha256 "995c36655b45ea88b031a1a8e80b43d9d96c6e2c37aed9f3bd9545b0f6ba16b6"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog API CLI", shell_output("#{bin}/pup --help")
  end
end
