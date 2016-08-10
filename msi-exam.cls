% This is a style file for MSI exams, developed by Linda Stals, Griffith Ware, and Scott Morrison
%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
% 
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{msi-exam}
  [2016/08/10 v0.01 LaTeX package for MSI exams]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions \relax

\LoadClass[a4paper,12pt]{article}


\usepackage{amsmath, amssymb, amsfonts, latexsym}
%\usepackage{arydshln}
\usepackage{setspace}
\usepackage{graphicx}
\usepackage{epstopdf}
\usepackage{fancyhdr}
\usepackage{color}
\usepackage{bm}
\usepackage[nomessages]{fp}

\usepackage[T1]{fontenc}
\usepackage{microtype}
\usepackage{ifthen}
\usepackage{libertine}
\usepackage[libertine]{newtxmath}

\usepackage{silence}
\WarningFilter{latexfont}{Font shape}
\WarningFilter{latexfont}{Size substitutions}

\usepackage{tikz}

\newboolean{showanswer}
\newboolean{showgrade}


\newcommand{\beginsolution}{Write your solution here}
\newcommand{\beginsubsolution}{Work space for question}
\newcommand{\extraspaceforquestion}{Extra space for previous question}


%% we need to do this before loading the lastpage package, which messes with \AtEndDocument
\AtEndDocument{
    %---------------------------- End of Exam --------------------------------
    \vfill
    \begin{center}
    \begin{picture}(200,30)(0,0)
    \put(0,20){\line(1,0){200}} \put(40,10){\line(1,0){120}}
    \end{picture}
    \end{center}
}

\usepackage{atveryend}
\usepackage{zref-base}

\newcounter{storequestion}
\newcounter{typesetitems}


\makeatletter
\newcommand*{\storequestion}[1]{%
  \@bsphack
  \begingroup
    \stepcounter{storequestion}%
    \zref@setcurrent{default}{#1}%
    \zref@wrapper@immediate{%
      \zref@labelbyprops{question\the\value{storequestion}}{default}%
    }%
  \endgroup
  \@esphack
}
\AfterLastShipout{%
  \zref@wrapper@immediate{%
    \zref@setcurrent{default}{\the\value{storequestion}}%
    \zref@labelbyprops{lastquestion}{default}%
  }%
}
\newcommand*{\typesetmarkboxes}{%
  \zref@refused{lastquestion}%
  \ifnum\zref@extractdefault{lastquestion}{default}{0}>0 %
    \begin{tikzpicture}[scale=1.6]
    \count@=0 %
    \FPeval{\partialsum}{0}
    \@whilenum\count@<\zref@extractdefault{lastquestion}{default}{0}\relax
    \do{%
      \advance\count@ by\@ne
      \draw (\count@, 0) rectangle (\count@ + 1, 1);
      \draw (\count@, 1) rectangle (\count@ + 1, 2);
      \node at (\count@ + 0.5, 1.5) {Q\the\count@};
      \node at (\count@ + 0.8, 0.2) {\tiny $\zref@extract{question\the\count@}{default}$};
      \FPeval{\partialsum}{clip((partialsum) + \zref@extract{question\the\count@}{default})}%
      \zref@refused{question\the\count@}%
    }%
    \draw (\count@ + 2, 0) rectangle (\count@ + 4, 1);
    \draw (\count@ + 2, 1) rectangle (\count@ + 4, 2);
    \node at (\count@ + 3, 1.5) { Total / \partialsum };
    \end{tikzpicture}%
  \fi
}
\makeatother

\usepackage{lastpage}
\newcommand{\examTotalpages} {\pageref{LastPage}}

\usepackage{environ}
%-------------------------
% Show/Hide the answers
%-------------------------
\NewEnviron{answer}{
    \ifthenelse{\boolean{showanswer}}{
      {\color{blue}{\bf Answer} \it \BODY}
    }{}
}
\NewEnviron{grading}{
    \ifthenelse{\boolean{showgrade}}{
      \singlespace {\color{red}{\bf Grading Scheme:}  \tt \begin{itemize}\BODY \end{itemize}}
    }{}
}

%-----------------------------------

%-----------------------------------
\lfoot{}%
\cfoot{}%
\rfoot{\examFooter, Page \thepage\ of \examTotalpages}

\lhead{}%
\chead{}%
\rhead{}


\textwidth=15.5cm \textheight=24.5cm \marginparsep=0cm
\oddsidemargin=0cm \evensidemargin=0cm \topmargin=-1.0cm
\parindent=0cm

\thispagestyle{fancy}

\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}

\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{1pt}

