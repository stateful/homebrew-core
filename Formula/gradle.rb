class Gradle < Formula
  desc "Open-source build automation tool based on the Groovy and Kotlin DSL"
  homepage "https://www.gradle.org/"
  url "https://services.gradle.org/distributions/gradle-8.2-all.zip"
  sha256 "5022b0b25fe182b0e50867e77f484501dba44feeea88f5c1f13b6b4660463640"
  license "Apache-2.0"

  livecheck do
    url "https://gradle.org/install/"
    regex(/href=.*?gradle[._-]v?(\d+(?:\.\d+)+)-all\.(?:zip|t)/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5fcce570e18961f14e5b01fda3fd537f6f03ea7f12baed460ed657f5fd2ce59b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5fcce570e18961f14e5b01fda3fd537f6f03ea7f12baed460ed657f5fd2ce59b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5fcce570e18961f14e5b01fda3fd537f6f03ea7f12baed460ed657f5fd2ce59b"
    sha256 cellar: :any_skip_relocation, ventura:        "87bb0bb08afc69fc272388d8b79d727d0438afd46367ef99df0031fa7dfc9070"
    sha256 cellar: :any_skip_relocation, monterey:       "87bb0bb08afc69fc272388d8b79d727d0438afd46367ef99df0031fa7dfc9070"
    sha256 cellar: :any_skip_relocation, big_sur:        "87bb0bb08afc69fc272388d8b79d727d0438afd46367ef99df0031fa7dfc9070"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5fcce570e18961f14e5b01fda3fd537f6f03ea7f12baed460ed657f5fd2ce59b"
  end

  depends_on "openjdk"

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin docs lib src]
    env = Language::Java.overridable_java_home_env
    (bin/"gradle").write_env_script libexec/"bin/gradle", env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gradle --version")

    (testpath/"settings.gradle").write ""
    (testpath/"build.gradle").write <<~EOS
      println "gradle works!"
    EOS
    gradle_output = shell_output("#{bin}/gradle build --no-daemon")
    assert_includes gradle_output, "gradle works!"
  end
end
