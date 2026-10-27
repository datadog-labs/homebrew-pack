class DatadogCodeSecurityMcp < Formula
  desc "Local code security scanning for AI coding assistants"
  homepage "https://github.com/datadog-labs/datadog-code-security-mcp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.5.0-fake4/datadog-code-security-mcp-darwin-arm64.tar.gz"
      sha256 "b23deff337ff4deb1def19e78ad3b41976799437d1d49143289ecaa2fd9fe403"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.5.0-fake4/datadog-code-security-mcp-darwin-amd64.tar.gz"
      sha256 "75defef01b585706d92677e05b079d2d8bedcc7f55add2f567ba759149539c23"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.5.0-fake4/datadog-code-security-mcp-linux-arm64.tar.gz"
      sha256 "ebb8e405abb0206abb834a13923a269832f569a2a4b9909fbe5dffe6a2717723"
    else
      url "https://github.com/datadog-labs/datadog-code-security-mcp/releases/download/v0.5.0-fake4/datadog-code-security-mcp-linux-amd64.tar.gz"
      sha256 "37c8b38183dbbaa2e6a914d339574908882d8f747d67a33aa3723ec35c40d893"
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
