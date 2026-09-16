class DatadogCodeSecurityMcp < Formula
  desc "Local code security scanning for AI coding assistants"
  homepage "https://github.com/datadog-labs/datadog-code-security-mcp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.4.0/datadog-code-security-mcp-darwin-arm64.tar.gz"
      sha256 "2917bce485d3201a853ecc42e8c4cbd7d22cce703d860fe126802ece95272a0d"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.4.0/datadog-code-security-mcp-darwin-amd64.tar.gz"
      sha256 "9249ef5f003620ab2cd5b25d41c9dc81b2093d53926f7d850d082435e9fc56e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.4.0/datadog-code-security-mcp-linux-arm64.tar.gz"
      sha256 "9b535f31fd32acb76ed22b23f395687f583c42cbe7be63e74cae71d4cdf5e06c"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.4.0/datadog-code-security-mcp-linux-amd64.tar.gz"
      sha256 "4710155b71313c6ba6b3ce0fa02eec58d0d36852d4190cc3c266f7fbcaf3e8fb"
    end
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
