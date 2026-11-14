\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cvjc}[2024/05/17 Joe Clarke's CV]

\LoadClass[a4paper, 10pt, oneside]{article}

% Fonts
\RequirePackage{fontspec}
% Formatting
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{url}
\RequirePackage{parskip}
% Graphics
\RequirePackage{color}
\RequirePackage{graphicx}
\RequirePackage[usenames,dvipsnames]{xcolor}
% Format A4 page
\RequirePackage[big]{layaureo}
% Custom \section style
\RequirePackage{titlesec}
% Multipage tables
\RequirePackage{longtable}
% Bibliography for publications
\RequirePackage[maxbibnames=99, style=authoryear, sorting=ydnt]{biblatex}
% Tabular bibliography
\RequirePackage{biblatex-ext-tabular}
% For if statements in bibliography
\RequirePackage{etoolbox}

% Setup hyperref package, and colours for links
\RequirePackage{hyperref}
\urlstyle{same}
\definecolor{linkcolour}{rgb}{0,0.2,0.6}
\hypersetup{colorlinks,breaklinks,urlcolor=linkcolour, linkcolor=linkcolour}

% Fonts
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Path=fonts/, SmallCapsFont = Fontin-SmallCaps.otf, BoldFont = Fontin-Bold.otf, ItalicFont = Fontin-Italic.otf, Numbers=OldStyle]{Fontin.otf}

% Define link to have same behaviour as href
\newcommand{\link}[2]{\href{#1}{#2}}

% Define section formatting inspired  by http://stefano.italians.nl/archives/26
\titleformat{\section}{\Large\scshape\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0pt}{3pt}{3pt}
\let\oldsection\section
\renewcommand{\section}[1]{\oldsection{\lowercase{#1}}}

% Pages are not numbered
\pagestyle{empty}

% Title to go across top of page
\newcommand{\header}[2]{\par{\centering {\Huge #1 \textsc{#2}}\bigskip\par}}

% Environment for contact information
\newcounter{isfirst}
\newenvironment{contact}{%
  \setcounter{isfirst}{1}
  \newcommand{\info}[2]{%
    \ifnum\value{isfirst}=1
    \setcounter{isfirst}{0}
    \else
    \\
    \fi
    \textsc{##1:} & ##2}
  \begin{tabular}{rl}}{%
  \end{tabular}
}

% Environment for dated information
\newenvironment{events}{%
  \newcommand{\event}[3]{%
    ##1 & ##2 \\
    & \footnotesize{##3} \\
    \multicolumn{2}{c}{} \\
  }
  \begin{tabular}{r|p{11cm}}
    }{%
  \end{tabular}
}


%% Bibliography

% Load bib file
\newcommand{\publicationlist}[1]{\addbibresource{#1}}

% No new page for bibliography
\patchcmd{\thebibliography}{\chapter*}{\section*}{}{}

% Extra info about publications printed in footnote size
\DeclareFieldFormat{addendum}{\par \footnotesize{#1}}

% Print year only the first time
\newcommand{\biblioyear}[1]{\ifcsdef{bibyeartest#1}{}{#1\expandafter\xdef\csname bibyeartest#1\endcsname{#1}}}
\newcommand{\biblioyeartalk}[1]{\ifcsdef{bibyeartesttalk#1}{}{#1\expandafter\xdef\csname bibyeartesttalk#1\endcsname{#1}}}

% Bibliography format for published works
\defbibtabular{published}{%
  \begin{longtable}{r|p{11cm}}}{%
  \end{longtable}}{
  \anchorlang{\biblioyear{\thefield{year}}} & \driver{} \\
  \multicolumn{2}{c}{} \\
}

% Bibliography format for talks given 
\defbibtabular{talks}{%
  \begin{longtable}{r|p{11cm}}}{%
  \end{longtable}}{%
  \anchorlang{\biblioyeartalk{\thefield{year}}} & \anchorlang{\thefield{title}}, \anchorlang{\textbf{\thefield{month}}} \\
                                                & \anchorlang{\footnotesize{\thefield{note}}} \\
  \multicolumn{2}{c}{} \\
}

 
% Print users name in bold.
% Bolding solution comes from https://tex.stackexchange.com/a/304968
\renewcommand*{\mkbibnamegiven}[1]{\ifitemannotation{highlight}{\textbf{#1}}{#1}}
\renewcommand*{\mkbibnamefamily}[1]{\ifitemannotation{highlight}{\textbf{#1}}{#1}}

% Published works count as articles or phd theses  
\defbibfilter{publishedwork}{\not\type{unpublished}}
% Print bibliographies
\newcommand{\printpublications}{\nocite{*}\printbibtabular[env=published, heading=none, filter=publishedwork]}
\newcommand{\printtalks}{\nocite{*}\printbibtabular[env=talks, heading=none, type=unpublished]}
