class Alibuild < Formula
  include Language::Python::Virtualenv

  desc "ALICE Build Tool"
  homepage "https://alisw.github.io/alibuild"
  url "https://files.pythonhosted.org/packages/cb/61/7836e4d31b4aacee5a9aedb6d0efced3a7aed8d505c0e2705fc55bd9c328/alibuild-1.17.48.tar.gz"
  sha256 "bb10136553ef764e53202a12736c91c11c4135145de540bcf3c616c87bffe2d0"
  depends_on "libyaml"
  depends_on "modules"
  depends_on "pigz"
  depends_on "s3cmd"

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/50/5c/41fb4571d14c1cfc87543a1e6f491f36f89c1ceac966aeddd61651ee4ba3/boto3-1.43.121.tar.gz"
    sha256 "0599bdde7d0c03d914d9247b0a328ea48c15b0b3b5fb31a153857fa5bc7a4fd3"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/c6/98/1a07ef43bc267080b40709eba041fb39353f341401064912935b7e92bc07/botocore-1.43.121.tar.gz"
    sha256 "69eb571c74ff140cc3a716aed3bc25d09eb7b12de4ea2f990c03785a634f9dcf"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/fd/11/b524cbd9bbdaca58608e4cf4053fd463417549e1959fa8d3aa18319f9555/certifi-2026.10.23.tar.gz"
    sha256 "a9895e6e2758b371e0545e321a3a8fd1fcfd9829ada8824a936dfb16aaaf36cd"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/33/1c/f41d4e74c28ab327ff3acd36053f7ea506c55872d7a90b0fa71aa3ab0c89/charset_normalizer-3.5.2.tar.gz"
    sha256 "39de2a259fc954455c57274dc94c79d5842774e1247a016aff30bc0efed0f4ef"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
    sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/d3/59/322338183ecda247fb5d1763a6cbe46eff7222eaeebafd9fa65d4bf5cb11/jmespath-1.1.0.tar.gz"
    sha256 "472c87d80f36026ae83c6ddd0f1d05d4e510134ed462851fd5f754c8c3cbb88d"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/38/9b/e422a865e1d5d57d0e509b4e0bf1c1a70a7f6382c29a5aa428df994c8bc8/markupsafe-3.0.4.tar.gz"
    sha256 "2e9ad7dd851bf45fab9f75cbff4cb493fee9979e8d8c7c9c3ee119022518edd6"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz"
    sha256 "37dd54208da7e1cd875388217d5e00ebd4179249f90fb72437e91a35459a0ad3"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/49/c5/0a5ce655109cb96b8dfad36908a4e108d15f5dc2eff8fbc3146c4312e704/s3transfer-0.19.3.tar.gz"
    sha256 "8326acc3d056d7f7b8a37110c7d2aea41f67e83f6ae79cd3b5fbcca34c726406"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/94/e7/b2c673351809dca68a0e064b6af791aa332cf192da575fd474ed7d6f16a2/six-1.17.0.tar.gz"
    sha256 "ff70335d468e7eb6ec65b95b99d3a2836546063f63acc5171de367e834932a81"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e3/05/b17359e1cefb4f909b5e40b1b90a496d987258916dbbf88e842c729f510e/urllib3-2.8.0.tar.gz"
    sha256 "63bf2ead4c879426ebf22ef2a781eeb4aa3b4ae798a0435506f8687fd5bb9b63"
  end

  def install
    virtualenv_install_with_resources using: "python@3"
    bin.install_symlink "#{libexec}/bin/aliBuild" => "aliBuild"
    bin.install_symlink "#{libexec}/bin/alienv" => "alienv"
  end

  test do
    # aliBuild reports a screenview before the version subcommand returns.
    # Defensive only: HOME here has no analytics uuid and stdout is not a tty,
    # which is already enough for aliBuild to disable analytics by itself and
    # never prompt. This keeps it from reporting if either stops being true.
    ENV["ALIBUILD_NO_ANALYTICS"] = "1"

    # A resource bump breaks the vendored virtualenv, not the files, so run the
    # installed entry points rather than asserting they exist.
    assert_match "aliBuild version: #{version}",
                 shell_output("#{bin}/aliBuild version")

    # More than argument parsing: detection imports alibuild_helpers and reads
    # the host, so an incomplete virtualenv fails here rather than on first use.
    assert_match(/\Aosx_(x86-64|arm64)\z/,
                 shell_output("#{bin}/aliBuild architecture").strip)

    # The second entry point, which is a shell script and not part of the
    # virtualenv. `help` is handled in the argument loop and exits 0 before
    # anything looks for a work dir; the help text goes to stderr.
    assert_match "load environment for aliBuild packages",
                 shell_output("#{bin}/alienv help 2>&1")
  end
end
