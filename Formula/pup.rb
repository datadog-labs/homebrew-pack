# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.22.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.5/pup_0.22.5_Darwin_arm64.tar.gz"
      sha256 "2ca415bf29bc20af8eb680807466c4573fa633ab4080b08a051dc29c17a68859"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.5/pup_0.22.5_Darwin_x86_64.tar.gz"
      sha256 "acd355d956d35984d5b4b7cb193819c1078fffcd3f03892acea8f575fe108192"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.5/pup_0.22.5_Linux_arm64.tar.gz"
      sha256 "a5b60715888fda1e4d5bd526ace31590d42577198987b449d996466bf1e76e0e"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.5/pup_0.22.5_Linux_x86_64.tar.gz"
      sha256 "f8e5369ba343124978504a3fec81f0555d806c200ef97a3893d7b3265aaeffbf"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
