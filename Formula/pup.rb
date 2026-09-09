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
      url "https://github.com/DataDog/pup/releases/download/v1.19.0/pup_1.19.0_Darwin_arm64.tar.gz"
      sha256 "ce5264bac332e358314b2801075683f290fc6393a062e69442cccacc07f9f068"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.19.0/pup_1.19.0_Darwin_x86_64.tar.gz"
      sha256 "8609c8de850311a331e851fc67dad87fccf62c12258c6dac46eacf8db2bc373b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v1.19.0/pup_1.19.0_Linux_arm64.tar.gz"
      sha256 "513add101d71d7d67d50266bcf115bf0df2a13b0955543933be883f5f1d05cbf"
    else
      url "https://github.com/DataDog/pup/releases/download/v1.19.0/pup_1.19.0_Linux_x86_64.tar.gz"
      sha256 "df7fc449fe03775db297c3c4b13b4ef50a7ce30a48a18480a8eba9fe515e2272"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog API CLI", shell_output("#{bin}/pup --help")
  end
end
