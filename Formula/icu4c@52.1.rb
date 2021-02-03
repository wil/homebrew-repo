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

  # fix issue with LD_SONAME losing trailing space:
  # https://unicode-org.atlassian.net/browse/ICU-20526
  patch :p0, :DATA

  def install
    #ENV.universal_binary if build.universal?
    #ENV.cxx11 if build.cxx11?

    args = %W[
      --prefix=#{prefix}
      --disable-samples
      --disable-tests
      --with-library-bits=64
    ]
    cd "source" do
      system "./configure", *args
      system "make", "VERBOSE=1"
      system "make", "VERBOSE=1", "install"
    end
  end
end
__END__
--- source/data/pkgdataMakefile.in	2021-01-28 01:57:04.000000000 +1100
+++ source/data/pkgdataMakefile.in.new	2021-01-28 01:47:45.000000000 +1100
@@ -26,7 +26,7 @@
 	@echo LIBFLAGS="-I$(top_srcdir)/common -I$(top_builddir)/common $(SHAREDLIBCPPFLAGS) $(SHAREDLIBCFLAGS)" >> $(OUTPUTFILE)
 	@echo GENLIB="$(SHLIB.c)" >> $(OUTPUTFILE)
 	@echo LDICUDTFLAGS=$(LDFLAGSICUDT) >> $(OUTPUTFILE)
-	@echo LD_SONAME=$(LD_SONAME) >> $(OUTPUTFILE)
+	@echo LD_SONAME="$(LD_SONAME)" >> $(OUTPUTFILE)
 	@echo RPATH_FLAGS=$(RPATH_FLAGS) >> $(OUTPUTFILE)
 	@echo BIR_LDFLAGS=$(BIR_LDFLAGS) >> $(OUTPUTFILE)
 	@echo AR=$(AR) >> $(OUTPUTFILE)
