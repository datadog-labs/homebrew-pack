class DatadogCodeSecurityMcp < Formula
  desc "Local code security scanning for AI coding assistants"
  homepage "https://github.com/datadog-labs/datadog-code-security-mcp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.0/datadog-code-security-mcp-darwin-arm64.tar.gz"
      sha256 "4b1e4c7190936c34b401abc5e50ec25092e8b84ac0608c2fa9b440f6d83aca12"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.0/datadog-code-security-mcp-darwin-amd64.tar.gz"
      sha256 "b434587c9bccc7a0727d91479a9671ef9a3a26a33c667bc24a0c1c32c3b5313c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.0/datadog-code-security-mcp-linux-arm64.tar.gz"
      sha256 "d5064892ad9c62c5be80a3ae72512923a0abe2511169c300cfb389fc5c989b8c"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.0/datadog-code-security-mcp-linux-amd64.tar.gz"
      sha256 "d1d2ba7b497b82cd4012063cc5d714cfd5d45637792e329d2bbea55a21f5a8f0"
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
