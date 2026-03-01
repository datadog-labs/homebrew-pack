# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.25.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.25.0/pup_0.25.0_Darwin_arm64.tar.gz"
      sha256 "248484699185ff3fbabcdd9f1411134aeb605eef3b8700f2c8010d76ca276b1e"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.25.0/pup_0.25.0_Darwin_x86_64.tar.gz"
      sha256 "cc0782cd0fa656353c5d1e858a4c7bb2453e94216e7dcff170fc3c5f517b71c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.25.0/pup_0.25.0_Linux_arm64.tar.gz"
      sha256 "77f79954f7e3597de59f365d74f4ec12c69113562148c0bcdbd910c1a3c93d55"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.25.0/pup_0.25.0_Linux_x86_64.tar.gz"
      sha256 "24f966bc2de2140b073908ab4b583ad48efb3aca90ca710754ff3eaa75b5568b"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
