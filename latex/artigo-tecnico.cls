% artigo-tecnico.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{artigo-tecnico}[2026/06/06 Classe para artigo tecnico]

\LoadClass[9pt,a4paper,twocolumn,twoside]{article}

\RequirePackage{xparse}
\RequirePackage[
  a4paper,
  top=20mm,
  bottom=20mm,
  left=20mm,
  right=20mm,
]{geometry}

\RequirePackage[hidelinks]{hyperref}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[utf8]{inputenc}
\RequirePackage[brazilian]{babel}
\RequirePackage{indentfirst}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{caption}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage[alf]{abntex2cite}
\RequirePackage[acronym,nomain]{glossaries}
\RequirePackage[brazilian,nameinlink,noabbrev]{cleveref}
\RequirePackage{siunitx}
\RequirePackage{float}

\makeglossaries
\renewcommand*{\acronymname}{Lista de siglas}
\NewDocumentCommand{\sigla}{m m m}{\newacronym{#1}{#2}{#3}}
\NewDocumentCommand{\imprimirsiglas}{}{\printglossary[type=\acronymtype,title={Lista de siglas}]}

\NewDocumentCommand{\xref}{m m}{\hyperref[#1]{#2}}

\NewDocumentCommand{\Eqref}{m}{\Cref{#1}}
\NewDocumentCommand{\eqlabel}{m}{\label{#1}}
% There is an \eqref from amsmath I'm overriding here
\RenewDocumentCommand{\eqref}{m}{\cref{#1}}

\NewDocumentCommand{\figlabel}{m}{\label{#1}}
\NewDocumentCommand{\Figref}{m}{\Cref{#1}}
\NewDocumentCommand{\figref}{m}{\cref{#1}}

\NewDocumentCommand{\tablabel}{m}{\label{#1}}
\NewDocumentCommand{\Tabref}{m}{\Cref{#1}}
\NewDocumentCommand{\tabref}{m}{\cref{#1}}

\newcommand{\ArticleLineStretch}{1.15}
\setstretch{\ArticleLineStretch}
\setlength{\parindent}{5mm}
\setlength{\parskip}{0pt}

\newlength{\linespace}
\setlength{\linespace}{1\baselineskip}

\setlength{\columnsep}{5mm}
\pagestyle{empty}
\raggedbottom

% Seções como no modelo: 1. INTRODUÇÃO
\titleformat{\section}
  {\normalfont\bfseries\raggedright\uppercase}
  {\thesection.~}
  {0pt}
  {}

\titleformat{\subsection}
  {\normalfont\bfseries}
  {\thesubsection~}
  {0pt}
  {}

\titlespacing*{\section}{0pt}{\linespace}{\linespace}
\titlespacing*{\subsection}{0pt}{\linespace}{\linespace}

% Figuras e tabelas no estilo: Figura 01 / Tabela 01
\renewcommand{\figurename}{Figura}
\renewcommand{\tablename}{Tabela}
\captionsetup{
  font=footnotesize,
  labelfont=bf,
  labelsep=newline,
  justification=raggedright,
  singlelinecheck=false
}

\renewcommand{\thefigure}{\ifnum\value{figure}<10 0\fi\arabic{figure}}
\renewcommand{\thetable}{\ifnum\value{table}<10 0\fi\arabic{table}}

% Dados do artigo
\NewDocumentCommand{\articletitle}{m}{
  \noindent{\fontsize{18}{22}\selectfont\bfseries\raggedright #1\par}
  \addvspace{2\linespace}
}

\NewDocumentCommand{\articleauthors}{m}{
  \addvspace{2\linespace}
  \begin{flushright}
    {\bfseries #1}
  \end{flushright}
  \addvspace{\linespace}
}

\NewDocumentEnvironment{affiliations}{}
  {
    \addvspace{\linespace}
    \begin{flushright}
    \begin{minipage}{0.95\textwidth}
    \raggedleft\normalfont\fontsize{9}{11}\selectfont
  }
  {
    \end{minipage}
    \end{flushright}
    \addvspace{2\linespace}
  }

\NewDocumentCommand{\affiliation}{m m m}{
  #1 -- #2, #3\par
}

\NewDocumentCommand{\correspondence}{m}{
  * -- Correspondência: #1\par
}

\NewDocumentCommand{\doireserved}{}
{
  \addvspace{\linespace}
  \begin{flushright}
    {\bfseries Área reservada para DOI}
  \end{flushright}
  \addvspace{\linespace}
}

% Resumo / Abstract
\NewDocumentEnvironment{resumo}{m}
  {
    \addvspace{\linespace}
    \begingroup
    \setlength{\parindent}{0pt}
    \section*{Resumo}
  }
  {
    \par\addvspace{\linespace}\noindent\textbf{Palavras-chave:} #1.
    \addvspace{\linespace}
    \endgroup
    \glsresetall
  }

\NewDocumentEnvironment{abstractpt}{m}
  {
    \addvspace{\linespace}
    \begingroup
    \setlength{\parindent}{0pt}
    \itshape
    \section*{\textit{Abstract}}
  }
  {
    \par\addvspace{\linespace}\noindent\textbf{Keywords:} #1.
    \addvspace{\linespace}
    \endgroup
  }

% Seções não numeradas finais
\NewDocumentCommand{\agradecimentos}{}
{
  \section*{Agradecimentos}
}

\NewDocumentCommand{\referencias}{}{%
  \renewcommand{\refname}{Referências bibliográficas}%
  \section*{Referências bibliográficas}%
  \vspace{-\linespace}% ajuste fino se precisar
  \setstretch{\ArticleLineStretch}%
  \setlength{\parindent}{0pt}%
}

\renewenvironment{thebibliography}[1]
  {%
    \setstretch{\ArticleLineStretch}%
    \let\oldemph\emph
    \renewcommand{\emph}[1]{\textbf{##1}}%
    \let\oldtextit\textit
    \renewcommand{\textit}[1]{\textbf{##1}}%

    \list{}{%
      \setlength{\leftmargin}{0.6cm}%
      \setlength{\itemindent}{-0.6cm}%
      \setlength{\labelwidth}{0pt}%
      \setlength{\labelsep}{0pt}%
      \setlength{\itemsep}{0pt}%
      \setlength{\parsep}{0pt}%
      \setlength{\topsep}{0pt}%
      \setlength{\partopsep}{0pt}%
    }%
  }
  {%
    \endlist
    \let\emph\oldemph
    \let\textit\oldtextit
  }
