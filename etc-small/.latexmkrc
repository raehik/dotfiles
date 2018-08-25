# `$pdf_mode = 1` means tex -> pdf, no postscript generation
#
# pdfLaTeX mode
#$pdf_mode = 1;
#$pdflatex = "pdflatex --shell-escape %O %S";

# LuaLaTeX mode
$pdf_mode = 1;
$pdflatex = "lualatex --shell-escape %O %S";

# XeLaTeX mode
#$pdf_mode = 1;
#$pdflatex = "xelatex --shell-escape %O %S";
#$postscript_mode = $dvi_mode = 0;
