# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/DataDog/pup"
  version "0.15.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v0.15.0/pup_0.15.0_Darwin_arm64.tar.gz"
      sha256 "f631f05504d3cc9a7689271403ba5a0800044ed890fbe90da2f116e4b95f6d85"
    else
      url "https://github.com/DataDog/pup/releases/download/v0.15.0/pup_0.15.0_Darwin_x86_64.tar.gz"
      sha256 "8429e98dce38b9d739fc99c6dd1115081bf5f0e089a518585b3bb412790bd77c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v0.15.0/pup_0.15.0_Linux_arm64.tar.gz"
      sha256 "0bc6e82722cc50653585b6d31b3f96312f43819d3bddce6f878f78c6df8b80f1"
    else
      url "https://github.com/DataDog/pup/releases/download/v0.15.0/pup_0.15.0_Linux_x86_64.tar.gz"
      sha256 "f21742b7bb6f92d43b7f16797edfd4c51df514d8c27772d035ec989fffab3b7a"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
