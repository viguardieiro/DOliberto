% https://tex.stackexchange.com/questions/393209/maketitle-output-invading-text/

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{doliberto}[2017/09/21 Mesquita's D.O. class]

% 
%% load article class with options
\LoadClass[twocolumn, a4paper, 10pt]{article}

% pass unused options to article
\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%
%% package loading
\RequirePackage{polyglossia} % portuguese language support
\RequirePackage{graphicx} % image support
\RequirePackage{fancyhdr} % customize header and footer
\RequirePackage[portuges]{datetime2} % to display time
\RequirePackage{datetime2-calc} % idem
\RequirePackage{titlesec} %
\RequirePackage{titletoc}
\RequirePackage{geometry}
\RequirePackage[citecolor=black,pagebackref,breaklinks=true,plainpages=false]{hyperref} % to make links
% \RequirePackage[skins]{tcolorbox}


\geometry{
 a4paper,
 total={170mm,257mm},
 left=10mm,
 right=10mm
 }

% brazilian portuguese support in XeLaTeX
\setmainlanguage{portuges}

% size of column separator
\setlength{\columnseprule}{0.4pt}

%
%% variables

% counters
\newcounter{issue}
\newcommand\currentissue[1]{\setcounter{issue}{#1}}
\newcounter{month}
\newcommand\currentmonth[1]{\setcounter{month}{#1}}
\newcounter{year}
\newcommand\currentyear[1]{\setcounter{year}{#1}}
\newcounter{day}
\newcommand\currentday[1]{\setcounter{day}{#1}}

% date
\newcommand{\dataextenso}{\arabic{day} de \DTMportugesmonthname{\arabic{month}} de \arabic{year}}

% whose D.O.
\renewcommand{\@author}{Prefeitura Municipal de Mesquita}
\newcommand{\@email}{anexogabinete@mesquita.rj.gov.br}
\newcommand{\@site}{http://www.mesquita.rj.gov.br/}
\newcommand{\@location}{Mesquita}
\newcommand{\@logopath}{prefeitura-mesquita.jpg}

%
%% text dimensions % defaults
%\setlength\topmargin{-52pt} % article=-58pt newspaper=-48pt
%\setlength\headheight{0pt} % article=12pt newspaper=0pt
%\setlength\headsep{20pt} % article=25pt newspaper=34pt
%\setlength\marginparwidth{-20pt} % article=121pt newspaper=-20pt
%\setlength\textwidth{480pt} % article=418pt newspaper=504pt
%\setlength\textheight{684pt} % article=296pt newspaper=684pt
%\setlength\oddsidemargin{0pt} % newspaper=-30pt
%setlength\evensidemargin{0pt}

\fancypagestyle{firstpage}{
\lhead{}
\chead{}
\rhead{}
\lfoot{{\footnotesize \url{\@site}}}
\cfoot{\thepage}
\rfoot{{\footnotesize \href{mailto:\@email}{\@email}}}
\renewcommand{\footrulewidth}{0.4pt}
\renewcommand{\headrulewidth}{0pt}
}

% to really emulate Mesquita's DO, we can use http://mirrors.concertpass.com/tex-archive/macros/latex/contrib/tcolorbox/tcolorbox.pdf
% https://tex.stackexchange.com/questions/146781/place-image-and-text-in-same-title-line

\newcommand{\dolimaketitle}{\thispagestyle{firstpage}
  \twocolumn[{
    \vspace*{-40pt}
    \begin{center}
      {\setlength\fboxsep{3mm}\raisebox{12pt}{
        \parbox[c][2.5cm][c]{3cm}{\includegraphics[height=2.5cm]{\@logopath}}}}
    \hfill%
    \parbox[c][1.9cm][c]{0.75\textwidth}{{\Large\bfseries{\@author}}\\{\fontsize{1.5cm}{2.25cm}\selectfont \phantom{.} %to make spacing nicer
        \MakeUppercase{Diário Oficial}}}\\%	
    \vspace*{0.1in}
    \rule[0pt]{\textwidth}{0.5pt}\\
    \makebox[0.33\textwidth][l]{\@location, \dataextenso}
    \makebox[0.33\textwidth][c]{\textbf{Nº \arabic{issue}}}\\
    \rule[6pt]{\textwidth}{1.2pt}
  \end{center}
  }]}

\pagestyle{fancy}
\lhead{{\small\@location, \dataextenso}}
\chead{\textbf{Diário Oficial Nº \arabic{issue}}}
\rhead{{\small \@author}}
\lfoot{{\footnotesize \url{\@site}}}
\cfoot{\thepage}
\rfoot{{\footnotesize \href{mailto:\@email}{\@email}}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\setcounter{secnumdepth}{0}

%
%% DOli macros

%% macros

% sumário
\addto\captionsportuges{% Replace "english" with the language you use
  \renewcommand{\contentsname}%
    {Sumário}%
}

\newcommand{\dolitoc}{
  \framebox[0.9\columnwidth][c]{\begin{minipage}[c]{0.9\columnwidth}{
        \begin{center}
          {\Large \bfseries \MakeUppercase{Poder Executivo}}
          \vskip 0.25cm
          {\large \MakeUppercase{Jorge Miranda}}\\\textbf{Prefeito}
          \vskip 0.125cm
        \MakeUppercase{Waltinho Paixão}\\\textbf{Vice-Prefeito}
      \end{center}}
  \end{minipage}}
  {\small \tableofcontents}
}

% título do ato
\newcommand\headline[1]{\begin{center} {\bfseries \MakeUppercase{#1}} \end{center} \par}
% quem assina
\newcommand\byline[2]{\begin{center} {\bfseries \MakeUppercase{#1}} \\%
			{\small\bfseries #2} \\ %
			\rule[3pt]{0.4\hsize}{0.5pt}\\ \end{center} \par}
% separando seções de cada secretaria
\newcommand\closesection{{\begin{center}\rule[6pt]{\hsize}{1pt}\vspace*{-16pt}
      \rule{\hsize}{0.5pt}\end{center}}}

% environment para a seção de notícias de cada secretaria
\newenvironment{dolisection}[1]{\section{#1}}{\closesection}

% tables
% https://tex.stackexchange.com/questions/345379/table-in-two-column
% https://tex.stackexchange.com/questions/345394/inserting-a-table-in-a-two-column-document

%% this must be in .tex file
% \titleformat*{\section}[block]{\large\bfseries\filcenter}{\thesection}{1em}{\MakeUppercase}