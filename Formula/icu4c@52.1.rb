require 'formula'

class Icu4cAT521 < Formula
  homepage 'http://site.icu-project.org/'
  url 'https://sourceforge.net/projects/icu/files/ICU4C/52.1/icu4c-52_1-src.tgz/download'
  version '52.1'
  #sha1 '6de440b71668f1a65a9344cdaf7a437291416781'
  sha256 '2f4d5e68d4698e87759dbdc1a586d053d96935787f79961d192c477b029d8092'
  head 'http://source.icu-project.org/repos/icu/icu/trunk/', :using => :svn

  keg_only "Conflicts; see: https://github.com/Homebrew/homebrew/issues/issue/167"

  #option :universal
  #option :cxx11

  def install
    #ENV.universal_binary if build.universal?
    #ENV.cxx11 if build.cxx11?

    args = ["--prefix=#{prefix}", "--disable-samples", "--disable-tests", "--enable-static"]
    #args << "--with-library-bits=64" if MacOS.prefer_64_bit?
    args << "--with-library-bits=64"
    cd "source" do
      system "./configure", *args
      system "make", "VERBOSE=1"
      system "make", "VERBOSE=1", "install"
    end
  end
end
