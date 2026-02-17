# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/DataDog/pup"
  version "0.16.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v0.16.0/pup_0.16.0_Darwin_arm64.tar.gz"
      sha256 "5662ebf0c5e75869f676188db60b67d30a0b765b0900aeb99a6d494e8362d5cf"
    else
      url "https://github.com/DataDog/pup/releases/download/v0.16.0/pup_0.16.0_Darwin_x86_64.tar.gz"
      sha256 "47301b98c19121ab96292048ab99533562c562e6d1120d76fee1476232f407f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DataDog/pup/releases/download/v0.16.0/pup_0.16.0_Linux_arm64.tar.gz"
      sha256 "b65b305d8b97d58166b30bb97ea89c1de44bc7a46862430e726bc9867f9d9bf6"
    else
      url "https://github.com/DataDog/pup/releases/download/v0.16.0/pup_0.16.0_Linux_x86_64.tar.gz"
      sha256 "a09c5d08cf99db2a087c3c63865d8c9165244d244326d52b9d7842d76d0d38cb"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
