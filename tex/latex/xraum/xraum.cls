% Class: xraum
% Version: 0.01-2020/11/07
% License: LPPL 1.3c
% GitHub Repo: https://github.com/elvendrim/xraum/
%
% This Work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, in its
% version 1.3c. This version of this license is in
% http://www.latex-project.org/lppl/lppl-1-3c.txt
% and the latest version of this license is in
% http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of
% LaTeX version 2005/12/01 or later.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xraum}[2020/11/07 v0.1 Standard article class
                      for typsetting documents in IAST/Devanāgarī]

% Pre-defined options
% Font size
\newcommand\xraum@fontsize{12pt} % Set default fontsize to 12pt
\DeclareOption{10pt}{\renewcommand\xraum@fontsize{10pt}}%
\DeclareOption{11pt}{\renewcommand\xraum@fontsize{11pt}}%
\DeclareOption{12pt}{\renewcommand\xraum@fontsize{12pt}}%
\PassOptionsToClass{\xraum@fontsize}{article}%

% Page size
\newcommand\xraum@papersize{a4paper} % Set default as a4paper
\DeclareOption{a4paper}{\renewcommand\xraum@papersize{a4paper}}%
\DeclareOption{a5paper}{\renewcommand\xraum@papersize{a5paper}}%
\PassOptionsToClass{\xraum@papersize}{article}%

% Column layout
\newif\if@oneside\@onesidefalse
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{article}\@onesidetrue}%
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{article}}%

% Generates warning for unknown options
\DeclareOption*{
\ClassWarning{xraum}{Unknown or non-standard option '\CurrentOption'.
I'll see if I can load it from the article class. If you get a warning
unused global option(s): `\CurrentOption` then the option is not
supported!}
\PassOptionsToClass{\CurrentOption}{article}%
}

% Process options and load class
\ProcessOptions\relax%
\LoadClass{article}%

% Packages
\RequirePackage{ifthen}   % Conditional statements
\RequirePackage{iftex}    % Check for LaTeX, XeLaTeX, etc.
\RequirePackage{calc}     % Calculate vertical spacing
\RequirePackage{keyval}   % Key/Value statements
\RequirePackage{etoolbox} % A toolbox of programming facilities
\RequirePackage{varwidth} % A variable-width minipage
\RequirePackage{xspace}   % Adds a space at the end of a textmacro
\RequirePackage{textcase} % Case conversion ignoring mathematics, etc.
\RequirePackage{setspace} % Set space between lines
\RequirePackage{xfrac}    % Nice fractions
\RequirePackage{hologo}   % Better TeX/LaTex/XeLaTeX logos

% Set the geometry for the pages
\RequirePackage{geometry}
  \geometry{%
    paperwidth=210mm,
    paperheight=297mm
  }

% Tighten up space between displays (e.g., equations) and make symmetric (from tufte-latex)
\setlength\abovedisplayskip{6pt plus 2pt minus 4pt}%
\setlength\belowdisplayskip{6pt plus 2pt minus 4pt}%

% Paragraph identation
\RequirePackage[parfill]{parskip}
\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt plus 2pt minus 4pt}
\setlength{\emergencystretch}{3em}
\frenchspacing

% Misc layout settings
\lefthyphenmin=3
\righthyphenmin=3 % Disable single lines at the start of a paragraph
\clubpenalty=10000 % Disable single lines at the end of a paragraph
\widowpenalty=10000
\displaywidowpenalty=10000 % Formulas

% Clear header style on the last empty odd pages
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else%
	\hbox{}%
	\thispagestyle{empty} % Empty header styles
	\newpage%
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}

% Add Bibliography, List of figures and tables to ToC
\RequirePackage{titlesec}
\RequirePackage[nottoc]{tocbibind}
  \renewcommand{\contentsname}{Table of contents}
  \renewcommand{\listfigurename}{List of figures}
  \renewcommand{\listtablename}{List of tables}

% Extra control of appendices
\RequirePackage[title,titletoc]{appendix}
  \renewcommand{\appendixtocname}{List of appendices}

% Hide Contents appearing from ToC, but add it to bookmarks
\let\temptableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
  \cleardoublepage
  \pdfbookmark[0]{\contentsname}{Contents}
  \temptableofcontents
}

% Removes pagenumber appearing from TOC
\addtocontents{toc}{\protect\thispagestyle{empty}}
\addtocontents{toc}{\protect\vspace*{3ex}} % Put vertical space in the ToC after the ‘Contents’ header

