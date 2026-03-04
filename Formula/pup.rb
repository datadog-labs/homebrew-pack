# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.26.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.26.0/pup_0.26.0_Darwin_arm64.tar.gz"
      sha256 "a6fde8627819820e15e217f6cced7107b99e00228074daccd005f12d6e16f507"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.26.0/pup_0.26.0_Darwin_x86_64.tar.gz"
      sha256 "a8ece63a08f2e7178b803163177cab4e0861954b24e020393459f817185bc4d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.26.0/pup_0.26.0_Linux_arm64.tar.gz"
      sha256 "6f1424170e8e28bca82cf40eceb0189cf050b507bd4796f1d7194a9bb4affdc9"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.26.0/pup_0.26.0_Linux_x86_64.tar.gz"
      sha256 "a25af40643591a4b3d9dbb02fe66e2b63a12af1ff278d5b67b89360f969eab7f"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
