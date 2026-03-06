class DatadogCodeSecurityMcp < Formula
  desc "Local code security scanning for AI coding assistants"
  homepage "https://github.com/datadog-labs/datadog-code-security-mcp"
  license "Apache-2.0"
  version "v0.1.2"

  # SHA256 checksums for each platform/architecture combination
  sha256_map = {
    "darwin" => {
      "amd64" => "467c38ab454906af84d482bc4e75d8b491296b8fc70a10d9a1a18e9adf71ad8c",
      "arm64" => "65447a3546fbe68f05c25bd19c40b7f21e0e6a8871d09a54680a6054f543c503",
    },
    "linux" => {
      "amd64" => "3259862415301874a2ce940fab5eee728a72cb5a2566cadba516587a58889237",
      "arm64" => "c8ed5e117c90f8f48989aa410dbb0d024562d2bb96bd6b79f605fe693efcc539",
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