% Colors, graphics and figures
\RequirePackage[usenames, dvipsnames]{xcolor}
\RequirePackage{latexcolors}
% \definecolor{darkpowderblue}{rgb}{0.0, 0.2, 0.6}
% \definecolor{cadmiumred}{rgb}{0.89, 0.0, 0.13}

\RequirePackage{graphicx}
  \setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}
  \DeclareGraphicsExtensions{.png, .jpg, .pdf}

% Fonts
% Use fontspec and OpenType fonts with XeLaTeX
\RequirePackage{fontspec}
  \defaultfontfeatures{Mapping=tex-text}
  \setmainfont{adobedevanagari}[%
    Extension   = .otf,
    UprightFont = *-regular,
    ItalicFont  = *-italic,
    BoldFont    = *-bold,
    BoldItalicFont = *-bolditalic
  ]
% Multilingual support
\RequirePackage{polyglossia}
  \setdefaultlanguage{english}
  \setotherlanguage{sanskrit}

% Sanskrit text in Roman tranliteration
\newfontfamily\sanskritfont{Adobe Devanagari}[Scale=MatchLowercase]
\newcommand{\tl}[1]{\sanskritfont\emph{#1}}
% Sanskrit text in Devanāgarī
\newfontfamily\devanagarifont{Adobe Devanagari}[Script=Devanagari,Scale=MatchUppercase]
\newcommand{\dn}[1]{{\devanagarifont#1}}

\newenvironment{shloka}[1] %\itshape for IAST; \devanagarifont for Devanāgarī
  {\bigskip\center#1\varwidth{\linewidth}}
  {\endvarwidth\endcenter\bigskip}

% Items
\RequirePackage{enumitem}
  \setlist[itemize]{noitemsep}
  \setlist[enumerate]{noitemsep}
  \setlist[description]{noitemsep}
  \setlist[enumerate]{label = \arabic*.}

% Fine-tune hyperreferences (hyperref should be called last)
\RequirePackage{hyperref}
\RequirePackage{url}
  \hypersetup{%
    breaklinks=true,%
    linktocpage,%
    colorlinks=true,%
    linkcolor=darkpowderblue,%
    urlcolor=darkpowderblue,%
    citecolor=darkpowderblue,%
    anchorcolor=darkpowderblue,%
    pdfdisplaydoctitle=true%
  }
  \urlstyle{same}

% Subtitle (optional)
\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}

% Subjectline (This subject will appear in the PDF meta-information
% called `pdfsubject`.)
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{#1}}

% Keywords (These keywords will appear in the PDF meta-information
% called `pdfkeywords`.)
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

% PDF meta-information
\AtBeginDocument{
  \hypersetup{%
    pdftitle={\@title},%
    pdfauthor={\@author},%
    pdfsubject={\@subject},%
    pdfkeywords={\@keywords},%
    pdfcreator={XeLaTeX},%
    pdfproducer={LaTeX with hyperref and Xraum}%
  }
}

% \diatop, used for r underdot overbar (ṝ)
% E.g: \diatop[\'|{\=o}] gives o macron acute.
\def\diatop[#1|#2]{\leavevmode{\setbox1=\hbox{{#1{}}}\setbox2=\hbox{{#2{}}}%
\dimen0=\ifdim\wd1>\wd2\wd1\else\wd2\fi%
\dimen1=\ht2\advance\dimen1by-1ex%
\setbox1=\hbox to1\dimen0{\hss#1\hss}%
\rlap{\raise1\dimen1\box1}%
\hbox to1\dimen0{\hss#2\hss}}}%

% Local generic author-facing macros:
\newcommand*\note[1]{\unskip\footnote{#1}}
\newcommand*\email[1]{\href{mailto:#1}{\nolinkurl{#1}}}

\newcommand{\st}{\textsuperscript{\textup{st}}\xspace}
\newcommand{\nd}{\textsuperscript{\textup{nd}}\xspace}
\newcommand{\rd}{\textsuperscript{\textup{rd}}\xspace}
\renewcommand{\th}{\textsuperscript{\textup{th}}\xspace}

\def\bce{\textsc{bce}\xspace}
\def\ce{\textsc{ce}\xspace}
\let\BC\bce \let\BCE\bce \let\AD\ce \let\CE\ce

\def\eg{\textit{e.g.,}\xspace}
\def\ie{\textit{i.e.,}\xspace}
\def\Eg{\textit{E.g.,}\xspace}
\def\Ie{\textit{I.e.,}\xspace}
\def\viz{\textit{viz.}\@\xspace}
\def\etal{\textit{et~al.}\@\xspace}
\def\etc{\textit{etc.}\@\xspace}
