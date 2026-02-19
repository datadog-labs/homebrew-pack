# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/datadog-labs/pup"
  version "0.19.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.19.1/pup_0.19.1_Darwin_arm64.tar.gz"
      sha256 "d4cfa34913772a42777c47d6e7565f27eb8f4ca7621008214186d5c62e68790b"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.19.1/pup_0.19.1_Darwin_x86_64.tar.gz"
      sha256 "ccf0af64ef5abe20a4a2548426616533cb7ea3ec15b90dd32b2baca9d1b01a04"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/pup/releases/download/v0.19.1/pup_0.19.1_Linux_arm64.tar.gz"
      sha256 "b3699bd6a68cf1e9caa131ac819de5fa5b0c5d83cce70baac7398d3f79b00eb7"
    else
      url "https://github.com/datadog-labs/pup/releases/download/v0.19.1/pup_0.19.1_Linux_x86_64.tar.gz"
      sha256 "b50fa2674e5a3342245af92b98f7ee2f0574edc281b5b2797d999994363734e9"
    end
  end

  def install
    bin.install "pup"
  end

  test do
    assert_match "Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
