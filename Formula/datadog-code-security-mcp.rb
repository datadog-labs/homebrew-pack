class DatadogCodeSecurityMcp < Formula
  desc "Local code security scanning for AI coding assistants"
  homepage "https://github.com/datadog-labs/datadog-code-security-mcp"
  license "Apache-2.0"
  version "v0.1.0"

  # SHA256 checksums for each platform/architecture combination
  sha256_map = {
    "darwin" => {
      "amd64" => "6e9997305a13331c035269000b05800e064118bbc0adc2dbd41042c32605a490",
      "arm64" => "4d5112e914b4021be76236740a2b7b4fac3fb9244d19990af160920382ec74f4",
    },
    "linux" => {
      "amd64" => "817ee587584e02cb8bf405a6b34f3ec8d6e3a3212750603346e5d688dbd97e52",
      "arm64" => "94c4332358ba0bf3c6565066ac0524f6c82f1e92328d0ebd41b65c0e8d0d64f8",
    }
  }

  arch = Hardware::CPU.arm? ? "arm64" : "amd64"

  on_macos do
    url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/#{version}/datadog-code-security-mcp-darwin-#{arch}.tar.gz"
    sha256 sha256_map["darwin"][arch]
  end

  on_linux do
    url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/#{version}/datadog-code-security-mcp-linux-#{arch}.tar.gz"
    sha256 sha256_map["linux"][arch]
  end

  def install
    bin.install "datadog-code-security-mcp"
  end

  def caveats
    <<~EOS
      To use with Claude Desktop, add to your MCP config:

        claude mcp add datadog-code-security \\
          -- #{bin}/datadog-code-security-mcp start

      For Datadog employees with dd-auth:

        claude mcp add datadog-code-security \\
          -e DD_AUTH_DOMAIN=app.datadoghq.com \\
          -- #{bin}/datadog-code-security-mcp start

      Or manually configure in ~/.claude/config.json:

        {
          "mcpServers": {
            "datadog-code-security": {
              "command": "#{bin}/datadog-code-security-mcp",
              "args": ["start"]
            }
          }
        }

      Direct scanning (no AI assistant required):

        # Scan current directory
        datadog-code-security-mcp scan all .

        # Scan specific paths
        datadog-code-security-mcp scan sast ./src ./lib

        # JSON output for CI/CD
        datadog-code-security-mcp scan all . --json

      Note: All scanning is performed locally - your code never leaves your machine.
      Authentication is optional and only needed for future cloud features.
    EOS
  end

  test do
    system bin/"datadog-code-security-mcp", "version"
  end
end
