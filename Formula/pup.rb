# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.22.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.3/pup_0.22.3_Darwin_arm64.tar.gz"
      sha256 "fb10f24b1a22705f7078abd030d88b47e0a5ac6ee0218e998d0eb22deca4c09e"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.3/pup_0.22.3_Darwin_x86_64.tar.gz"
      sha256 "2cf639a71a8daa67d84830f7a002688be8079205fef880835a6be0e835ae6d58"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.3/pup_0.22.3_Linux_arm64.tar.gz"
      sha256 "a38eeb91824fca2fa4a33bc95600759cda89a0e734c884a2e554372378aff3d2"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.3/pup_0.22.3_Linux_x86_64.tar.gz"
      sha256 "cd5ba3ecbf7aa6ea8404f7f014cc0d5daec41d465f946130ca9f0e3818dcd1ba"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
