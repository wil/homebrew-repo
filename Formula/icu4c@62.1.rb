class Icu4cAT621 < Formula
  desc "C/C++ and Java libraries for Unicode and globalization"
  homepage "https://ssl.icu-project.org/"
  url "https://ssl.icu-project.org/files/icu4c/62.1/icu4c-62_1-src.tgz"
  mirror "https://downloads.sourceforge.net/project/icu/ICU4C/62.1/icu4c-62_1-src.tgz"
  version "62.1"
  sha256 "3dd9868d666350dda66a6e305eecde9d479fb70b30d5b55d78a1deffb97d5aa3"

  keg_only :provided_by_macos, "macOS provides libicucore.dylib (but nothing else)"

  # fix issue with LD_SONAME losing trailing space:
  # https://unicode-org.atlassian.net/browse/ICU-20526
  patch :p0, :DATA

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-samples
      --disable-tests
      --enable-static
      --with-library-bits=64
    ]

    cd "source" do
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/gendict", "--uchars", "/usr/share/dict/words", "dict"
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
