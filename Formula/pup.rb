# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.22.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.0/pup_0.22.0_Darwin_arm64.tar.gz"
      sha256 "c01b8bf6265f752399bc78cbfce860bf277d2df050e8b9ac8f2aa635d51b90f3"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.0/pup_0.22.0_Darwin_x86_64.tar.gz"
      sha256 "e9d5a6e5c1855cfa8a49ccde5fa01527e0fe90c59d3bad3bd003c15f4e77aa39"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.0/pup_0.22.0_Linux_arm64.tar.gz"
      sha256 "264fda61a532c8523635f0c633d4ec69f1f0c3e18e7dc3ad8837964b80680599"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.22.0/pup_0.22.0_Linux_x86_64.tar.gz"
      sha256 "263de77d331ed26f9c8c073c879adffc5eea9254565623e7e2c2cbce7a7de909"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
