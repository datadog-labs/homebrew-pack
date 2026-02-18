# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/DataDog/pup"
  version "0.18.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v0.18.0/pup_0.18.0_Darwin_arm64.tar.gz"
      sha256 "26485eec5038543f7756accb430db81a09dd008a041013428947953c91957797"
    else
      url "https://github.com/DataDog/pup/releases/download/v0.18.0/pup_0.18.0_Darwin_x86_64.tar.gz"
      sha256 "d450964fdeaaf05bb0c62a6c387c08cfe3db4b5331da262d3ca9aa93d92f4547"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v0.18.0/pup_0.18.0_Linux_arm64.tar.gz"
      sha256 "540f0d8af7584ff8311b3836c538da67da88fa235b2183d7fe5cfd657b51f39f"
    else
      url "https://github.com/DataDog/pup/releases/download/v0.18.0/pup_0.18.0_Linux_x86_64.tar.gz"
      sha256 "018b3673ef418b264418518cf5ded129be5b85b39f944de4d967f64bf9eb9e03"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
