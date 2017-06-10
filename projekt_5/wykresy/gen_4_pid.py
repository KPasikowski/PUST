import sys

print """
\\documentclass[a4paper,11pt]{article}
\\usepackage{pgfplots}
\\usepackage{siunitx}
\\usepackage{pgffor}
\\sisetup{detect-weight,exponent-product=\\cdot,output-decimal-marker={,},
    per-mode=symbol,binary-units=true,range-phrase={-},range-units=single}
\\SendSettingsToPgf
\\usetikzlibrary{pgfplots.groupplots}
\\pgfplotsset{compat=1.11}
\\usepgfplotslibrary{external}
\\tikzexternalize

\\textwidth 160mm \\textheight 247mm

\\pgfplotsset{width=\\figurewidth,compat=1.11}
\\pgfplotsset{
    tick label style={font=\\tiny},
    label style={font=\\footnotesize},
    legend style={font=\\footnotesize},
    title style={font=\\footnotesize}
}


\\newcommand{\\szer}{16cm}
\\newcommand{\\wys}{5.6cm}
\\newcommand{\\odstepionowy}{1.2cm}


\\begin{document}

\\tikzsetnextfilename{}

"""

colors = ["red", "red", "blue","green","green"]

i = sys.argv[1]
for j in range(1,4):
	print """

\\begin{figure}[PID]
\\tikzsetnextfilename{zad4_pid_"""+str(i)+"_"+str(j)+"""}
\\begin{tikzpicture}

\\begin{groupplot}[group style={group size=1 by 2,vertical sep=\\odstepionowy},
width=\szer,height=\\wys]

\\nextgroupplot
[xmin=1,xmax=800,ymin=-2.5,ymax=2.5,
xtick={0,100,...,800},
ytick={-10,-9,...,10},
ylabel={$y(t)$},
xlabel={$t$}]"""

	for x in range(1,4):
		print """
\\addplot[const plot,color="""+colors[x]+""",semithick] file {../wykresy_pliki/zad4/PID/wyjscie"""+str(x)+"_"+str(i)+"_"+str(j)+""".txt};
\\addplot[const plot,color="""+colors[x]+""",densely dashed] file {../wykresy_pliki/zad4/PID/wartosc_zadana"""+str(x)+"_config_"+str(i)+""".txt};"""

	print "\n\\legend{$y_{1}(t)$,$y_{1 zad}$,$y_{2}(t)$,$y_{2 zad}$,$y_{3}(t)$,$y_{3 zad}$}"

	print """
\\nextgroupplot
[xmin=1,xmax=800,ymin=-2.5,ymax=2.5,
xtick={0,100,...,800},
ytick={-10,-9,...,10},
ylabel={$u(t)$},
xlabel={$t$}]"""

	for x in [1,2,4]:
		print """
\\addplot[const plot,color="""+colors[x]+""",semithick] file {../wykresy_pliki/zad4/PID/sterowanie"""+str(x)+"_"+str(i)+"_"+str(j)+""".txt};"""

	print "\\legend{$u_{1}(t)$,$u_{2}(t)$,$u_{4}(t)$}"

	print """

\\end{groupplot}
\\end{tikzpicture}
\\end{figure}"""

print "\\end{document}"


