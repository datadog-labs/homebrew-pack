# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2026-present Datadog, Inc.

class Pup < Formula
  desc "Go-based command-line wrapper for easy interaction with Datadog APIs"
  homepage "https://github.com/DataDog/pup"
  url "https://github.com/DataDog/pup/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "0957cead836d923311ad2bbc6aa90045abb2265b5bc0fb85710ac2fa94515ba8"
  license "Apache-2.0"
  head "https://github.com/DataDog/pup.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # Test that the binary executes and shows help
    assert_match "pup is a CLI wrapper for Datadog APIs", shell_output("#{bin}/pup --help")
  end
end