\newcommand{\points}[1]{{\hspace*{\fill}\textbf{#1~pts}}}
\newcommand{\subpoints}[1]{{\hspace*{\fill}\textit{#1~pts}}}

\renewcommand{\labelenumi}{(\alph{enumi})}
\renewcommand{\labelenumii}{(\roman{enumii})}
\renewcommand{\labelenumiii}{(\arabic{enumiii})}
\newenvironment{subquestion}{%
\begin{enumerate}}{\end{enumerate}}



\def\qrule{

    \vspace{5pt}
    \hrule height 0.25pt depth 0.25pt
    \vspace{5pt}
    }

\mathsurround 1pt
\newcommand{\ms}{\vspace{3mm}}
\newcommand{\nc}{\newcommand}
\nc{\ba}{\begin{array}}
\nc{\ea}{\end{array}}
\nc{\een}{\end{enumerate}}
\nc{\ben}{\begin{enumerate}}
\nc{\bde}{\begin{description}}
\nc{\ede}{\end{description}}
\nc{\tsc}{\textsc}
\nc{\mbf}{\mathbf}
\nc{\tbf}{\textbf}
\nc{\noi}{\noindent}
\nc{\bit}{\begin{itemize}}
\nc{\eit}{\end{itemize}}
\nc{\msnoi}{\ms \\ \noi}
%\newcommand{\noi}{\noindent}
\nc{\beqnry}{\begin{eqnarray}}%
\nc{\eeqnry}{\end{eqnarray}}%
\nc{\non}{\nonumber}%
\nc{\R}{\mathbb{R}}%
\newcommand{\col}{\operatorname{col}}
\newcommand{\nul}{\operatorname{nul}}
\newcommand{\trace}{\operatorname{trace}}
\newcommand{\spanset}{\operatorname{span}}
\newcommand{\adj}{\operatorname{adj}}



\newcounter{question}

\newenvironment{question}[1]{
    \stepcounter{question}
    \storequestion{#1}%
    \clearpage
    \noi\tbf{\gdef\quest{\the\value{question}}Question \quest \quad\points{#1}}\qrule    
}{}


\def\subquestionworkspacetitle{
    \vspace{10pt}
    \hrule height 0.25pt depth 0.25pt
    \vspace{5pt}
    \noindent\hspace{-1.1cm}
    \text{\beginsubsolution}
    \vfill
    }

\def\workspacetitle{
    \vspace{10pt}
    \hrule height 0.25pt depth 0.25pt
    \vspace{5pt}
    \noindent
    \text{\beginsolution}
    \vfill
    }

\def\extraspacetitle{
    \vspace{10pt}
    \hrule height 0.25pt depth 0.25pt
    \vspace{5pt}
    \noindent
    \text{\extraspaceforquestion}
    \vfill
    }

\def\workspace{\workspacetitle}
\def\extraspace{\clearpage\extraspacetitle}
\def\subquestionworkspace{\subquestionworkspacetitle
\hrule height 0.25pt depth 0.25pt}
\def\sqworkspace{\subquestionworkspace}



%------------------------
% fancy matrices
 
\makeatletter
\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
   \hskip -\arraycolsep
   \let\@ifnextchar\new@ifnextchar
   \array{#1}}
 \makeatother

\newcommand{\qtitle}{}


\AtBeginDocument{
    \thispagestyle{plain}


    \raisebox{-0.7\height}{\includegraphics[width=4cm]{anu-logo.png}}\hfill
    %=====================================
    % Student Number
    %=====================================
    \begin{minipage}[t]{0.625\textwidth}
    \vspace{-0.5cm}\mbox{\,}Student
          Number:\\[-1.35cm]
    \mbox{
    \setlength{\unitlength}{2500sp}%
    \begin{picture}(2500,1824)(500,-4123)
    \thinlines
    \put(1350,-3500){\line(
          0,-1){900}}
    \put(2250,-3500){\line(
          0,-1){900}}
    \put(3150,-3500){\line(
          0,-1){900}}
    \put(4050,-3500){\line(
          0,-1){900}}
    \put(4950,-3500){\line(
          0,-1){900}}
    \put(5850,-3500){\line(
          0,-1){900}}
    \put(6750,-3500){\line(
          0,-1){900}}
    \put(7650,-3500){\line(
          0,-1){900}}
    \put(450,-4400){\framebox(7200,900){}}
    \put(790,-4120){u}   
    \end{picture}
    }
    \end{minipage}


    \begin{center}

    \vspace{0.6cm}
    %\vspace{3mm}


    {\large{\textbf{Mathematical Sciences Institute}}} \vspace{3mm}

    {\large \textbf{EXAMINATION: } \examTitleOne} \vspace{3mm}

    {\large {\textbf{\examTitleTwo}}}
    \vspace{3mm}

    {\large \examTitleThree} \vspace{5mm}

    \end{center}

    \vspace{-0.2cm}
    \hrule
    \vspace*{0.5cm}
    \begin{tabular}{@{}lr}
    {\bf Exam Duration: } &\examTime\ minutes.
    \\[1mm]
    {\bf Reading Time: } &\examRead\ minutes.
    \end{tabular}
    \vspace{5mm}

    %{\bf Exam Conditions:}
    %\vspace*{1mm}
    %\examConditions

    {\bf Materials Permitted In The Exam Venue:}

    \examPermitted

    \vspace*{2mm}
    \hrule
    \vspace*{5mm}

    {\bf Materials To Be Supplied To Students:}

    \examMaterial
    \vspace*{2mm}
    \hrule

    \vspace*{5mm} {\bf Instructions To Students:}

    \examImportantNotes


    \vfill
    \begin{center}
    \mbox{
    \typesetmarkboxes
    }
    \end{center}

    \newpage
    \onehalfspacing    
    \thispagestyle{fancy}
 
}



\endinput
%%
%% End of file `mypackage.sty'.