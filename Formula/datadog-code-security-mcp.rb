class DatadogCodeSecurityMcp < Formula
  desc "Local code security scanning for AI coding assistants"
  homepage "https://github.com/datadog-labs/datadog-code-security-mcp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.1/datadog-code-security-mcp-darwin-arm64.tar.gz"
      sha256 "a9e7df17b8959e2b5d072506f00d3aafd6aabf6d54afd5831dd4715f66be189c"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.1/datadog-code-security-mcp-darwin-amd64.tar.gz"
      sha256 "4f84b942d7bdbce64be95523f58f2c91f7d67eb70b663b8e31f414762df1c432"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.1/datadog-code-security-mcp-linux-arm64.tar.gz"
      sha256 "f33ab836ff4de5051911bcd862b636e4480fb45c414f401fc0669019001ade73"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.6.1/datadog-code-security-mcp-linux-amd64.tar.gz"
      sha256 "14034379b641ab6e8341d53e53386a33341abf2efa86482761d299ef24770913"
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
