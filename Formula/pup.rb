# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.23.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.23.0/pup_0.23.0_Darwin_arm64.tar.gz"
      sha256 "af95a9bfdc867bee9b0f9861f6ac0351ffc924677de81451b1cdd36711d47fec"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.23.0/pup_0.23.0_Darwin_x86_64.tar.gz"
      sha256 "f1a039a32385d7789526890fa05aeff0f25d0de70edb043a5888fd25aeb76cea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.23.0/pup_0.23.0_Linux_arm64.tar.gz"
      sha256 "00de2a04d74c4806bbfbb3ffc1c65be3df6e7f5e83b323b7e71b7fcbc9fec38c"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.23.0/pup_0.23.0_Linux_x86_64.tar.gz"
      sha256 "2b563febf39d6f7dd81c99934b739c0b70d12152d82cb1bed687c5c8b6de110d"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
