%%
%% SCIndustria.cls
%% modified version of IEEEtran.cls 2005/09/13 version V1.6c
%%
\ProvidesClass{SCIndustria}[2005/09/13 revision V1.6c by Michael Shell]
\typeout{-- See the "SCIndustria_HOWTO" manual for usage information.}
\typeout{-- The source comments contain changelog notes.}
\NeedsTeXFormat{LaTeX2e}

% define new needed flags to indicate document options
% and set a few "failsafe" defaults
\newif\if@twocolumnmode      \global\@twocolumnmodetrue
\newif\if@draftversion       \global\@draftversionfalse
\newif\if@draftclsmode       \global\@draftclsmodefalse
\newif\if@draftclsmodefoot   \global\@draftclsmodefootfalse
\newif\if@confmode           \global\@confmodefalse
\newif\if@peerreviewoption   \global\@peerreviewoptionfalse
\newif\if@peerreviewcaoption \global\@peerreviewcaoptionfalse

% we HAVE to turn off technote as there is no
% "not a tech note" option
\newif\if@technote      \global\@technotefalse

% V1.6 we allow the user to control whether or not the
% font interword spacings are tuned to be more like
% that of SCI. The default is to tune things.
\newif\if@fonttunesettings   \global\@fonttunesettingstrue

% V1.6b flag to show if using a4paper
\newif\if@SCIusingAfourpaper      \global\@SCIusingAfourpaperfalse

% SCIndustria class scratch pad registers
% dimen
\newdimen\@SCIndustriatmpdimenA
\newdimen\@SCIndustriatmpdimenB
% count
\newcount\@SCIndustriatmpcountA
\newcount\@SCIndustriatmpcountB
% token list
\newtoks\@SCIndustriatmptoksA

% we use \@SCIptsize so that we can ID the point size (even for 9pt docs)
% as well as LaTeX's \@ptsize to retain some compatability with some
% external packages
\def\@SCIptsize{10}
\def\@ptsize{0}
% LaTeX does not support 9pt, so we set \@ptsize to 0 - same as that of 10pt
\DeclareOption{9pt}{\def\@SCIptsize{9}\def\@ptsize{0}}
\DeclareOption{10pt}{\def\@SCIptsize{10}\def\@ptsize{0}}
\DeclareOption{11pt}{\def\@SCIptsize{11}\def\@ptsize{1}}
\DeclareOption{12pt}{\def\@SCIptsize{12}\def\@ptsize{2}}


% \@SCImarginE is the side margin for equal margins
% \@SCImarginW is the wider side margin when the margins are not equal
% NOTE: BOTH of the above margins are as they appear
% on the paper - they are NOT offset by 1 inch
\DeclareOption{letterpaper}{\setlength{\paperheight}{11in}%
                            \setlength{\paperwidth}{8.5in}%
                            \def\@SCImarginE{0.680in}%
                            \def\@SCImarginW{0.775in}%
                            \@SCIusingAfourpaperfalse}


\DeclareOption{a4paper}{\setlength{\paperheight}{297mm}%
                        \setlength{\paperwidth}{210mm}%
                        \def\@SCImarginE{14.32mm}%
                        \def\@SCImarginW{17mm}
                        \@SCIusingAfourpapertrue}

\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue}

\DeclareOption{onecolumn}{\global\@twocolumnmodefalse}
% the file twocolumn.sty is not read as it changes \textwidth.
\DeclareOption{twocolumn}{\global\@twocolumnmodetrue}

% If the user selects draft, then this class AND any packages
% will go into draft mode.
\DeclareOption{draft}{\global\@draftversiontrue \global\@draftclsmodetrue
\global\@draftclsmodefoottrue}
% draftcls is for a draft mode which will not affect any packages
% used by the document.
\DeclareOption{draftcls}{\global\@draftversionfalse \global\@draftclsmodetrue
\global\@draftclsmodefoottrue}
% draftclsnofoot is like draftcls, but without the footer.
\DeclareOption{draftclsnofoot}{\global\@draftversionfalse \global\@draftclsmodetrue
\global\@draftclsmodefootfalse}
% we provide a final option just for completeness (article.cls has one)
\DeclareOption{final}{\global\@draftversionfalse \global\@draftclsmodefalse
\global\@draftclsmodefootfalse}

\DeclareOption{journal}{\global\@peerreviewoptionfalse \global\@peerreviewcaoptionfalse
\global\@confmodefalse \global\@technotefalse}

\DeclareOption{conference}{\global\@peerreviewoptionfalse \global\@peerreviewcaoptionfalse
\global\@confmodetrue \global\@technotefalse}

\DeclareOption{technote}{\global\@peerreviewoptionfalse \global\@peerreviewcaoptionfalse
\global\@confmodefalse \global\@technotetrue}

\DeclareOption{peerreview}{\global\@peerreviewoptiontrue \global\@peerreviewcaoptionfalse
\global\@confmodefalse \global\@technotefalse}

\DeclareOption{peerreviewca}{\global\@peerreviewoptiontrue \global\@peerreviewcaoptiontrue
\global\@confmodefalse \global\@technotefalse}

\DeclareOption{nofonttune}{\global\@fonttunesettingsfalse}


% SCI uses Times font, so we'll default to times.
% These three commands make up the entire times.sty package.
\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}
% enable Times now - so that all class options can see the correct font families
\normalfont\selectfont


% default to US letter paper, 10pt, twocolumn, one sided, final, journal
\ExecuteOptions{letterpaper,10pt,twocolumn,oneside,final,journal}
% overrride these defaults per user requests
\ProcessOptions

% we can send console reminder messages to the user here
\AtEndDocument{\if@confmode%
\typeout{}%
\typeout{** Conference Paper **}%
\typeout{Before submitting the final camera ready copy, remember to:}%
\typeout{}%
\typeout{ 1. Manually equalize the lengths of two columns on the last page}%
\typeout{ of your paper;}%
\typeout{}%
\typeout{ 2. Ensure that any PostScript and/or PDF output post-processing}%
\typeout{ uses only Type 1 fonts and that every step in the generation}%
\typeout{ process uses the US letter (8.5in X 11in) paper size.}%
\typeout{}%
\fi}


% warn about the use of single column other than for draft mode
\if@twocolumnmode\else%
  \if@draftclsmode\else%
   \typeout{** ATTENTION: Single column mode is not normally used with SCI publications.}%
  \fi%
\fi


% V1.6, if the user is using pdflatex, go ahead and set the output paper size.
% Otherwise, we declare the papersize via a \special for dvips.
% We keep the tests within braces because otherwise, if not using pdflatex,
% \pdfpageheight and \pdfpagewidth will be set to \relax - possibly affecting
% similar tests of other packages.
{\@ifundefined{pdfpageheight}{% not using pdflatex, setup paper size for dvips
\if@SCIusingAfourpaper
\special{papersize=210mm,297mm}%
\else
\special{papersize=8.5in,11in}%
\fi}%
{% using pdftex, set paper size for pdftex
\global\pdfpageheight\paperheight\global\pdfpagewidth\paperwidth}}



% The idea hinted here is for LaTeX to generate markleft{} and markright{}
% automatically for you after you enter \author{}, \journal{},
% \journaldate{}, journalvol{}, \journalnum{}, etc.
% However, there may be some backward compatibility issues here as
% well as some special applications for SCIndustria.cls and special issues
% that may require the flexible \markleft{}, \markright{} and/or \markboth{}.
% We'll leave this as an open future suggestion.
%\newcommand{\journal}[1]{\def\@journal{#1}}
%\def\@journal{}



% pointsize values
% used with ifx to determine the document's normal size
\def\@SCIptsizenine{9}
\def\@SCIptsizeten{10}
\def\@SCIptsizeeleven{11}
\def\@SCIptsizetwelve{12}



% FONT DEFINITIONS (No sizexx.clo file needed)
% V1.6 revised font sizes, displayskip values and
%      revised normalsize baselineskip to reduce underfull vbox problems
%      on the 58pc = 696pt = 9.5in text height we want
%      normalsize     #lines/column  baselineskip (aka leading)
%             9pt     63             11.0476pt (truncated down)
%            10pt     58             12pt      (exact)
%            11pt     52             13.3846pt (truncated down)
%            12pt     50             13.92pt   (exact)
%

% we need to store the nominal baselineskip for the given font size
% in case baselinestretch ever changes.
\newskip\@SCInormalsizefontbaselineskip
\@SCInormalsizefontbaselineskip\baselineskip

\ifx\@SCIptsize\@SCIptsizenine
\typeout{-- This is a 9 point document.}
\def\normalsize{\@setfontsize{\normalsize}{9}{11.0476pt}}%
\setlength{\@SCInormalsizefontbaselineskip}{11.0476pt}%
\normalsize
\abovedisplayskip 1.5ex plus3pt minus1pt%
\belowdisplayskip \abovedisplayskip%
\abovedisplayshortskip 0pt plus3pt%
\belowdisplayshortskip 1.5ex plus3pt minus1pt
\def\small{\@setfontsize{\small}{8.5}{10pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{8}{9pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{7}{8pt}}
\def\tiny{\@setfontsize{\tiny}{5}{6pt}}
% sublargesize is the same as large - 10pt
\def\sublargesize{\@setfontsize{\sublargesize}{10}{12pt}}
\def\large{\@setfontsize{\large}{10}{12pt}}
\def\Large{\@setfontsize{\Large}{12}{14pt}}
\def\LARGE{\@setfontsize{\LARGE}{14}{17pt}}
\def\huge{\@setfontsize{\huge}{17}{20pt}}
\def\Huge{\@setfontsize{\Huge}{20}{24pt}}
\fi


% Check if we have selected 10 points
\ifx\@SCIptsize\@SCIptsizeten
\typeout{-- This is a 10 point document.}
\def\normalsize{\@setfontsize{\normalsize}{10}{12.00pt}}%
\setlength{\@SCInormalsizefontbaselineskip}{12pt}%
\normalsize
\abovedisplayskip 1.5ex plus4pt minus2pt%
\belowdisplayskip \abovedisplayskip%
\abovedisplayshortskip 0pt plus4pt%
\belowdisplayshortskip 1.5ex plus4pt minus2pt
\def\small{\@setfontsize{\small}{9}{10pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{8}{9pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{7}{8pt}}
\def\tiny{\@setfontsize{\tiny}{5}{6pt}}
% sublargesize is a tad smaller than large - 11pt
\def\sublargesize{\@setfontsize{\sublargesize}{11}{13.4pt}}
\def\large{\@setfontsize{\large}{12}{14pt}}
\def\Large{\@setfontsize{\Large}{14}{17pt}}
\def\LARGE{\@setfontsize{\LARGE}{17}{20pt}}
\def\huge{\@setfontsize{\huge}{20}{24pt}}
\def\Huge{\@setfontsize{\Huge}{24}{28pt}}
\fi


% Check if we have selected 11 points
\ifx\@SCIptsize\@SCIptsizeeleven
\typeout{-- This is an 11 point document.}
\def\normalsize{\@setfontsize{\normalsize}{11}{13.3846pt}}%
\setlength{\@SCInormalsizefontbaselineskip}{13.3846pt}%
\normalsize
\abovedisplayskip 1.5ex plus5pt minus3pt%
\belowdisplayskip \abovedisplayskip%
\abovedisplayshortskip 0pt plus5pt%
\belowdisplayshortskip 1.5ex plus5pt minus3pt
\def\small{\@setfontsize{\small}{10}{12pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{9}{10.5pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{8}{9pt}}
\def\tiny{\@setfontsize{\tiny}{6}{7pt}}
% sublargesize is the same as large - 12pt
\def\sublargesize{\@setfontsize{\sublargesize}{12}{14pt}}
\def\large{\@setfontsize{\large}{12}{14pt}}
\def\Large{\@setfontsize{\Large}{14}{17pt}}
\def\LARGE{\@setfontsize{\LARGE}{17}{20pt}}
\def\huge{\@setfontsize{\huge}{20}{24pt}}
\def\Huge{\@setfontsize{\Huge}{24}{28pt}}
\fi


% Check if we have selected 12 points
\ifx\@SCIptsize\@SCIptsizetwelve
\typeout{-- This is a 12 point document.}
\def\normalsize{\@setfontsize{\normalsize}{12}{13.92pt}}%
\setlength{\@SCInormalsizefontbaselineskip}{13.92pt}%
\normalsize
\abovedisplayskip 1.5ex plus6pt minus4pt%
\belowdisplayskip \abovedisplayskip%
\abovedisplayshortskip 0pt plus6pt%
\belowdisplayshortskip 1.5ex plus6pt minus4pt
\def\small{\@setfontsize{\small}{10}{12pt}}
\def\footnotesize{\@setfontsize{\footnotesize}{9}{10.5pt}}
\def\scriptsize{\@setfontsize{\scriptsize}{8}{9pt}}
\def\tiny{\@setfontsize{\tiny}{6}{7pt}}
% sublargesize is the same as large - 14pt
\def\sublargesize{\@setfontsize{\sublargesize}{14}{17pt}}
\def\large{\@setfontsize{\large}{14}{17pt}}
\def\Large{\@setfontsize{\Large}{17}{20pt}}
\def\LARGE{\@setfontsize{\LARGE}{20}{24pt}}
\def\huge{\@setfontsize{\huge}{22}{26pt}}
\def\Huge{\@setfontsize{\Huge}{24}{28pt}}
\fi


% V1.6 The Computer Modern Fonts will issue a substitution warning for
% 24pt titles (24.88pt is used instead) increase the substitution
% tolerance to turn off this warning
\def\fontsubfuzz{.9pt}
% However, the default (and correct) Times font will scale exactly as needed.


% warn the user in case they forget to use the 9pt option with
% technote
\if@technote%
 \ifx\@SCIptsize\@SCIptsizenine\else%
  \typeout{** ATTENTION: Technotes are normally 9pt documents.}%
 \fi%
\fi


% set \baselinestretch
\def\baselinestretch{1}
\if@draftclsmode% draft mode uses larger than normal spacing
\def\baselinestretch{1.5} % controls line spacing for draft version
\fi                       % some people may like 1.7 or greater
                          % so that there will be even more space
                          % for hand written comments

\normalsize % make \baselinestretch take affect


% V1.6
% store the normalsize baselineskip
\newskip\normalsizebaselineskip
\normalsizebaselineskip=\baselineskip\relax
% store the nominal value of jot
\newskip\normaljot
\normaljot=0.25\normalsizebaselineskip\relax

% set \jot
\jot=\normaljot\relax


% abstract and keywords are in \small, except
% for 9pt docs in which they are in \footnotesize
% Since 9pt docs use an 8pt footnotesize, \small
% becomes a rather awkward 8.5pt
\let\@SCIabskeysecsize=\small
\ifx\@SCIptsize\@SCIptsizenine
 \let\@SCIabskeysecsize=\footnotesize
\fi



% V1.6, we are now going to fine tune the interword spacing
% The default interword glue for Times under TeX appears to use a
% nominal interword spacing of 25% (relative to the font size, i.e., 1em)
% a maximum of 40% and a minimum of 19%.
% For example, 10pt text uses an interword glue of:
%
% 2.5pt plus 1.49998pt minus 0.59998pt
%
% However, SCI allows for a more generous range which reduces the need
% for hyphenation, especially for two column text. Furthermore, SCI
% tends to use a little bit more nominal space between the words.
% SCI's interword spacing percentages appear to be:
% 35% nominal
% 23% minimum
% 50% maximum
% (They may even be using a tad more for the largest fonts such as 24pt.)
%
% for bold text, SCI increases the spacing a little more:
% 37.5% nominal
% 23% minimum
% 55% maximum

% here are the interword spacing ratios we'll use
% for medium (normal weight)
\def\@SCIinterspaceratioM{0.35}
\def\@SCIinterspaceMINratioM{0.23}
\def\@SCIinterspaceMAXratioM{0.50}

% for bold
\def\@SCIinterspaceratioB{0.375}
\def\@SCIinterspaceMINratioB{0.23}
\def\@SCIinterspaceMAXratioB{0.55}


% command to revise the interword spacing for the current font under TeX:
% \fontdimen2 = nominal interword space
% \fontdimen3 = interword stretch
% \fontdimen4 = interword shrink
% since all changes to the \fontdimen are global, we can enclose these commands
% in braces to confine any font attribute or length changes
\def\@@@SCIsetfontdimens#1#2#3{{%
\setlength{\@SCIndustriatmpdimenB}{\f@size pt}% grab the font size in pt, could use 1em instead.
\setlength{\@SCIndustriatmpdimenA}{#1\@SCIndustriatmpdimenB}%
\fontdimen2\font=\@SCIndustriatmpdimenA\relax
\addtolength{\@SCIndustriatmpdimenA}{-#2\@SCIndustriatmpdimenB}%
\fontdimen3\font=-\@SCIndustriatmpdimenA\relax
\setlength{\@SCIndustriatmpdimenA}{#1\@SCIndustriatmpdimenB}%
\addtolength{\@SCIndustriatmpdimenA}{-#3\@SCIndustriatmpdimenB}%
\fontdimen4\font=\@SCIndustriatmpdimenA\relax}}

% revise the interword spacing for each font weight
\def\@@SCIsetfontdimens{{%
\mdseries
\@@@SCIsetfontdimens{\@SCIinterspaceratioM}{\@SCIinterspaceMAXratioM}{\@SCIinterspaceMINratioM}%
\bfseries
\@@@SCIsetfontdimens{\@SCIinterspaceratioB}{\@SCIinterspaceMAXratioB}{\@SCIinterspaceMINratioB}%
}}

% revise the interword spacing for each font shape
% \slshape is not often used for SCI work and is not altered here. The \scshape caps are
% already a tad too large in the free LaTeX fonts (as compared to what SCI uses) so we
% won't alter these either.
\def\@SCIsetfontdimens{{%
\normalfont
\@@SCIsetfontdimens
\normalfont\itshape
\@@SCIsetfontdimens
}}

% if the nofonttune class option is not given, revise the interword spacing
% for each font size (and shape and weight). Only the \rmfamily is done here
% as \ttfamily uses a fixed spacing and \sffamily is not used as the main
% text of SCI papers.
\def\@SCItunefonts{%
\if@fonttunesettings
{\selectfont\rmfamily
\tiny\@SCIsetfontdimens
\scriptsize\@SCIsetfontdimens
\footnotesize\@SCIsetfontdimens
\small\@SCIsetfontdimens
\normalsize\@SCIsetfontdimens
\sublargesize\@SCIsetfontdimens
\large\@SCIsetfontdimens
\LARGE\@SCIsetfontdimens
\huge\@SCIsetfontdimens
\Huge\@SCIsetfontdimens}\fi}

% if needed, revise the interword spacing now - in case SCIndustria makes any default
% length measurements, and make sure all the default fonts are loaded
\@SCItunefonts

% and again at the start of the document in case the user loaded different fonts
\AtBeginDocument{\@SCItunefonts}



% V1.6
% LaTeX is a little to quick to use hyphenations
% So, we increase the penalty for their use and raise
% the badness level that triggers an underfull hbox
% warning. The author may still have to tweak things,
% but the appearance will be much better "right out
% of the box" than that under V1.5 and prior.
% TeX default is 50
\hyphenpenalty=750
% If we didn't adjust the interword spacing, 2200 might be better.
% The TeX default is 1000
\hbadness=1350
% SCI does not use extra spacing after punctuation
\frenchspacing



% we want to maintain textheight as an integer multiple of
% \baselineskip.  Keep \topsep in with this game plan too.
\topskip=\baselineskip
% set sizes and margins
% Book typesetting is a world where point and pica (12pt) reign supreme.
% SCI textwidth is 21 pica. They have a colsep of 1 pica.
% V1.6 conference mode margins
\if@confmode
 \topmargin        -0.25in
 \textheight        9.25in % The standard for conferences
  % However, we will adjust this a  tad so that an integer number
  % of lines will always fit on each page
  % The baselineskip (leading) for each document point size is used
  % to determine these values
  % rounded up an extra 0.1pt or so to prevent trouble with any rounding errors
 \ifx\@SCIptsize\@SCIptsizenine\textheight=674.0pt\fi      %9.3261in  61 lines/page
 \ifx\@SCIptsize\@SCIptsizeten\textheight=672.1pt\fi       %9.2998in  56 lines/page
 \ifx\@SCIptsize\@SCIptsizeeleven\textheight=669.3pt\fi   %9.2611in  50 lines/page
 \ifx\@SCIptsize\@SCIptsizetwelve\textheight=668.3pt\fi   %9.2473in  48 lines/page
\else
 \topmargin        -49.0pt
 \textheight        60pc % = 9.63in or 696pt
\fi


\textwidth         43pc   % 2 x 21pc + 1pc = 43pc
\columnsep          1pc


% SCI MARGIN INFO and new \overrideSCImargins command
% V1.6 revised margins again
% SCI wants the side margins to be equal under both US letter
% and A4 paper
%
% However, for those of you who need to bind copies of your work
% (for review distribution, etc.) the \overrideSCImargins
% command will shift the text a tad away from the binding
% edge.
%
%


% the default side margins are equal
\oddsidemargin    \@SCImarginE
\addtolength{\oddsidemargin}{-1in}% compensate for LaTeX's 1in offset
\evensidemargin   \@SCImarginE
\addtolength{\evensidemargin}{-1in}% compensate for LaTeX's 1in offset

% execute \overrideSCImargins in the preamble to make the side margin
% near the spine slightly wider so that the paper will be much more
% agreeable to being bound.  \overrideSCImargins will have no effect
% when in draft or draftcls mode.
\def\overrideSCImargins{\if@draftclsmode\relax\else%
 \typeout{** ATTENTION: Overriding SCI standard margins (line \the\inputlineno).}%
 \if@twoside
  % for double sided, odd pages have the bound side on the left
  % make this the wide margin
  \oddsidemargin\@SCImarginW
  % and even pages have the narrow margin on the left
  % as they are bound on the right
  % evensidemargin is to be the narrow margin
  % calculate the narrow margin and set evensidemargin
  \setlength{\evensidemargin}{\paperwidth}%
  \addtolength{\evensidemargin}{-\@SCImarginW}%
  \addtolength{\evensidemargin}{-\textwidth}%
 \else
  % for single sided the bound side is always on the left
  % make this the wide margin
  \oddsidemargin\@SCImarginW
  \evensidemargin\@SCImarginW
 \fi
 \addtolength{\oddsidemargin}{-1.0in}%  compensate for LaTeX's 1in offset
 \addtolength{\evensidemargin}{-1.0in}%
\fi}


\parindent        1.0em

% conference papers do not have headers, other papers need
% to reserve space for them
\if@confmode
\headsep          0in
\headheight       0in
\else
\headsep          0.5in
\headheight       12pt
\fi

% V1.6, if things get too close, go ahead and let them touch
\lineskip            0pt
\normallineskip      0pt
\lineskiplimit       0pt
\normallineskiplimit 0pt


% The distance from the lower edge of the text body to the
% footline
\footskip 0.4in

% normally zero, should be relative to font height.
% put in a little rubber to help stop some bad breaks (underfull vboxes)
\parskip 0ex plus 0.2ex minus 0.1ex



% draft mode settings override that of all other modes
% provides a nice 1" margin all around the paper and extra
% space between the lines for editor's comments
\if@draftclsmode
\headsep          0.25in
\headheight       12pt
% want 1" from top of paper to text
\setlength{\topmargin}{-\headsep}%
\addtolength{\topmargin}{-\headheight}%

% we want 1in side margins regardless of paper type
\oddsidemargin      0in
\evensidemargin     0in

% set the text width - start with the entire page
\setlength{\textwidth}{\paperwidth}%
% subtract for the 1" top/bottom margins
\addtolength{\textwidth}{-2.0in}%
% give them a textheight that won't have underfull
% vbox problems, but can't help them if they later change
% baselinestretch from its default
\setlength{\textheight}{\paperheight}%
\addtolength{\textheight}{-2.0in}%
% subtract of first line taken by \topskip
\addtolength{\textheight}{-1\topskip}%
% now digitize \textheight so that the length after
% the first line is an integer multiple of  \baselineskip
% to cut down on underfull vbox errors in draft mode
\divide\textheight  by \baselineskip%
\multiply\textheight  by \baselineskip%
% add back the first line
\addtolength{\textheight}{\topskip}%
\fi



% margin note stuff
\marginparsep      10pt
\marginparwidth    20pt
\marginparpush     25pt


% LIST SPACING CONTROLS

% Controls the amount of EXTRA spacing
% above and below \trivlist
% Both \list and IED lists override this.
% However, \trivlist will use this as will most
% things built from \trivlist like the \center
% environment.
\topsep           0.5\baselineskip

% Controls the additional spacing around lists preceded
% or followed by blank lines. SCI does not increase
% spacing before or after paragraphs so it is set to zero.
% \z@ is the same as zero, but faster.
\partopsep          \z@

% Controls the spacing between paragraphs in lists.
% SCI does not increase spacing before or after paragraphs
% so this is also zero.
% With SCIndustria.cls, global changes to
% this value DO affect lists (but not IED lists).
\parsep             \z@

% Controls the extra spacing between list items.
% SCI does not put extra spacing between items.
% With SCIndustria.cls, global changes to this value DO affect
% lists (but not IED lists).
\itemsep            \z@

% \itemindent is the amount to indent the FIRST line of a list
% item. It is auto set to zero within the \list environment. To alter
% it, you have to do so when you call the \list.
% However, SCI uses this for the theorem environment
% There is an alternative value for this near \leftmargini below
\itemindent         -1em

% \leftmargin, the spacing from the left margin of the main text to
% the left of the main body of a list item is set by \list.
% Hence this statement does nothing for lists.
% But, quote and verse do use it for indention.
\leftmargin         2em

% we retain this stuff from the older SCIndustria.cls so that \list
% will work the same way as before. However, itemize, enumerate and
% description (IED) could care less about what these are as they
% all are overridden.
\leftmargini        2em
%\itemindent         2em  % Alternative values: sometimes used.
%\leftmargini        0em
\leftmarginii       1em
\leftmarginiii    1.5em
\leftmarginiv     1.5em
\leftmarginv      1.0em
\leftmarginvi     1.0em
\labelsep         0.5em
\labelwidth         \z@


% The old SCIndustria.cls behavior of \list is retained.
% However, the new V1.3 IED list environments override all the
% @list stuff (\@listX is called within \list for the
% appropriate level just before the user's list_decl is called).
% \topsep is now 2pt as SCI puts a little extra space around
% lists - used by those non-IED macros that depend on \list.
% Note that \parsep and \itemsep are not redefined as in
% the sizexx.clo \@listX (which article.cls uses) so global changes
% of these values DO affect \list
%
\def\@listi{\leftmargin\leftmargini \topsep 2pt plus 1pt minus 1pt}
\let\@listI\@listi
\def\@listii{\leftmargin\leftmarginii\labelwidth\leftmarginii%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listiii{\leftmargin\leftmarginiii\labelwidth\leftmarginiii%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listiv{\leftmargin\leftmarginiv\labelwidth\leftmarginiv%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listv{\leftmargin\leftmarginv\labelwidth\leftmarginv%
    \advance\labelwidth-\labelsep \topsep 2pt}
\def\@listvi{\leftmargin\leftmarginvi\labelwidth\leftmarginvi%
    \advance\labelwidth-\labelsep \topsep 2pt}


% SCI uses 5) not 5.
\def\labelenumi{\theenumi)}     \def\theenumi{\arabic{enumi}}

% SCI uses a) not (a)
\def\labelenumii{\theenumii)}  \def\theenumii{\alph{enumii}}

% SCI uses iii) not iii.
\def\labelenumiii{\theenumiii)} \def\theenumiii{\roman{enumiii}}

% SCI uses A) not A.
\def\labelenumiv{\theenumiv)}   \def\theenumiv{\Alph{enumiv}}

% exactly the same as in article.cls
\def\p@enumii{\theenumi}
\def\p@enumiii{\theenumi(\theenumii)}
\def\p@enumiv{\p@enumiii\theenumiii}

% itemized list label styles
\def\labelitemi{$\scriptstyle\bullet$}
\def\labelitemii{\textbf{--}}
\def\labelitemiii{$\ast$}
\def\labelitemiv{$\cdot$}


% SCIndustria.cls version numbers, provided as of V1.3
% These values serve as a way a .tex file can
% determine if the new features are provided.
% The version number of this SCIndustrias.cls can be obtained from
% these values. i.e., V1.4
% KEEP THESE AS INTEGERS! i.e., NO {4a} or anything like that-
% (no need to enumerate "a" minor changes here)
\def\SCIndustriasversionmajor{1}
\def\SCIndustriasversionminor{6}


% **** V1.3 ENHANCEMENTS ****
% Itemize, Enumerate and Description (IED) List Controls
% ***************************
%
%
% SCI seems to use at least two different values by
% which ITEMIZED list labels are indented to the right
% For The Journal of Lightwave Technology (JLT) and The Journal
% on Selected Areas in Communications (JSAC), they tend to use
% an indention equal to \parindent. For Transactions on Communications
% they tend to indent ITEMIZED lists a little more--- 1.3\parindent.
% We'll provide both values here for you so that you can choose
% which one you like in your document using a command such as:
% setlength{\SCIilabelindent}{\SCIilabelindentB}
\newdimen\SCIilabelindentA
\SCIilabelindentA \parindent

\newdimen\SCIilabelindentB
\SCIilabelindentB 1.3\parindent
% However, we'll default to using \parindent
% which makes more sense to me
\newdimen\SCIilabelindent
\SCIilabelindent \SCIilabelindentA


% This controls the default amount the enumerated list labels
% are indented to the right.
% Normally, this is the same as the paragraph indention
\newdimen\SCIelabelindent
\SCIelabelindent \parindent

% This controls the default amount the description list labels
% are indented to the right.
% Normally, this is the same as the paragraph indention
\newdimen\SCIdlabelindent
\SCIdlabelindent \parindent

% This is the value actually used within the IED lists.
% The IED environments automatically set its value to
% one of the three values above, so global changes do
% not have any effect
\newdimen\labelindent
\labelindent \parindent

% The actual amount labels will be indented is
% \labelindent multiplied by the factor below
% corresponding to the level of nesting depth
% This provides a means by which the user can
% alter the effective \labelindent for deeper
% levels
% There may not be such a thing as correct "standard SCI"
% values. What SCI actually does may depend on the specific
% circumstances.
% The first list level almost always has full indention.
% The second levels I've seen have only 75% of the normal indentation
% Three level or greater nestings are very rare. I am guessing
% that they don't use any indentation.
\def\SCIlabelindentfactori{1.0}   % almost always one
\def\SCIlabelindentfactorii{0.75} % 0.0 or 1.0 may be used in some cases
\def\SCIlabelindentfactoriii{0.0} % 0.75? 0.5? 0.0?
\def\SCIlabelindentfactoriv{0.0}
\def\SCIlabelindentfactorv{0.0}
\def\SCIlabelindentfactorvi{0.0}

% value actually used within IED lists, it is auto
% set to one of the 6 values above
% global changes here have no effect
\def\labelindentfactor{1.0}

% This controls the default spacing between the end of the IED
% list labels and the list text, when normal text is used for
% the labels.
\newdimen\SCIiednormlabelsep
\SCIiednormlabelsep 0.6em

% This controls the default spacing between the end of the IED
% list labels and the list text, when math symbols are used for
% the labels (nomenclature lists). SCI usually increases the
% spacing in these cases
\newdimen\SCIiedmathlabelsep
\SCIiedmathlabelsep 1.2em

% This controls the extra vertical separation put above and
% below each IED list. SCI usually puts a little extra spacing
% around each list. However, this spacing is barely noticeable.
\newskip\SCIiedtopsep
\SCIiedtopsep 2pt plus 1pt minus 1pt


% This command is executed within each IED list environment
% at the beginning of the list. You can use this to set the
% parameters for some/all your IED list(s) without disturbing
% global parameters that affect things other than lists.
% i.e., renewcommand{\iedlistdecl}{\setlength{\labelsep}{5em}}
% will alter the \labelsep for the next list(s) until
% \iedlistdecl is redefined.
\def\iedlistdecl{\relax}

% This command provides an easy way to set \leftmargin based
% on the \labelwidth, \labelsep and the argument \labelindent
% Usage: \calcleftmargin{width-to-indent-the-label}
% output is in the \leftmargin variable, i.e., effectively:
% \leftmargin = argument + \labelwidth + \labelsep
% Note controlled spacing here, shield end of lines with %
\def\calcleftmargin#1{\setlength{\leftmargin}{#1}%
\addtolength{\leftmargin}{\labelwidth}%
\addtolength{\leftmargin}{\labelsep}}

% This command provides an easy way to set \labelwidth to the
% width of the given text. It is the same as
% \settowidth{\labelwidth}{label-text}
% and useful as a shorter alternative.
% Typically used to set \labelwidth to be the width
% of the longest label in the list
\def\setlabelwidth#1{\settowidth{\labelwidth}{#1}}

% When this command is executed, IED lists will use the
% SCIiedmathlabelsep label separation rather than the normal
% spacing. To have an effect, this command must be executed via
% the \iedlistdecl or within the option of the IED list
% environments.
\def\usemathlabelsep{\setlength{\labelsep}{\SCIiedmathlabelsep}}

% A flag which controls whether the IED lists automatically
% calculate \leftmargin from \labelindent, \labelwidth and \labelsep
% Useful if you want to specify your own \leftmargin
% This flag must be set (\nocalcleftmargintrue or \nocalcleftmarginfalse)
% via the \iedlistdecl or within the option of the IED list
% environments to have an effect.
\newif\ifnocalcleftmargin
\nocalcleftmarginfalse

% A flag which controls whether \labelindent is multiplied by
% the \labelindentfactor for each list level.
% This flag must be set via the \iedlistdecl or within the option
% of the IED list environments to have an effect.
\newif\ifnolabelindentfactor
\nolabelindentfactorfalse


% internal variable to indicate type of IED label
% justification
% 0 - left; 1 - center; 2 - right
\def\@iedjustify{0}


% commands to allow the user to control IED
% label justifications. Use these commands within
% the IED environment option or in the \iedlistdecl
% Note that changing the normal list justifications
% is nonstandard and SCI may not like it if you do so!
% I include these commands as they may be helpful to
% those who are using these enhanced list controls for
% other non-SCI related LaTeX work.
% itemize and enumerate automatically default to right
% justification, description defaults to left.
\def\iedlabeljustifyl{\def\@iedjustify{0}}%left
\def\iedlabeljustifyc{\def\@iedjustify{1}}%center
\def\iedlabeljustifyr{\def\@iedjustify{2}}%right




% commands to save to and restore from the list parameter copies
% this allows us to set all the list parameters within
% the list_decl and prevent \list (and its \@list)
% from overriding any of our parameters
% V1.6 use \edefs instead of dimen's to conserve dimen registers
% Note controlled spacing here, shield end of lines with %
\def\@SCIsavelistparams{\edef\@SCIiedtopsep{\the\topsep}%
\edef\@SCIiedlabelwidth{\the\labelwidth}%
\edef\@SCIiedlabelsep{\the\labelsep}%
\edef\@SCIiedleftmargin{\the\leftmargin}%
\edef\@SCIiedpartopsep{\the\partopsep}%
\edef\@SCIiedparsep{\the\parsep}%
\edef\@SCIieditemsep{\the\itemsep}%
\edef\@SCIiedrightmargin{\the\rightmargin}%
\edef\@SCIiedlistparindent{\the\listparindent}%
\edef\@SCIieditemindent{\the\itemindent}}

% Note controlled spacing here
\def\@SCIrestorelistparams{\topsep\@SCIiedtopsep\relax%
\labelwidth\@SCIiedlabelwidth\relax%
\labelsep\@SCIiedlabelsep\relax%
\leftmargin\@SCIiedleftmargin\relax%
\partopsep\@SCIiedpartopsep\relax%
\parsep\@SCIiedparsep\relax%
\itemsep\@SCIieditemsep\relax%
\rightmargin\@SCIiedrightmargin\relax%
\listparindent\@SCIiedlistparindent\relax%
\itemindent\@SCIieditemindent\relax}


% v1.6b provide original LaTeX IED list environments
% note that latex.ltx defines \itemize and \enumerate, but not \description
% which must be created by the base classes
% save original LaTeX itemize and enumerate
\let\LaTeXitemize\itemize
\let\endLaTeXitemize\enditemize
\let\LaTeXenumerate\enumerate
\let\endLaTeXenumerate\endenumerate

% provide original LaTeX description environment from article.cls
\newenvironment{LaTeXdescription}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                 \normalfont\bfseries #1}


% override LaTeX's default IED lists
\def\itemize{\@SCIitemize}
\def\enditemize{\@endSCIitemize}
\def\enumerate{\@SCIenumerate}
\def\endenumerate{\@endSCIenumerate}
\def\description{\@SCIdescription}
\def\enddescription{\@endSCIdescription}

% provide the user with aliases - may help those using packages that
% override itemize, enumerate, or description
\def\SCIitemize{\@SCIitemize}
\def\endSCIitemize{\@endSCIitemize}
\def\SCIenumerate{\@SCIenumerate}
\def\endSCIenumerate{\@endSCIenumerate}
\def\SCIdescription{\@SCIdescription}
\def\endSCIdescription{\@endSCIdescription}


% V1.6 we want to keep the SCIndustria IED list definitions as our own internal
% commands so they are protected against redefinition
\def\@SCIitemize{\@ifnextchar[{\@@SCIitemize}{\@@SCIitemize[\relax]}}
\def\@SCIenumerate{\@ifnextchar[{\@@SCIenumerate}{\@@SCIenumerate[\relax]}}
\def\@SCIdescription{\@ifnextchar[{\@@SCIdescription}{\@@SCIdescription[\relax]}}
\def\@endSCIitemize{\endlist}
\def\@endSCIenumerate{\endlist}
\def\@endSCIdescription{\endlist}


% DO NOT ALLOW BLANK LINES TO BE IN THESE IED ENVIRONMENTS
% AS THIS WILL FORCE NEW PARAGRAPHS AFTER THE IED LISTS
% SCIndustria itemized list MDS 1/2001
% Note controlled spacing here, shield end of lines with %
\def\@@SCIitemize[#1]{%
                \ifnum\@itemdepth>3\relax\@toodeep\else%
                \ifnum\@listdepth>5\relax\@toodeep\else%
                \advance\@itemdepth\@ne%
                \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
                % get the labelindentfactor for this level
                \advance\@listdepth\@ne% we need to know what the level WILL be
                \edef\labelindentfactor{\csname SCIlabelindentfactor\romannumeral\the\@listdepth\endcsname}%
                \advance\@listdepth-\@ne% undo our increment
                \def\@iedjustify{2}% right justified labels are default
                % set other defaults
                \nocalcleftmarginfalse%
                \nolabelindentfactorfalse%
                \topsep\SCIiedtopsep%
                \labelindent\SCIilabelindent%
                \labelsep\SCIiednormlabelsep%
                \partopsep 0ex%
                \parsep 0ex%
                \itemsep 0ex%
                \rightmargin 0em%
                \listparindent 0em%
                \itemindent 0em%
                % calculate the label width
                % the user can override this later if
                % they specified a \labelwidth
                \settowidth{\labelwidth}{\csname labelitem\romannumeral\the\@itemdepth\endcsname}%
                \@SCIsavelistparams% save our list parameters
                \list{\csname\@itemitem\endcsname}{%
                \@SCIrestorelistparams% override any list{} changes
                                       % to our globals
                \let\makelabel\@SCIiedmakelabel% v1.6b setup \makelabel
                \iedlistdecl% let user alter parameters
                #1\relax%
                % If the user has requested not to use the
                % labelindent factor, don't revise \labelindent
                \ifnolabelindentfactor\relax%
                \else\labelindent=\labelindentfactor\labelindent%
                \fi%
                % Unless the user has requested otherwise,
                % calculate our left margin based
                % on \labelindent, \labelwidth and
                % \labelsep
                \ifnocalcleftmargin\relax%
                \else\calcleftmargin{\labelindent}%
                \fi}\fi\fi}%


% DO NOT ALLOW BLANK LINES TO BE IN THESE IED ENVIRONMENTS
% AS THIS WILL FORCE NEW PARAGRAPHS AFTER THE IED LISTS
% SCIndustria enumerate list MDS 1/2001
% Note controlled spacing here, shield end of lines with %
\def\@@SCIenumerate[#1]{%
                \ifnum\@enumdepth>3\relax\@toodeep\else%
                \ifnum\@listdepth>5\relax\@toodeep\else%
                \advance\@enumdepth\@ne%
                \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
                % get the labelindentfactor for this level
                \advance\@listdepth\@ne% we need to know what the level WILL be
                \edef\labelindentfactor{\csname SCIlabelindentfactor\romannumeral\the\@listdepth\endcsname}%
                \advance\@listdepth-\@ne% undo our increment
                \def\@iedjustify{2}% right justified labels are default
                % set other defaults
                \nocalcleftmarginfalse%
                \nolabelindentfactorfalse%
                \topsep\SCIiedtopsep%
                \labelindent\SCIelabelindent%
                \labelsep\SCIiednormlabelsep%
                \partopsep 0ex%
                \parsep 0ex%
                \itemsep 0ex%
                \rightmargin 0em%
                \listparindent 0em%
                \itemindent 0em%
                % calculate the label width
                % We'll set it to the width suitable for all labels using
                % normalfont 1) to 9)
                % The user can override this later
                \settowidth{\labelwidth}{9)}%
                \@SCIsavelistparams% save our list parameters
                \list{\csname label\@enumctr\endcsname}{\usecounter{\@enumctr}%
                \@SCIrestorelistparams% override any list{} changes
                                       % to our globals
                \let\makelabel\@SCIiedmakelabel% v1.6b setup \makelabel
                \iedlistdecl% let user alter parameters
                #1\relax%
                % If the user has requested not to use the
                % labelindent factor, don't revise \labelindent
                \ifnolabelindentfactor\relax%
                \else\labelindent=\labelindentfactor\labelindent%
                \fi%
                % Unless the user has requested otherwise,
                % calculate our left margin based
                % on \labelindent, \labelwidth and
                % \labelsep
                \ifnocalcleftmargin\relax%
                \else\calcleftmargin{\labelindent}%
                \fi}\fi\fi}%


% DO NOT ALLOW BLANK LINES TO BE IN THESE IED ENVIRONMENTS
% AS THIS WILL FORCE NEW PARAGRAPHS AFTER THE IED LISTS
% SCIndustria description list MDS 1/2001
% Note controlled spacing here, shield end of lines with %
\def\@@SCIdescription[#1]{%
                \ifnum\@listdepth>5\relax\@toodeep\else%
                % get the labelindentfactor for this level
                \advance\@listdepth\@ne% we need to know what the level WILL be
                \edef\labelindentfactor{\csname SCIlabelindentfactor\romannumeral\the\@listdepth\endcsname}%
                \advance\@listdepth-\@ne% undo our increment
                \def\@iedjustify{0}% left justified labels are default
                % set other defaults
                \nocalcleftmarginfalse%
                \nolabelindentfactorfalse%
                \topsep\SCIiedtopsep%
                \labelindent\SCIdlabelindent%
                % assume normal labelsep
                \labelsep\SCIiednormlabelsep%
                \partopsep 0ex%
                \parsep 0ex%
                \itemsep 0ex%
                \rightmargin 0em%
                \listparindent 0em%
                \itemindent 0em%
                % Bogus label width in case the user forgets
                % to set it.
                % TIP: If you want to see what a variable's width is you
                % can use the TeX command \showthe\width-variable to
                % display it on the screen during compilation
                % (This might be helpful to know when you need to find out
                % which label is the widest)
                \settowidth{\labelwidth}{Hello}%
                \@SCIsavelistparams% save our list parameters
                \list{}{\@SCIrestorelistparams% override any list{} changes
                                               % to our globals
                \let\makelabel\@SCIiedmakelabel% v1.6b setup \makelabel
                \iedlistdecl% let user alter parameters
                #1\relax%
                % If the user has requested not to use the
                % labelindent factor, don't revise \labelindent
                \ifnolabelindentfactor\relax%
                \else\labelindent=\labelindentfactor\labelindent%
                \fi%
                % Unless the user has requested otherwise,
                % calculate our left margin based
                % on \labelindent, \labelwidth and
                % \labelsep
                \ifnocalcleftmargin\relax%
                \else\calcleftmargin{\labelindent}\relax%
                \fi}\fi}

% v1.6b we use one makelabel that does justification as needed.
\def\@SCIiedmakelabel#1{\relax\if\@iedjustify 0\relax
\makebox[\labelwidth][l]{\normalfont #1}\else
\if\@iedjustify 1\relax
\makebox[\labelwidth][c]{\normalfont #1}\else
\makebox[\labelwidth][r]{\normalfont #1}\fi\fi}


% VERSE and QUOTE
\def\verse{\let\\=\@centercr
    \list{}{\itemsep\z@ \itemindent -1.5em \listparindent \itemindent
    \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist
\def\quotation{\list{}{\listparindent 1.5em \itemindent\listparindent
    \rightmargin\leftmargin \parsep 0pt plus 1pt}\item[]}
\let\endquotation=\endlist
\def\quote{\list{}{\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist


% standard values from article.cls
\arraycolsep     5pt
\arrayrulewidth .4pt
\doublerulesep   2pt

\tabcolsep       6pt
\tabbingsep      0.5em


%% FOOTNOTES
%
%\skip\footins 10pt plus 4pt minus 2pt
% V1.6 respond to changes in font size
% space added above the footnotes (if present)
\skip\footins 0.9\baselineskip  plus 0.4\baselineskip  minus 0.2\baselineskip

% V1.6, we need to make \footnotesep responsive to changes
% in \baselineskip or strange spacings will result when in
% draft mode. Here is a little LaTeX secret - \footnotesep
% determines the height of an invisible strut that is placed
% *above* the baseline of footnotes after the first. Since
% LaTeX considers the space for characters to be 0.7/baselineskip
% above the baseline and 0.3/baselineskip below it, we need to
% use 0.7/baselineskip as a \footnotesep to maintain equal spacing
% between all the lines of the footnotes. SCI often uses a tad
% more, so use 0.8\baselineskip. This slightly larger value also helps
% the text to clear the footnote marks. Note that \thanks now uses
% its own value of \footnotesep.
{\footnotesize
\global\footnotesep 0.8\baselineskip}


\skip\@mpfootins = \skip\footins
\fboxsep = 3pt
\fboxrule = .4pt
% V1.6 use 1em, the use LaTeX2e's \@makefnmark
% Note that SCI normally *left* aligns the footnote marks, so we don't need
% box resizing tricks here.
\long\def\@makefntext#1{\parindent 1em\indent\hbox{\@makefnmark}#1}% V1.6 use 1em

\def\footnoterule{}

% V1.6 do not allow LaTeX to break a footnote across multiple pages
\interfootnotelinepenalty=10000

% V1.6 discourage breaks within equations
% Note that amsmath normally sets this to 10000,
% but LaTeX2e normally uses 100.
\interdisplaylinepenalty=2500


\if@technote
   \setcounter{secnumdepth}{3}
\else
   \setcounter{secnumdepth}{4}
\fi


\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]

% used only by SCIndustria's SCIeqnarray as other packages may
% have their own, different, implementations
\newcounter{SCIsubequation}[equation]

% as shown when called by user from \ref, \label and in table of contents
\def\thesection{\Roman{section}}                             % I
\def\thesubsection{\thesection-\Alph{subsection}}            % I-A
\def\thesubsubsection{\thesubsection.\arabic{subsubsection}} % I-A.1
\def\theparagraph{\thesubsubsection.\alph{paragraph}}        % I-A.1.a
\def\theequation{\arabic{equation}}                          % 1
\def\theSCIsubequation{\theequation\alph{SCIsubequation}}  % 1a (used only by SCIndustria's SCIeqnarray)

% Main text forms (how shown in main text headings)
% V1.6, using \thesection in \thesectiondis allows changes
% in the former to automatically appear in the latter
\def\thesectiondis{\thesection.}                   % I.
\def\thesubsectiondis{\Alph{subsection}.}          % B.
\def\thesubsubsectiondis{\arabic{subsubsection})}  % 3)
\def\theparagraphdis{\alph{paragraph})}            % d)
% just like LaTeX2e's \@eqnnum
\def\theequationdis{{\normalfont \normalcolor (\theequation)}}% (1)
% SCIsubequation used only by SCIndustria's SCIeqnarray
\def\theSCIsubequationdis{{\normalfont \normalcolor (\theSCIsubequation)}}% (1a)
% redirect LaTeX2e's equation number display and all that depend on
% it, through SCIndustria's \theequationdis
\def\@eqnnum{\theequationdis}

% LIST OF FIGURES AND TABLES AND TABLE OF CONTENTS
%
\def\@pnumwidth{1.55em}
\def\@tocrmarg{2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{3}

% adjusted some spacings here so that section numbers will not easily
% collide with the section titles.
% VIII; VIII-A; and VIII-A.1 are usually the worst offenders.
% MDS 1/2001
\def\tableofcontents{\section*{Contents}\@starttoc{toc}}
\def\l@section#1#2{\addpenalty{\@secpenalty}\addvspace{1.0em plus 1pt}%
    \@tempdima 2.75em \begingroup \parindent \z@ \rightskip \@pnumwidth%
    \parfillskip-\@pnumwidth {\bfseries\leavevmode #1}\hfil\hbox to\@pnumwidth{\hss #2}\par%
    \endgroup}
% argument format #1:level, #2:labelindent,#3:labelsep
\def\l@subsection{\@dottedtocline{2}{2.75em}{3.75em}}
\def\l@subsubsection{\@dottedtocline{3}{6.5em}{4.5em}}
% must provide \l@ defs for ALL sublevels EVEN if tocdepth
% is such as they will not appear in the table of contents
% these defs are how TOC knows what level these things are!
\def\l@paragraph{\@dottedtocline{4}{6.5em}{5.5em}}
\def\l@subparagraph{\@dottedtocline{5}{6.5em}{6.5em}}
\def\listoffigures{\section*{List of Figures}\@starttoc{lof}}
\def\l@figure{\@dottedtocline{1}{0em}{2.75em}}
\def\listoftables{\section*{List of Tables}\@starttoc{lot}}
\let\l@table\l@figure


%% Definitions for floats
%%
%% Normal Floats
\floatsep 1\baselineskip plus  0.2\baselineskip minus  0.2\baselineskip
\textfloatsep 1.7\baselineskip plus  0.2\baselineskip minus  0.4\baselineskip
\@fptop 0pt plus 1fil
\@fpsep 0.75\baselineskip plus 2fil
\@fpbot 0pt plus 1fil
\def\topfraction{1.0}
\def\bottomfraction{.4}
\def\floatpagefraction{0.8}
\def\textfraction{.2}

%% Double Column Floats
\dblfloatsep 1\baselineskip plus  0.2\baselineskip minus  0.2\baselineskip

\dbltextfloatsep 1.7\baselineskip plus  0.2\baselineskip minus  0.4\baselineskip
% Note that it would be nice if the rubber here actually worked in LaTeX2e.
% There is a long standing limitation in LaTeX, first discovered (to the best
% of my knowledge) by Alan Jeffrey in 1992. LaTeX ignores the stretchable
% portion of \dbltextfloatsep, and as a result, double column figures can and
% do result in an non-integer number of lines in the main text columns with
% underfull vbox errors as a consequence. A post to comp.text.tex
% by Donald Arseneau confirms that this had not yet been fixed in 1998.
% SCIndustria V1.6 will fix this problem for you in the titles, but it doesn't
% protect you from other double floats. Happy vspace'ing.

\@dblfptop 0pt plus 1fil
\@dblfpsep 0.75\baselineskip plus 2fil
\@dblfpbot 0pt plus 1fil
\def\dbltopfraction{1.0}
\def\dblfloatpagefraction{0.8}
\setcounter{dbltopnumber}{4}

\intextsep 1\baselineskip plus 0.2\baselineskip minus  0.2\baselineskip
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}


%% redefine CAPTION
% V1.4 add user control for short figure caption justification
\newif\ifcenterfigcaptions

% V1.6 set the default according to conference mode
\if@confmode
\centerfigcaptionstrue
\else
\centerfigcaptionsfalse
\fi

% article class provides these, we should too.
\newlength\abovecaptionskip
\newlength\belowcaptionskip
% but only \abovecaptionskip is used above figure captions and *below* table
% captions
\setlength\abovecaptionskip{0.5\baselineskip}
\setlength\belowcaptionskip{0pt}
% V1.6 create hooks in case the caption spacing ever needs to be
% overridden by a user
\def\@SCIfigurecaptionsepspace{\vskip\abovecaptionskip\relax}%
\def\@SCItablecaptionsepspace{\vskip\abovecaptionskip\relax}%


% 1.6b revise caption system so that \@makecaption uses two arguments
% as with LaTeX2e. Otherwise, there will be problems when using hyperref.
\def\@SCItablestring{table}
\def\@SCItablestring{tabela}%SCIndustria

\long\def\@makecaption#1#2{%
% test if is a for a figure or table
\ifx\@captype\@SCItablestring%
% if a table, do table caption
\begin{center}{\footnotesize #1}\\{\footnotesize\scshape #2}\end{center}%
\@SCItablecaptionsepspace% V1.6 was a hard coded 8pt
% if not a table, format it as a figure
\else
\@SCIfigurecaptionsepspace% V1.6 was a hard coded 5pt
% 3/2001 use footnotesize, not small; use two nonbreaking spaces, not one
\setbox\@tempboxa\hbox{\footnotesize #1.~~ #2}%
\ifdim \wd\@tempboxa >\hsize%
% if caption is longer than a line, let it wrap around
\setbox\@tempboxa\hbox{\footnotesize #1.~~ }%
\parbox[t]{\hsize}{\footnotesize \noindent\unhbox\@tempboxa#2}%
% if caption is shorter than a line,
% allow user to control short figure caption justification (left or center)
\else%
\ifcenterfigcaptions \hbox to\hsize{\footnotesize\hfil\box\@tempboxa\hfil}%
\else \hbox to\hsize{\footnotesize\box\@tempboxa\hfil}%
\fi\fi\fi}


\newcounter{figure}
\def\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{Fig.~\thefigure}
\def\figure{\@float{figure}}
\def\endfigure{\end@float}
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}
\newcounter{table}
\def\thetable{\@Roman\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{TABLE~\thetable}

\newcounter{tabela}                 %SCIndustria
\def\thetabela{\@Roman\c@tabela}    %SCIndustria
\def\fps@tabela{tbp}                %SCIndustria
\def\ftype@tabela{2}                %SCIndustria
\def\ext@tabela{lot}                %SCIndustria
\def\fnum@tabela{TABELA~\thetabela} %SCIndustria

% V1.6 SCI uses 8pt text for tables
% to default to footnotesize, we hack into LaTeX2e's \@floatboxreset and pray
\def\table{\def\@floatboxreset{\reset@font\footnotesize\@setminipage}\@float{table}}
\def\endtable{\end@float}
% v1.6b double column tables need to default to footnotesize as well.
\@namedef{table*}{\def\@floatboxreset{\reset@font\footnotesize\@setminipage}\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}


\def\tabela{\def\@floatboxreset{\reset@font\footnotesize\@setminipage}\@float{tabela}}              %SCIndustria
\def\endtabela{\end@float}                                                                          %SCIndustria
\@namedef{tabela*}{\def\@floatboxreset{\reset@font\footnotesize\@setminipage}\@dblfloat{tabela}}    %SCIndustria
\@namedef{endtabela*}{\end@dblfloat}                                                                %SCIndustria



%%
%% START OF SCIeqnarry DEFINITIONS
%%
%% Inspired by the concepts, examples, and previous works of LaTeX
%% coders and developers such as Donald Arseneau, Fred Bartlett,
%% David Carlisle, Tony Liu, Frank Mittelbach, Piet van Oostrum,
%% Roland Winkler and Mark Wooding.
%% I don't make the claim that my work here is even near their calibre. ;)


% hook to allow easy changeover to SCIndustria.cls/tools.sty error reporting
\def\@SCIclspkgerror{\ClassError{SCIndustria}}

\newif\if@SCIeqnarraystarform% flag to indicate if the environment was called as the star form
\@SCIeqnarraystarformfalse

\newif\if@advanceSCIeqncolcnt% tracks if the environment should advance the col counter
% allows a way to make an \SCIeqnarraybox that can be used within an \SCIeqnarray
% used by SCIeqnarraymulticol so that it can work properly in both
\@advanceSCIeqncolcnttrue

\newcount\@SCIeqnnumcols % tracks how many SCIeqnarray cols are defined
\newcount\@SCIeqncolcnt  % tracks how many SCIeqnarray cols the user actually used


% The default math style used by the columns
\def\SCIeqnarraymathstyle{\displaystyle}
% The default text style used by the columns
% default to using the current font
\def\SCIeqnarraytextstyle{\relax}

% like the iedlistdecl but for \SCIeqnarray
\def\SCIeqnarraydecl{\relax}
\def\SCIeqnarrayboxdecl{\relax}

% \yesnumber is the opposite of \nonumber
% a novel concept with the same def as the equationarray package
% However, we give SCI versions too since some LaTeX packages such as
% the MDWtools mathenv.sty redefine \nonumber to something else.
\providecommand{\yesnumber}{\global\@eqnswtrue}
\def\SCIyesnumber{\global\@eqnswtrue}
\def\SCInonumber{\global\@eqnswfalse}


\def\SCIyessubnumber{\global\@SCIissubequationtrue\global\@eqnswtrue%
\if@SCIeqnarrayISinner% only do something inside an SCIeqnarray
\if@SCIlastlinewassubequation\addtocounter{equation}{-1}\else\setcounter{SCIsubequation}{1}\fi%
\def\@currentlabel{\p@SCIsubequation\theSCIsubequation}\fi}

% flag to indicate that an equation is a sub equation
\newif\if@SCIissubequation%
\@SCIissubequationfalse

% allows users to "push away" equations that get too close to the equation numbers
\def\SCIeqnarraynumspace{\hphantom{\if@SCIissubequation\theSCIsubequationdis\else\theequationdis\fi}}

% provides a way to span multiple columns within SCIeqnarray environments
% will consider \if@advanceSCIeqncolcnt before globally advancing the
% column counter - so as to work within \SCIeqnarraybox
% usage: \SCIeqnarraymulticol{number cols. to span}{col type}{cell text}
\long\def\SCIeqnarraymulticol#1#2#3{\multispan{#1}%
% check if column is defined
\relax\expandafter\ifx\csname @SCIeqnarraycolDEF#2\endcsname\@SCIeqnarraycolisdefined%
\csname @SCIeqnarraycolPRE#2\endcsname#3\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\csname @SCIeqnarraycolPOST#2\endcsname%
\else% if not, error and use default type
\@SCIclspkgerror{Invalid column type "#2" in \string\SCIeqnarraymulticol.\MessageBreak
Using a default centering column instead}%
{You must define SCIeqnarray column types before use.}%
\csname @SCIeqnarraycolPRE@SCIdefault\endcsname#3\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\csname @SCIeqnarraycolPOST@SCIdefault\endcsname%
\fi%
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by #1\relax\fi}

% like \omit, but maintains track of the column counter for \SCIeqnarray
\def\SCIeqnarrayomit{\omit\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by 1\relax\fi}


% provides a way to define a letter referenced column type
% usage: \SCIeqnarraydefcol{col. type letter/name}{pre insertion text}{post insertion text}
\def\SCIeqnarraydefcol#1#2#3{\expandafter\def\csname @SCIeqnarraycolPRE#1\endcsname{#2}%
\expandafter\def\csname @SCIeqnarraycolPOST#1\endcsname{#3}%
\expandafter\def\csname @SCIeqnarraycolDEF#1\endcsname{1}}


% provides a way to define a numerically referenced inter-column glue types
% usage: \SCIeqnarraydefcolsep{col. glue number}{glue definition}
\def\SCIeqnarraydefcolsep#1#2{\expandafter\def\csname @SCIeqnarraycolSEP\romannumeral #1\endcsname{#2}%
\expandafter\def\csname @SCIeqnarraycolSEPDEF\romannumeral #1\endcsname{1}}


\def\@SCIeqnarraycolisdefined{1}% just a macro for 1, used for checking undefined column types


% expands and appends the given argument to the \@SCIndustriatmptoksA token list
% used to build up the \halign preamble
\def\@SCIappendtoksA#1{\edef\@@SCIappendtoksA{\@SCIndustriatmptoksA={\the\@SCIndustriatmptoksA #1}}%
\@@SCIappendtoksA}

% also appends to \@SCIndustriatmptoksA, but does not expand the argument
% uses \toks8 as a scratchpad register
\def\@SCIappendNOEXPANDtoksA#1{\toks8={#1}%
\edef\@@SCIappendNOEXPANDtoksA{\@SCIndustriatmptoksA={\the\@SCIndustriatmptoksA\the\toks8}}%
\@@SCIappendNOEXPANDtoksA}

% define some common column types for the user
% math
\SCIeqnarraydefcol{l}{$\SCIeqnarraymathstyle}{$\hfil}
\SCIeqnarraydefcol{c}{\hfil$\SCIeqnarraymathstyle}{$\hfil}
\SCIeqnarraydefcol{r}{\hfil$\SCIeqnarraymathstyle}{$}
\SCIeqnarraydefcol{L}{$\SCIeqnarraymathstyle{}}{{}$\hfil}
\SCIeqnarraydefcol{C}{\hfil$\SCIeqnarraymathstyle{}}{{}$\hfil}
\SCIeqnarraydefcol{R}{\hfil$\SCIeqnarraymathstyle{}}{{}$}
% text
\SCIeqnarraydefcol{s}{\SCIeqnarraytextstyle}{\hfil}
\SCIeqnarraydefcol{t}{\hfil\SCIeqnarraytextstyle}{\hfil}
\SCIeqnarraydefcol{u}{\hfil\SCIeqnarraytextstyle}{}

% vertical rules
\SCIeqnarraydefcol{v}{}{\vrule width\arrayrulewidth}
\SCIeqnarraydefcol{vv}{\vrule width\arrayrulewidth\hfil}{\hfil\vrule width\arrayrulewidth}
\SCIeqnarraydefcol{V}{}{\vrule width\arrayrulewidth\hskip\doublerulesep\vrule width\arrayrulewidth}
\SCIeqnarraydefcol{VV}{\vrule width\arrayrulewidth\hskip\doublerulesep\vrule width\arrayrulewidth\hfil}%
{\hfil\vrule width\arrayrulewidth\hskip\doublerulesep\vrule width\arrayrulewidth}

% horizontal rules
\SCIeqnarraydefcol{h}{}{\leaders\hrule height\arrayrulewidth\hfil}
\SCIeqnarraydefcol{H}{}{\leaders\vbox{\hrule width\arrayrulewidth\vskip\doublerulesep\hrule width\arrayrulewidth}\hfil}

% plain
\SCIeqnarraydefcol{x}{}{}
\SCIeqnarraydefcol{X}{$}{$}

% the default column type to use in the event a column type is not defined
\SCIeqnarraydefcol{@SCIdefault}{\hfil$\SCIeqnarraymathstyle}{$\hfil}


% a zero tabskip (used for "-" col types)
\def\@SCIeqnarraycolSEPzero{0pt plus 0pt minus 0pt}
% a centering tabskip (used for "+" col types)
\def\@SCIeqnarraycolSEPcenter{1000pt plus 0pt minus 1000pt}

% top level default tabskip glues for the start, end, and inter-column
% may be reset within environments not always at the top level, e.g., \SCIeqnarraybox
\edef\@SCIeqnarraycolSEPdefaultstart{\@SCIeqnarraycolSEPcenter}% default start glue
\edef\@SCIeqnarraycolSEPdefaultend{\@SCIeqnarraycolSEPcenter}% default end glue
\edef\@SCIeqnarraycolSEPdefaultmid{\@SCIeqnarraycolSEPzero}% default inter-column glue



% creates a vertical rule that extends from the bottom to the top a a cell
% Provided in case other packages redefine \vline some other way.
% usage: \SCIeqnarrayvrule[rule thickness]
% If no argument is provided, \arrayrulewidth will be used for the rule thickness.
\newcommand\SCIeqnarrayvrule[1][\arrayrulewidth]{\vrule\@width#1\relax}

% creates a blank separator row
% usage: \SCIeqnarrayseprow[separation length][font size commands]
% default is \SCIeqnarrayseprow[0.25\normalbaselineskip][\relax]
% blank arguments inherit the default values
% uses \skip5 as a scratch register - calls \@SCIeqnarraystrutsize which uses more scratch registers
\def\SCIeqnarrayseprow{\relax\@ifnextchar[{\@SCIeqnarrayseprow}{\@SCIeqnarrayseprow[0.25\normalbaselineskip]}}
\def\@SCIeqnarrayseprow[#1]{\relax\@ifnextchar[{\@@SCIeqnarrayseprow[#1]}{\@@SCIeqnarrayseprow[#1][\relax]}}
\def\@@SCIeqnarrayseprow[#1][#2]{\def\@SCIeqnarrayseprowARGONE{#1}%
\ifx\@SCIeqnarrayseprowARGONE\@empty%
% get the skip value, based on the font commands
% use skip5 because \SCIeqnarraystrutsize uses \skip0, \skip2, \skip3
% assign within a bogus box to confine the font changes
{\setbox0=\hbox{#2\relax\global\skip5=0.25\normalbaselineskip}}%
\else%
{\setbox0=\hbox{#2\relax\global\skip5=#1}}%
\fi%
\@SCIeqnarrayhoptolastcolumn\SCIeqnarraystrutsize{\skip5}{0pt}[\relax]\relax}

% creates a blank separator row, but omits all the column templates
% usage: \SCIeqnarrayseprowcut[separation length][font size commands]
% default is \SCIeqnarrayseprowcut[0.25\normalbaselineskip][\relax]
% blank arguments inherit the default values
% uses \skip5 as a scratch register - calls \@SCIeqnarraystrutsize which uses more scratch registers
\def\SCIeqnarrayseprowcut{\multispan{\@SCIeqnnumcols}\relax% span all the cols
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by \@SCIeqnnumcols\relax\fi%
\@ifnextchar[{\@SCIeqnarrayseprowcut}{\@SCIeqnarrayseprowcut[0.25\normalbaselineskip]}}
\def\@SCIeqnarrayseprowcut[#1]{\relax\@ifnextchar[{\@@SCIeqnarrayseprowcut[#1]}{\@@SCIeqnarrayseprowcut[#1][\relax]}}
\def\@@SCIeqnarrayseprowcut[#1][#2]{\def\@SCIeqnarrayseprowARGONE{#1}%
\ifx\@SCIeqnarrayseprowARGONE\@empty%
% get the skip value, based on the font commands
% use skip5 because \SCIeqnarraystrutsize uses \skip0, \skip2, \skip3
% assign within a bogus box to confine the font changes
{\setbox0=\hbox{#2\relax\global\skip5=0.25\normalbaselineskip}}%
\else%
{\setbox0=\hbox{#2\relax\global\skip5=#1}}%
\fi%
\SCIeqnarraystrutsize{\skip5}{0pt}[\relax]\relax}



% draws a single rule across all the columns optional
% argument determines the rule width, \arrayrulewidth is the default
% updates column counter as needed and turns off struts
% usage: \SCIeqnarrayrulerow[rule line thickness]
\def\SCIeqnarrayrulerow{\multispan{\@SCIeqnnumcols}\relax% span all the cols
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by \@SCIeqnnumcols\relax\fi%
\@ifnextchar[{\@SCIeqnarrayrulerow}{\@SCIeqnarrayrulerow[\arrayrulewidth]}}
\def\@SCIeqnarrayrulerow[#1]{\leaders\hrule height#1\hfil\relax% put in our rule
% turn off any struts
\SCIeqnarraystrutsize{0pt}{0pt}[\relax]\relax}


% draws a double rule by using a single rule row, a separator row, and then
% another single rule row
% first optional argument determines the rule thicknesses, \arrayrulewidth is the default
% second optional argument determines the rule spacing, \doublerulesep is the default
% usage: \SCIeqnarraydblrulerow[rule line thickness][rule spacing]
\def\SCIeqnarraydblrulerow{\multispan{\@SCIeqnnumcols}\relax% span all the cols
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by \@SCIeqnnumcols\relax\fi%
\@ifnextchar[{\@SCIeqnarraydblrulerow}{\@SCIeqnarraydblrulerow[\arrayrulewidth]}}
\def\@SCIeqnarraydblrulerow[#1]{\relax\@ifnextchar[{\@@SCIeqnarraydblrulerow[#1]}%
{\@@SCIeqnarraydblrulerow[#1][\doublerulesep]}}
\def\@@SCIeqnarraydblrulerow[#1][#2]{\def\@SCIeqnarraydblrulerowARG{#1}%
% we allow the user to say \SCIeqnarraydblrulerow[][]
\ifx\@SCIeqnarraydblrulerowARG\@empty%
\@SCIeqnarrayrulerow[\arrayrulewidth]%
\else%
\@SCIeqnarrayrulerow[#1]\relax%
\fi%
\def\@SCIeqnarraydblrulerowARG{#2}%
\ifx\@SCIeqnarraydblrulerowARG\@empty%
\\\SCIeqnarrayseprow[\doublerulesep][\relax]%
\else%
\\\SCIeqnarrayseprow[#2][\relax]%
\fi%
\\\multispan{\@SCIeqnnumcols}%
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by \@SCIeqnnumcols\relax\fi%
\def\@SCIeqnarraydblrulerowARG{#1}%
\ifx\@SCIeqnarraydblrulerowARG\@empty%
\@SCIeqnarrayrulerow[\arrayrulewidth]%
\else%
\@SCIeqnarrayrulerow[#1]%
\fi%
}

% draws a double rule by using a single rule row, a separator (cutting) row, and then
% another single rule row
% first optional argument determines the rule thicknesses, \arrayrulewidth is the default
% second optional argument determines the rule spacing, \doublerulesep is the default
% usage: \SCIeqnarraydblrulerow[rule line thickness][rule spacing]
\def\SCIeqnarraydblrulerowcut{\multispan{\@SCIeqnnumcols}\relax% span all the cols
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by \@SCIeqnnumcols\relax\fi%
\@ifnextchar[{\@SCIeqnarraydblrulerowcut}{\@SCIeqnarraydblrulerowcut[\arrayrulewidth]}}
\def\@SCIeqnarraydblrulerowcut[#1]{\relax\@ifnextchar[{\@@SCIeqnarraydblrulerowcut[#1]}%
{\@@SCIeqnarraydblrulerowcut[#1][\doublerulesep]}}
\def\@@SCIeqnarraydblrulerowcut[#1][#2]{\def\@SCIeqnarraydblrulerowARG{#1}%
% we allow the user to say \SCIeqnarraydblrulerow[][]
\ifx\@SCIeqnarraydblrulerowARG\@empty%
\@SCIeqnarrayrulerow[\arrayrulewidth]%
\else%
\@SCIeqnarrayrulerow[#1]%
\fi%
\def\@SCIeqnarraydblrulerowARG{#2}%
\ifx\@SCIeqnarraydblrulerowARG\@empty%
\\\SCIeqnarrayseprowcut[\doublerulesep][\relax]%
\else%
\\\SCIeqnarrayseprowcut[#2][\relax]%
\fi%
\\\multispan{\@SCIeqnnumcols}%
% advance column counter only if the SCIeqnarray environment wants it
\if@advanceSCIeqncolcnt\global\advance\@SCIeqncolcnt by \@SCIeqnnumcols\relax\fi%
\def\@SCIeqnarraydblrulerowARG{#1}%
\ifx\@SCIeqnarraydblrulerowARG\@empty%
\@SCIeqnarrayrulerow[\arrayrulewidth]%
\else%
\@SCIeqnarrayrulerow[#1]%
\fi%
}



% inserts a full row's worth of &'s
% relies on \@SCIeqnnumcols to provide the correct number of columns
% uses \@SCIndustriatmptoksA, \count0 as scratch registers
\def\@SCIeqnarrayhoptolastcolumn{\@SCIndustriatmptoksA={}\count0=1\relax%
\loop% add cols if the user did not use them all
\ifnum\count0<\@SCIeqnnumcols\relax%
\@SCIappendtoksA{&}%
\advance\count0 by 1\relax% update the col count
\repeat%
\the\@SCIndustriatmptoksA%execute the &'s
}



\newif\if@SCIeqnarrayISinner % flag to indicate if we are within the lines
\@SCIeqnarrayISinnerfalse    % of an SCIeqnarray - after the SCIeqnarraydecl

\edef\@SCIeqnarrayTHEstrutheight{0pt} % height and depth of SCIeqnarray struts
\edef\@SCIeqnarrayTHEstrutdepth{0pt}

\edef\@SCIeqnarrayTHEmasterstrutheight{0pt} % default height and depth of
\edef\@SCIeqnarrayTHEmasterstrutdepth{0pt}  % struts within an SCIeqnarray

\edef\@SCIeqnarrayTHEmasterstrutHSAVE{0pt} % saved master strut height
\edef\@SCIeqnarrayTHEmasterstrutDSAVE{0pt} % and depth

\newif\if@SCIeqnarrayusemasterstrut % flag to indicate that the master strut value
\@SCIeqnarrayusemasterstruttrue     % is to be used



% saves the strut height and depth of the master strut
\def\@SCIeqnarraymasterstrutsave{\relax%
\expandafter\skip0=\@SCIeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@SCIeqnarrayTHEmasterstrutdepth\relax%
% remove stretchability
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% save values
\edef\@SCIeqnarrayTHEmasterstrutHSAVE{\the\dimen0}%
\edef\@SCIeqnarrayTHEmasterstrutDSAVE{\the\dimen2}}

% restores the strut height and depth of the master strut
\def\@SCIeqnarraymasterstrutrestore{\relax%
\expandafter\skip0=\@SCIeqnarrayTHEmasterstrutHSAVE\relax%
\expandafter\skip2=\@SCIeqnarrayTHEmasterstrutDSAVE\relax%
% remove stretchability
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% restore values
\edef\@SCIeqnarrayTHEmasterstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEmasterstrutdepth{\the\dimen2}}


% globally restores the strut height and depth to the
% master values and sets the master strut flag to true
\def\@SCIeqnarraystrutreset{\relax%
\expandafter\skip0=\@SCIeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@SCIeqnarrayTHEmasterstrutdepth\relax%
% remove stretchability
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% restore values
\xdef\@SCIeqnarrayTHEstrutheight{\the\dimen0}%
\xdef\@SCIeqnarrayTHEstrutdepth{\the\dimen2}%
\global\@SCIeqnarrayusemasterstruttrue}


% if the master strut is not to be used, make the current
% values of \@SCIeqnarrayTHEstrutheight, \@SCIeqnarrayTHEstrutdepth
% and the use master strut flag, global
% this allows user strut commands issued in the last column to be carried
% into the isolation/strut column
\def\@SCIeqnarrayglobalizestrutstatus{\relax%
\if@SCIeqnarrayusemasterstrut\else%
\xdef\@SCIeqnarrayTHEstrutheight{\@SCIeqnarrayTHEstrutheight}%
\xdef\@SCIeqnarrayTHEstrutdepth{\@SCIeqnarrayTHEstrutdepth}%
\global\@SCIeqnarrayusemasterstrutfalse%
\fi}



% usage: \SCIeqnarraystrutsize{height}{depth}[font size commands]
% If called outside the lines of an SCIeqnarray, sets the height
% and depth of both the master and local struts. If called inside
% an SCIeqnarray line, sets the height and depth of the local strut
% only and sets the flag to indicate the use of the local strut
% values. If the height or depth is left blank, 0.7\normalbaselineskip
% and 0.3\normalbaselineskip will be used, respectively.
% The optional argument can be used to evaluate the lengths under
% a different font size and styles. If none is specified, the current
% font is used.
% uses scratch registers \skip0, \skip2, \skip3, \dimen0, \dimen2
\def\SCIeqnarraystrutsize#1#2{\relax\@ifnextchar[{\@SCIeqnarraystrutsize{#1}{#2}}{\@SCIeqnarraystrutsize{#1}{#2}[\relax]}}
\def\@SCIeqnarraystrutsize#1#2[#3]{\def\@SCIeqnarraystrutsizeARG{#1}%
\ifx\@SCIeqnarraystrutsizeARG\@empty%
{\setbox0=\hbox{#3\relax\global\skip3=0.7\normalbaselineskip}}%
\skip0=\skip3\relax%
\else% arg one present
{\setbox0=\hbox{#3\relax\global\skip3=#1\relax}}%
\skip0=\skip3\relax%
\fi% if null arg
\def\@SCIeqnarraystrutsizeARG{#2}%
\ifx\@SCIeqnarraystrutsizeARG\@empty%
{\setbox0=\hbox{#3\relax\global\skip3=0.3\normalbaselineskip}}%
\skip2=\skip3\relax%
\else% arg two present
{\setbox0=\hbox{#3\relax\global\skip3=#2\relax}}%
\skip2=\skip3\relax%
\fi% if null arg
% remove stretchability, just to be safe
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% dimen0 = height, dimen2 = depth
\if@SCIeqnarrayISinner% inner does not touch master strut size
\edef\@SCIeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEstrutdepth{\the\dimen2}%
\@SCIeqnarrayusemasterstrutfalse% do not use master
\else% outer, have to set master strut too
\edef\@SCIeqnarrayTHEmasterstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEmasterstrutdepth{\the\dimen2}%
\edef\@SCIeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEstrutdepth{\the\dimen2}%
\@SCIeqnarrayusemasterstruttrue% use master strut
\fi}


% usage: \SCIeqnarraystrutsizeadd{added height}{added depth}[font size commands]
% If called outside the lines of an SCIeqnarray, adds the given height
% and depth to both the master and local struts.
% If called inside an SCIeqnarray line, adds the given height and depth
% to the local strut only and sets the flag to indicate the use
% of the local strut values.
% In both cases, if a height or depth is left blank, 0pt is used instead.
% The optional argument can be used to evaluate the lengths under
% a different font size and styles. If none is specified, the current
% font is used.
% uses scratch registers \skip0, \skip2, \skip3, \dimen0, \dimen2
\def\SCIeqnarraystrutsizeadd#1#2{\relax\@ifnextchar[{\@SCIeqnarraystrutsizeadd{#1}{#2}}{\@SCIeqnarraystrutsizeadd{#1}{#2}[\relax]}}
\def\@SCIeqnarraystrutsizeadd#1#2[#3]{\def\@SCIeqnarraystrutsizearg{#1}%
\ifx\@SCIeqnarraystrutsizearg\@empty%
\skip0=0pt\relax%
\else% arg one present
{\setbox0=\hbox{#3\relax\global\skip3=#1}}%
\skip0=\skip3\relax%
\fi% if null arg
\def\@SCIeqnarraystrutsizearg{#2}%
\ifx\@SCIeqnarraystrutsizearg\@empty%
\skip2=0pt\relax%
\else% arg two present
{\setbox0=\hbox{#3\relax\global\skip3=#2}}%
\skip2=\skip3\relax%
\fi% if null arg
% remove stretchability, just to be safe
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% dimen0 = height, dimen2 = depth
\if@SCIeqnarrayISinner% inner does not touch master strut size
% get local strut size
\expandafter\skip0=\@SCIeqnarrayTHEstrutheight\relax%
\expandafter\skip2=\@SCIeqnarrayTHEstrutdepth\relax%
% add it to the user supplied values
\advance\dimen0 by \skip0\relax%
\advance\dimen2 by \skip2\relax%
% update the local strut size
\edef\@SCIeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEstrutdepth{\the\dimen2}%
\@SCIeqnarrayusemasterstrutfalse% do not use master
\else% outer, have to set master strut too
% get master strut size
\expandafter\skip0=\@SCIeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@SCIeqnarrayTHEmasterstrutdepth\relax%
% add it to the user supplied values
\advance\dimen0 by \skip0\relax%
\advance\dimen2 by \skip2\relax%
% update the local and master strut sizes
\edef\@SCIeqnarrayTHEmasterstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEmasterstrutdepth{\the\dimen2}%
\edef\@SCIeqnarrayTHEstrutheight{\the\dimen0}%
\edef\@SCIeqnarrayTHEstrutdepth{\the\dimen2}%
\@SCIeqnarrayusemasterstruttrue% use master strut
\fi}


% allow user a way to see the struts
\newif\ifSCIvisiblestruts
\SCIvisiblestrutsfalse

% inserts an invisible strut using the master or local strut values
% uses scratch registers \skip0, \skip2, \dimen0, \dimen2
\def\@SCIeqnarrayinsertstrut{\relax%
\if@SCIeqnarrayusemasterstrut
% get master strut size
\expandafter\skip0=\@SCIeqnarrayTHEmasterstrutheight\relax%
\expandafter\skip2=\@SCIeqnarrayTHEmasterstrutdepth\relax%
\else%
% get local strut size
\expandafter\skip0=\@SCIeqnarrayTHEstrutheight\relax%
\expandafter\skip2=\@SCIeqnarrayTHEstrutdepth\relax%
\fi%
% remove stretchability, probably not needed
\dimen0\skip0\relax%
\dimen2\skip2\relax%
% dimen0 = height, dimen2 = depth
% allow user to see struts if desired
\ifSCIvisiblestruts%
\vrule width0.2pt height\dimen0 depth\dimen2\relax%
\else%
\vrule width0pt height\dimen0 depth\dimen2\relax\fi}


% creates an invisible strut, useable even outside \SCIeqnarray
% if \SCIvisiblestrutstrue, the strut will be visible and 0.2pt wide.
% usage: \SCIstrut[height][depth][font size commands]
% default is \SCIstrut[0.7\normalbaselineskip][0.3\normalbaselineskip][\relax]
% blank arguments inherit the default values
% uses \dimen0, \dimen2, \skip0, \skip2
\def\SCIstrut{\relax\@ifnextchar[{\@SCIstrut}{\@SCIstrut[0.7\normalbaselineskip]}}
\def\@SCIstrut[#1]{\relax\@ifnextchar[{\@@SCIstrut[#1]}{\@@SCIstrut[#1][0.3\normalbaselineskip]}}
\def\@@SCIstrut[#1][#2]{\relax\@ifnextchar[{\@@@SCIstrut[#1][#2]}{\@@@SCIstrut[#1][#2][\relax]}}
\def\@@@SCIstrut[#1][#2][#3]{\mbox{#3\relax%
\def\@SCIstrutARG{#1}%
\ifx\@SCIstrutARG\@empty%
\skip0=0.7\normalbaselineskip\relax%
\else%
\skip0=#1\relax%
\fi%
\def\@SCIstrutARG{#2}%
\ifx\@SCIstrutARG\@empty%
\skip2=0.3\normalbaselineskip\relax%
\else%
\skip2=#2\relax%
\fi%
% remove stretchability, probably not needed
\dimen0\skip0\relax%
\dimen2\skip2\relax%
\ifSCIvisiblestruts%
\vrule width0.2pt height\dimen0 depth\dimen2\relax%
\else%
\vrule width0.0pt height\dimen0 depth\dimen2\relax\fi}}


% enables strut mode by setting a default strut size and then zeroing the
% \baselineskip, \lineskip, \lineskiplimit and \jot
\def\SCIeqnarraystrutmode{\SCIeqnarraystrutsize{0.7\normalbaselineskip}{0.3\normalbaselineskip}[\relax]%
\baselineskip=0pt\lineskip=0pt\lineskiplimit=0pt\jot=0pt}



\def\SCIeqnarray{\@SCIeqnarraystarformfalse\@SCIeqnarray}
\def\endSCIeqnarray{\end@SCIeqnarray}

\@namedef{SCIeqnarray*}{\@SCIeqnarraystarformtrue\@SCIeqnarray}
\@namedef{endSCIeqnarray*}{\end@SCIeqnarray}


% \SCIeqnarray is an enhanced \eqnarray.
% The star form defaults to not putting equation numbers at the end of each row.
% usage: \SCIeqnarray[decl]{cols}
\def\@SCIeqnarray{\relax\@ifnextchar[{\@@SCIeqnarray}{\@@SCIeqnarray[\relax]}}
\def\@@SCIeqnarray[#1]#2{%
   % default to showing the equation number or not based on whether or not
   % the star form was involked
   \if@SCIeqnarraystarform\global\@eqnswfalse
   \else% not the star form
   \global\@eqnswtrue
   \fi% if star form
   \@SCIissubequationfalse% default to no subequations
   \@SCIlastlinewassubequationfalse% assume last line is not a sub equation
   \@SCIeqnarrayISinnerfalse% not yet within the lines of the halign
   \@SCIeqnarraystrutsize{0pt}{0pt}[\relax]% turn off struts by default
   \@SCIeqnarrayusemasterstruttrue% use master strut till user asks otherwise
   \SCIvisiblestrutsfalse% diagnostic mode defaults to off
   % no extra space unless the user specifically requests it
   \lineskip=0pt\relax
   \lineskiplimit=0pt\relax
   \baselineskip=\normalbaselineskip\relax%
   \jot=\normaljot\relax%
   \mathsurround\z@\relax% no extra spacing around math
   \@advanceSCIeqncolcnttrue% advance the col counter for each col the user uses,
                             % used in \SCIeqnarraymulticol and in the preamble build
   \stepcounter{equation}% advance equation counter before first line
   \setcounter{SCIsubequation}{0}% no subequation yet
   \def\@currentlabel{\p@equation\theequation}% redefine the ref label
   \SCIeqnarraydecl\relax% allow a way for the user to make global overrides
   #1\relax% allow user to override defaults
   \let\\\@SCIeqnarraycr% replace newline with one that can put in eqn. numbers
   \global\@SCIeqncolcnt\z@% col. count = 0 for first line
   \@SCIbuildpreamble #2\end\relax% build the preamble and put it into \@SCIndustriatmptoksA
   % put in the column for the equation number
   \ifnum\@SCIeqnnumcols>0\relax\@SCIappendtoksA{&}\fi% col separator for those after the first
   \toks0={##}%
   % advance the \@SCIeqncolcnt for the isolation col, this helps with error checking
   \@SCIappendtoksA{\global\advance\@SCIeqncolcnt by 1\relax}%
   % add the isolation column
   \@SCIappendtoksA{\tabskip\z@skip\bgroup\the\toks0\egroup}%
   % advance the \@SCIeqncolcnt for the equation number col, this helps with error checking
   \@SCIappendtoksA{&\global\advance\@SCIeqncolcnt by 1\relax}%
   % add the equation number col to the preamble
   \@SCIappendtoksA{\tabskip\z@skip\hb@xt@\z@\bgroup\hss\the\toks0\egroup}%
   % note \@SCIeqnnumcols does not count the equation col or isolation col
   % set the starting tabskip glue as determined by the preamble build
   \tabskip=\@SCIBPstartglue\relax
   % begin the display alignment
   \@SCIeqnarrayISinnertrue% commands are now within the lines
   $$\everycr{}\halign to\displaywidth\bgroup
   % "exspand" the preamble
   \span\the\@SCIndustriatmptoksA\cr}

% enter isolation/strut column (or the next column if the user did not use
% every column), record the strut status, complete the columns, do the strut if needed,
% restore counters to correct values and exit
\def\end@SCIeqnarray{\@SCIeqnarrayglobalizestrutstatus&\@@SCIeqnarraycr\egroup%
\if@SCIlastlinewassubequation\global\advance\c@SCIsubequation\m@ne\fi%
\global\advance\c@equation\m@ne%
$$\@ignoretrue}

% need a way to remember if last line is a subequation
\newif\if@SCIlastlinewassubequation%
\@SCIlastlinewassubequationfalse

% SCIeqnarray uses a modifed \\ instead of the plain \cr to
% end rows. This allows for things like \\*[vskip amount]
% This "cr" macros are modified versions those for LaTeX2e's eqnarray
% the {\ifnum0=`} braces must be kept away from the last column to avoid
% altering spacing of its math, so we use & to advance to the next column
% as there is an isolation/strut column after the user's columns
\def\@SCIeqnarraycr{\@SCIeqnarrayglobalizestrutstatus&% save strut status and advance to next column
   {\ifnum0=`}\fi
   \@ifstar{%
      \global\@eqpen\@M\@SCIeqnarrayYCR
   }{%
      \global\@eqpen\interdisplaylinepenalty \@SCIeqnarrayYCR
   }%
}

\def\@SCIeqnarrayYCR{\@testopt\@SCIeqnarrayXCR\z@skip}

\def\@SCIeqnarrayXCR[#1]{%
   \ifnum0=`{\fi}%
   \@@SCIeqnarraycr
   \noalign{\penalty\@eqpen\vskip\jot\vskip #1\relax}}%

\def\@@SCIeqnarraycr{\@SCIndustriatmptoksA={}% clear token register
    \advance\@SCIeqncolcnt by -1\relax% adjust col count because of the isolation column
    \ifnum\@SCIeqncolcnt>\@SCIeqnnumcols\relax
    \@SCIclspkgerror{Too many columns within the SCIeqnarray\MessageBreak
                          environment}%
    {Use fewer \string &'s or put more columns in the SCIeqnarry column\MessageBreak
     specifications.}\relax%
    \else
    \loop% add cols if the user did not use them all
    \ifnum\@SCIeqncolcnt<\@SCIeqnnumcols\relax
    \@SCIappendtoksA{&}%
    \advance\@SCIeqncolcnt by 1\relax% update the col count
    \repeat
    % this number of &'s will take us the the isolation column
    \fi
    % execute the &'s
    \the\@SCIndustriatmptoksA%
    % handle the strut/isolation column
    \@SCIeqnarrayinsertstrut% do the strut if needed
    \@SCIeqnarraystrutreset% reset the strut system for next line or SCIeqnarray
    &% and enter the equation number column
    % is this line needs an equation number, display it and advance the
    % (sub)equation counters, record what type this line was
    \if@eqnsw%
     \if@SCIissubequation\theSCIsubequationdis\addtocounter{equation}{1}\stepcounter{SCIsubequation}%
     \global\@SCIlastlinewassubequationtrue%
     \else% display a standard equation number, initialize the SCIsubequation counter
     \theequationdis\stepcounter{equation}\setcounter{SCIsubequation}{0}%
     \global\@SCIlastlinewassubequationfalse\fi%
    \fi%
    % reset the eqnsw flag to indicate default preference of the display of equation numbers
    \if@SCIeqnarraystarform\global\@eqnswfalse\else\global\@eqnswtrue\fi
    \global\@SCIissubequationfalse% reset the subequation flag
    % reset the number of columns the user actually used
    \global\@SCIeqncolcnt\z@\relax
    % the real end of the line
    \cr}





% \SCIeqnarraybox is like \SCIeqnarray except the box form puts everything
% inside a vtop, vbox, or vcenter box depending on the letter in the second
% optional argument (t,b,c). Vbox is the default. Unlike \SCIeqnarray,
% equation numbers are not displayed and \SCIeqnarraybox can be nested.
% \SCIeqnarrayboxm is for math mode (like \array) and does not put the vbox
% within an hbox.
% \SCIeqnarrayboxt is for text mode (like \tabular) and puts the vbox within
% a \hbox{$ $} construct.
% \SCIeqnarraybox will auto detect whether to use \SCIeqnarrayboxm or
% \SCIeqnarrayboxt depending on the math mode.
% The third optional argument specifies the width this box is to be set to -
% natural width is the default.
% The * forms do not add \jot line spacing
% usage: \SCIeqnarraybox[decl][pos][width]{cols}
\def\SCIeqnarrayboxm{\@SCIeqnarraystarformfalse\@SCIeqnarrayboxHBOXSWfalse\@SCIeqnarraybox}
\def\endSCIeqnarrayboxm{\end@SCIeqnarraybox}
\@namedef{SCIeqnarrayboxm*}{\@SCIeqnarraystarformtrue\@SCIeqnarrayboxHBOXSWfalse\@SCIeqnarraybox}
\@namedef{endSCIeqnarrayboxm*}{\end@SCIeqnarraybox}

\def\SCIeqnarrayboxt{\@SCIeqnarraystarformfalse\@SCIeqnarrayboxHBOXSWtrue\@SCIeqnarraybox}
\def\endSCIeqnarrayboxt{\end@SCIeqnarraybox}
\@namedef{SCIeqnarrayboxt*}{\@SCIeqnarraystarformtrue\@SCIeqnarrayboxHBOXSWtrue\@SCIeqnarraybox}
\@namedef{endSCIeqnarrayboxt*}{\end@SCIeqnarraybox}

\def\SCIeqnarraybox{\@SCIeqnarraystarformfalse\ifmmode\@SCIeqnarrayboxHBOXSWfalse\else\@SCIeqnarrayboxHBOXSWtrue\fi%
\@SCIeqnarraybox}
\def\endSCIeqnarraybox{\end@SCIeqnarraybox}

\@namedef{SCIeqnarraybox*}{\@SCIeqnarraystarformtrue\ifmmode\@SCIeqnarrayboxHBOXSWfalse\else\@SCIeqnarrayboxHBOXSWtrue\fi%
\@SCIeqnarraybox}
\@namedef{endSCIeqnarraybox*}{\end@SCIeqnarraybox}

% flag to indicate if the \SCIeqnarraybox needs to put things into an hbox{$ $}
% for \vcenter in non-math mode
\newif\if@SCIeqnarrayboxHBOXSW%
\@SCIeqnarrayboxHBOXSWfalse

\def\@SCIeqnarraybox{\relax\@ifnextchar[{\@@SCIeqnarraybox}{\@@SCIeqnarraybox[\relax]}}
\def\@@SCIeqnarraybox[#1]{\relax\@ifnextchar[{\@@@SCIeqnarraybox[#1]}{\@@@SCIeqnarraybox[#1][b]}}
\def\@@@SCIeqnarraybox[#1][#2]{\relax\@ifnextchar[{\@@@@SCIeqnarraybox[#1][#2]}{\@@@@SCIeqnarraybox[#1][#2][\relax]}}

% #1 = decl; #2 = t,b,c; #3 = width, #4 = col specs
\def\@@@@SCIeqnarraybox[#1][#2][#3]#4{\@SCIeqnarrayISinnerfalse % not yet within the lines of the halign
   \@SCIeqnarraymasterstrutsave% save current master strut values
   \@SCIeqnarraystrutsize{0pt}{0pt}[\relax]% turn off struts by default
   \@SCIeqnarrayusemasterstruttrue% use master strut till user asks otherwise
   \SCIvisiblestrutsfalse% diagnostic mode defaults to off
   % no extra space unless the user specifically requests it
   \lineskip=0pt\relax%
   \lineskiplimit=0pt\relax%
   \baselineskip=\normalbaselineskip\relax%
   \jot=\normaljot\relax%
   \mathsurround\z@\relax% no extra spacing around math
   % the default end glues are zero for an \SCIeqnarraybox
   \edef\@SCIeqnarraycolSEPdefaultstart{\@SCIeqnarraycolSEPzero}% default start glue
   \edef\@SCIeqnarraycolSEPdefaultend{\@SCIeqnarraycolSEPzero}% default end glue
   \edef\@SCIeqnarraycolSEPdefaultmid{\@SCIeqnarraycolSEPzero}% default inter-column glue
   \@advanceSCIeqncolcntfalse% do not advance the col counter for each col the user uses,
                              % used in \SCIeqnarraymulticol and in the preamble build
   \SCIeqnarrayboxdecl\relax% allow a way for the user to make global overrides
   #1\relax% allow user to override defaults
   \let\\\@SCIeqnarrayboxcr% replace newline with one that allows optional spacing
   \@SCIbuildpreamble #4\end\relax% build the preamble and put it into \@SCIndustriatmptoksA
   % add an isolation column to the preamble to stop \\'s {} from getting into the last col
   \ifnum\@SCIeqnnumcols>0\relax\@SCIappendtoksA{&}\fi% col separator for those after the first
   \toks0={##}%
   % add the isolation column to the preamble
   \@SCIappendtoksA{\tabskip\z@skip\bgroup\the\toks0\egroup}%
   % set the starting tabskip glue as determined by the preamble build
   \tabskip=\@SCIBPstartglue\relax
   % begin the alignment
   \everycr{}%
   % use only the very first token to determine the positioning
   % this stops some problems when the user uses more than one letter,
   % but is probably not worth the effort
   % \noindent is used as a delimiter
   \def\@SCIgrabfirstoken##1##2\noindent{\let\@SCIgrabbedfirstoken=##1}%
   \@SCIgrabfirstoken#2\relax\relax\noindent
   % \@SCIgrabbedfirstoken has the first token, the rest are discarded
   % if we need to put things into and hbox and go into math mode, do so now
   \if@SCIeqnarrayboxHBOXSW \leavevmode \hbox \bgroup $\fi%
   % use the appropriate vbox type
   \if\@SCIgrabbedfirstoken t\relax\vtop\else\if\@SCIgrabbedfirstoken c\relax%
   \vcenter\else\vbox\fi\fi\bgroup%
   \@SCIeqnarrayISinnertrue% commands are now within the lines
   \ifx#3\relax\halign\else\halign to #3\relax\fi%
   \bgroup
   % "exspand" the preamble
   \span\the\@SCIndustriatmptoksA\cr}

% carry strut status and enter the isolation/strut column,
% exit from math mode if needed, and exit
\def\end@SCIeqnarraybox{\@SCIeqnarrayglobalizestrutstatus% carry strut status
&% enter isolation/strut column
\@SCIeqnarrayinsertstrut% do strut if needed
\@SCIeqnarraymasterstrutrestore% restore the previous master strut values
% reset the strut system for next SCIeqnarray
% (sets local strut values back to previous master strut values)
\@SCIeqnarraystrutreset%
% ensure last line, exit from halign, close vbox
\crcr\egroup\egroup%
% exit from math mode and close hbox if needed
\if@SCIeqnarrayboxHBOXSW $\egroup\fi}



% SCIeqnarraybox uses a modifed \\ instead of the plain \cr to
% end rows. This allows for things like \\[vskip amount]
% This "cr" macros are modified versions those for LaTeX2e's eqnarray
% For SCIeqnarraybox, \\* is the same as \\
% the {\ifnum0=`} braces must be kept away from the last column to avoid
% altering spacing of its math, so we use & to advance to the isolation/strut column
% carry strut status into isolation/strut column
\def\@SCIeqnarrayboxcr{\@SCIeqnarrayglobalizestrutstatus% carry strut status
&% enter isolation/strut column
\@SCIeqnarrayinsertstrut% do strut if needed
% reset the strut system for next line or SCIeqnarray
\@SCIeqnarraystrutreset%
{\ifnum0=`}\fi%
\@ifstar{\@SCIeqnarrayboxYCR}{\@SCIeqnarrayboxYCR}}

% test and setup the optional argument to \\[]
\def\@SCIeqnarrayboxYCR{\@testopt\@SCIeqnarrayboxXCR\z@skip}

% SCIeqnarraybox does not automatically increase line spacing by \jot
\def\@SCIeqnarrayboxXCR[#1]{\ifnum0=`{\fi}%
\cr\noalign{\if@SCIeqnarraystarform\else\vskip\jot\fi\vskip#1\relax}}



% starts the halign preamble build
\def\@SCIbuildpreamble{\@SCIndustriatmptoksA={}% clear token register
\let\@SCIBPcurtype=u%current column type is not yet known
\let\@SCIBPprevtype=s%the previous column type was the start
\let\@SCIBPnexttype=u%next column type is not yet known
% ensure these are valid
\def\@SCIBPcurglue={0pt plus 0pt minus 0pt}%
\def\@SCIBPcurcolname{@SCIdefault}% name of current column definition
% currently acquired numerically referenced glue
% use a name that is easier to remember
\let\@SCIBPcurnum=\@SCIndustriatmpcountA%
\@SCIBPcurnum=0%
% tracks number of columns in the preamble
\@SCIeqnnumcols=0%
% record the default end glues
\edef\@SCIBPstartglue{\@SCIeqnarraycolSEPdefaultstart}%
\edef\@SCIBPendglue{\@SCIeqnarraycolSEPdefaultend}%
% now parse the user's column specifications
\@@SCIbuildpreamble}


% parses and builds the halign preamble
\def\@@SCIbuildpreamble#1#2{\let\@@nextSCIbuildpreamble=\@@SCIbuildpreamble%
% use only the very first token to check the end
% \noindent is used as a delimiter as \end can be present here
\def\@SCIgrabfirstoken##1##2\noindent{\let\@SCIgrabbedfirstoken=##1}%
\@SCIgrabfirstoken#1\relax\relax\noindent
\ifx\@SCIgrabbedfirstoken\end\let\@@nextSCIbuildpreamble=\@@SCIfinishpreamble\else%
% identify current and next token type
\@SCIgetcoltype{#1}{\@SCIBPcurtype}{1}% current, error on invalid
\@SCIgetcoltype{#2}{\@SCIBPnexttype}{0}% next, no error on invalid next
% if curtype is a glue, get the glue def
\if\@SCIBPcurtype g\@SCIgetcurglue{#1}{\@SCIBPcurglue}\fi%
% if curtype is a column, get the column def and set the current column name
\if\@SCIBPcurtype c\@SCIgetcurcol{#1}\fi%
% if curtype is a numeral, acquire the user defined glue
\if\@SCIBPcurtype n\@SCIprocessNcol{#1}\fi%
% process the acquired glue
\if\@SCIBPcurtype g\@SCIprocessGcol\fi%
% process the acquired col
\if\@SCIBPcurtype c\@SCIprocessCcol\fi%
% ready prevtype for next col spec.
\let\@SCIBPprevtype=\@SCIBPcurtype%
% be sure and put back the future token(s) as a group
\fi\@@nextSCIbuildpreamble{#2}}


% executed just after preamble build is completed
% warn about zero cols, and if prevtype type = u, put in end tabskip glue
\def\@@SCIfinishpreamble#1{\ifnum\@SCIeqnnumcols<1\relax
\@SCIclspkgerror{No column specifiers declared for SCIeqnarray}%
{At least one column type must be declared for each SCIeqnarray.}%
\fi%num cols less than 1
%if last type undefined, set default end tabskip glue
\if\@SCIBPprevtype u\@SCIappendtoksA{\tabskip=\@SCIBPendglue}\fi}


% Identify and return the column specifier's type code
\def\@SCIgetcoltype#1#2#3{%
% use only the very first token to determine the type
% \noindent is used as a delimiter as \end can be present here
\def\@SCIgrabfirstoken##1##2\noindent{\let\@SCIgrabbedfirstoken=##1}%
\@SCIgrabfirstoken#1\relax\relax\noindent
% \@SCIgrabfirstoken has the first token, the rest are discarded
% n = number
% g = glue (any other char in catagory 12)
% c = letter
% e = \end
% u = undefined
% third argument: 0 = no error message, 1 = error on invalid char
\let#2=u\relax% assume invalid until know otherwise
\ifx\@SCIgrabbedfirstoken\end\let#2=e\else
\ifcat\@SCIgrabbedfirstoken\relax\else% screen out control sequences
\if0\@SCIgrabbedfirstoken\let#2=n\else
\if1\@SCIgrabbedfirstoken\let#2=n\else
\if2\@SCIgrabbedfirstoken\let#2=n\else
\if3\@SCIgrabbedfirstoken\let#2=n\else
\if4\@SCIgrabbedfirstoken\let#2=n\else
\if5\@SCIgrabbedfirstoken\let#2=n\else
\if6\@SCIgrabbedfirstoken\let#2=n\else
\if7\@SCIgrabbedfirstoken\let#2=n\else
\if8\@SCIgrabbedfirstoken\let#2=n\else
\if9\@SCIgrabbedfirstoken\let#2=n\else
\ifcat,\@SCIgrabbedfirstoken\let#2=g\relax
\else\ifcat a\@SCIgrabbedfirstoken\let#2=c\relax\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
\if#2u\relax
\if0\noexpand#3\relax\else\@SCIclspkgerror{Invalid character in column specifications}%
{Only letters, numerals and certain other symbols are allowed \MessageBreak
as SCIeqnarray column specifiers.}\fi\fi}


% identify the current letter referenced column
% if invalid, use a default column
\def\@SCIgetcurcol#1{\expandafter\ifx\csname @SCIeqnarraycolDEF#1\endcsname\@SCIeqnarraycolisdefined%
\def\@SCIBPcurcolname{#1}\else% invalid column name
\@SCIclspkgerror{Invalid column type "#1" in column specifications.\MessageBreak
Using a default centering column instead}%
{You must define SCIeqnarray column types before use.}%
\def\@SCIBPcurcolname{@SCIdefault}\fi}


% identify and return the predefined (punctuation) glue value
\def\@SCIgetcurglue#1#2{%
% ! = \! (neg small)  -0.16667em (-3/18 em)
% , = \, (small)       0.16667em ( 3/18 em)
% : = \: (med)         0.22222em ( 4/18 em)
% ; = \; (large)       0.27778em ( 5/18 em)
% ' = \quad            1em
% " = \qquad           2em
% . = 0.5\arraycolsep
% / = \arraycolsep
% ? = 2\arraycolsep
% * = 1fil
% + = \@SCIeqnarraycolSEPcenter
% - = \@SCIeqnarraycolSEPzero
% Note that all em values are referenced to the math font (textfont2) fontdimen6
% value for 1em.
%
% use only the very first token to determine the type
% this prevents errant tokens from getting in the main text
% \noindent is used as a delimiter here
\def\@SCIgrabfirstoken##1##2\noindent{\let\@SCIgrabbedfirstoken=##1}%
\@SCIgrabfirstoken#1\relax\relax\noindent
% get the math font 1em value
% LaTeX2e's NFSS2 does not preload the fonts, but \SCIeqnarray needs
% to gain access to the math (\textfont2) font's spacing parameters.
% So we create a bogus box here that uses the math font to ensure
% that \textfont2 is loaded and ready. If this is not done,
% the \textfont2 stuff here may not work.
% Thanks to Bernd Raichle for his 1997 post on this topic.
{\setbox0=\hbox{$\displaystyle\relax$}}%
% fontdimen6 has the width of 1em (a quad).
\@SCIndustriatmpdimenA=\fontdimen6\textfont2\relax%
% identify the glue value based on the first token
% we discard anything after the first
\if!\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=-0.16667\@SCIndustriatmpdimenA\edef#2{\the\@SCIndustriatmpdimenA}\else
\if,\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=0.16667\@SCIndustriatmpdimenA\edef#2{\the\@SCIndustriatmpdimenA}\else
\if:\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=0.22222\@SCIndustriatmpdimenA\edef#2{\the\@SCIndustriatmpdimenA}\else
\if;\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=0.27778\@SCIndustriatmpdimenA\edef#2{\the\@SCIndustriatmpdimenA}\else
\if'\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=1\@SCIndustriatmpdimenA\edef#2{\the\@SCIndustriatmpdimenA}\else
\if"\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=2\@SCIndustriatmpdimenA\edef#2{\the\@SCIndustriatmpdimenA}\else
\if.\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=0.5\arraycolsep\edef#2{\the\@SCIndustriatmpdimenA}\else
\if/\@SCIgrabbedfirstoken\edef#2{\the\arraycolsep}\else
\if?\@SCIgrabbedfirstoken\@SCIndustriatmpdimenA=2\arraycolsep\edef#2{\the\@SCIndustriatmpdimenA}\else
\if *\@SCIgrabbedfirstoken\edef#2{0pt plus 1fil minus 0pt}\else
\if+\@SCIgrabbedfirstoken\edef#2{\@SCIeqnarraycolSEPcenter}\else
\if-\@SCIgrabbedfirstoken\edef#2{\@SCIeqnarraycolSEPzero}\else
\edef#2{\@SCIeqnarraycolSEPzero}%
\@SCIclspkgerror{Invalid predefined inter-column glue type "#1" in\MessageBreak
column specifications. Using a default value of\MessageBreak
0pt instead}%
{Only !,:;'"./?*+ and - are valid predefined glue types in the\MessageBreak
SCIeqnarray column specifications.}\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi}



% process a numerical digit from the column specification
% and look up the corresponding user defined glue value
% can transform current type from n to g or a as the user defined glue is acquired
\def\@SCIprocessNcol#1{\if\@SCIBPprevtype g%
\@SCIclspkgerror{Back-to-back inter-column glue specifiers in column\MessageBreak
specifications. Ignoring consecutive glue specifiers\MessageBreak
after the first}%
{You cannot have two or more glue types next to each other\MessageBreak
in the SCIeqnarray column specifications.}%
\let\@SCIBPcurtype=a% abort this glue, future digits will be discarded
\@SCIBPcurnum=0\relax%
\else% if we previously aborted a glue
\if\@SCIBPprevtype a\@SCIBPcurnum=0\let\@SCIBPcurtype=a%maintain digit abortion
\else%acquire this number
% save the previous type before the numerical digits started
\if\@SCIBPprevtype n\else\let\@SCIBPprevsavedtype=\@SCIBPprevtype\fi%
\multiply\@SCIBPcurnum by 10\relax%
\advance\@SCIBPcurnum by #1\relax% add in number, \relax is needed to stop TeX's number scan
\if\@SCIBPnexttype n\else%close acquisition
\expandafter\ifx\csname @SCIeqnarraycolSEPDEF\expandafter\romannumeral\number\@SCIBPcurnum\endcsname\@SCIeqnarraycolisdefined%
\edef\@SCIBPcurglue{\csname @SCIeqnarraycolSEP\expandafter\romannumeral\number\@SCIBPcurnum\endcsname}%
\else%user glue not defined
\@SCIclspkgerror{Invalid user defined inter-column glue type "\number\@SCIBPcurnum" in\MessageBreak
column specifications. Using a default value of\MessageBreak
0pt instead}%
{You must define all SCIeqnarray numerical inter-column glue types via\MessageBreak
\string\SCIeqnarraydefcolsep \space before they are used in column specifications.}%
\edef\@SCIBPcurglue{\@SCIeqnarraycolSEPzero}%
\fi% glue defined or not
\let\@SCIBPcurtype=g% change the type to reflect the acquired glue
\let\@SCIBPprevtype=\@SCIBPprevsavedtype% restore the prev type before this number glue
\@SCIBPcurnum=0\relax%ready for next acquisition
\fi%close acquisition, get glue
\fi%discard or acquire number
\fi%prevtype glue or not
}


% process an acquired glue
% add any acquired column/glue pair to the preamble
\def\@SCIprocessGcol{\if\@SCIBPprevtype a\let\@SCIBPcurtype=a%maintain previous glue abortions
\else
% if this is the start glue, save it, but do nothing else
% as this is not used in the preamble, but before
\if\@SCIBPprevtype s\edef\@SCIBPstartglue{\@SCIBPcurglue}%
\else%not the start glue
\if\@SCIBPprevtype g%ignore if back to back glues
\@SCIclspkgerror{Back-to-back inter-column glue specifiers in column\MessageBreak
specifications. Ignoring consecutive glue specifiers\MessageBreak
after the first}%
{You cannot have two or more glue types next to each other\MessageBreak
in the SCIeqnarray column specifications.}%
\let\@SCIBPcurtype=a% abort this glue
\else% not a back to back glue
\if\@SCIBPprevtype c\relax% if the previoustype was a col, add column/glue pair to preamble
\ifnum\@SCIeqnnumcols>0\relax\@SCIappendtoksA{&}\fi
\toks0={##}%
% make preamble advance col counter if this environment needs this
\if@advanceSCIeqncolcnt\@SCIappendtoksA{\global\advance\@SCIeqncolcnt by 1\relax}\fi
% insert the column defintion into the preamble, being careful not to expand
% the column definition
\@SCIappendtoksA{\tabskip=\@SCIBPcurglue}%
\@SCIappendNOEXPANDtoksA{\begingroup\csname @SCIeqnarraycolPRE}%
\@SCIappendtoksA{\@SCIBPcurcolname}%
\@SCIappendNOEXPANDtoksA{\endcsname}%
\@SCIappendtoksA{\the\toks0}%
\@SCIappendNOEXPANDtoksA{\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\csname @SCIeqnarraycolPOST}%
\@SCIappendtoksA{\@SCIBPcurcolname}%
\@SCIappendNOEXPANDtoksA{\endcsname\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\endgroup}%
\advance\@SCIeqnnumcols by 1\relax%one more column in the preamble
\else% error: non-start glue with no pending column
\@SCIclspkgerror{Inter-column glue specifier without a prior column\MessageBreak
type in the column specifications. Ignoring this glue\MessageBreak
specifier}%
{Except for the first and last positions, glue can be placed only\MessageBreak
between column types.}%
\let\@SCIBPcurtype=a% abort this glue
\fi% previous was a column
\fi% back-to-back glues
\fi% is start column glue
\fi% prev type not a
}


% process an acquired letter referenced column and, if necessary, add it to the preamble
\def\@SCIprocessCcol{\if\@SCIBPnexttype g\else
\if\@SCIBPnexttype n\else
% we have a column followed by something other than a glue (or numeral glue)
% so we must add this column to the preamble now
\ifnum\@SCIeqnnumcols>0\relax\@SCIappendtoksA{&}\fi%col separator for those after the first
\if\@SCIBPnexttype e\@SCIappendtoksA{\tabskip=\@SCIBPendglue\relax}\else%put in end glue
\@SCIappendtoksA{\tabskip=\@SCIeqnarraycolSEPdefaultmid\relax}\fi% or default mid glue
\toks0={##}%
% make preamble advance col counter if this environment needs this
\if@advanceSCIeqncolcnt\@SCIappendtoksA{\global\advance\@SCIeqncolcnt by 1\relax}\fi
% insert the column definition into the preamble, being careful not to expand
% the column definition
\@SCIappendNOEXPANDtoksA{\begingroup\csname @SCIeqnarraycolPRE}%
\@SCIappendtoksA{\@SCIBPcurcolname}%
\@SCIappendNOEXPANDtoksA{\endcsname}%
\@SCIappendtoksA{\the\toks0}%
\@SCIappendNOEXPANDtoksA{\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\csname @SCIeqnarraycolPOST}%
\@SCIappendtoksA{\@SCIBPcurcolname}%
\@SCIappendNOEXPANDtoksA{\endcsname\relax\relax\relax\relax\relax%
\relax\relax\relax\relax\relax\endgroup}%
\advance\@SCIeqnnumcols by 1\relax%one more column in the preamble
\fi%next type not numeral
\fi%next type not glue
}


%%
%% END OF SCIeqnarry DEFINITIONS
%%




% set up the running headings, this complex because of all the different
% modes SCIndustria supports
\if@twoside
 \if@technote
   \def\ps@headings{%
       \def\@oddhead{\hbox{}\scriptsize\leftmark \hfil} %modificado
       \def\@evenhead{\scriptsize \hfil \leftmark\hbox{}} %modificado
       \if@draftclsmode
            \if@draftclsmodefoot
               \def\@oddfoot{\scriptsize\@date\hfil DRAFT}
               \def\@evenfoot{\scriptsize DRAFT\hfil\@date}
            \else
               \def\@oddfoot{}\def\@evenfoot{}%
            \fi
       \else
            \def\@oddfoot{}\def\@evenfoot{}
       \fi}
 \else % not a technote
   \def\ps@headings{%
       \if@confmode
        \def\@oddhead{}
        \def\@evenhead{}
       \else
        \def\@oddhead{\hbox{}\scriptsize\rightmark \hfil } %modificado
        \def\@evenhead{\scriptsize\hfil \leftmark\hbox{}} %modificado
       \fi
       \if@draftclsmode
            \def\@oddhead{\hbox{}\scriptsize\rightmark \hfil } %modificado
            \def\@evenhead{\scriptsize \hfil \leftmark\hbox{}} %modificado
            \if@draftclsmodefoot
               \def\@oddfoot{\scriptsize\@date\hfil DRAFT}
               \def\@evenfoot{\scriptsize DRAFT\hfil\@date}
            \else
               \def\@oddfoot{}\def\@evenfoot{}%
            \fi
       \else
            \def\@oddfoot{}\def\@evenfoot{}%
       \fi}
 \fi
\else % single side
\def\ps@headings{%
    \if@confmode
     \def\@oddhead{}
     \def\@evenhead{}
    \else
     \def\@oddhead{\hbox{}\scriptsize\leftmark \hfil } %modificado
     \def\@evenhead{}
    \fi
    \if@draftclsmode
          \def\@oddhead{\hbox{}\scriptsize\leftmark \hfil } %modificado
          \def\@evenhead{}
          \if@draftclsmodefoot
             \def\@oddfoot{\scriptsize \@date \hfil DRAFT}
          \else
             \def\@oddfoot{}
          \fi
    \else
         \def\@oddfoot{}
    \fi
    \def\@evenfoot{}}
\fi


% title page style
\def\ps@titlepagestyle{\def\@oddfoot{}\def\@evenfoot{}%
\if@confmode
   \def\@oddhead{}%
   \def\@evenhead{}%
\else
   \def\@oddhead{\hbox{}\scriptsize\leftmark \hfil }%modificado
   \def\@evenhead{\scriptsize \hfil \leftmark\hbox{}}%modificado
\fi
\if@draftclsmode
   \def\@oddhead{\hbox{}\scriptsize\leftmark \hfil }%modificado
   \def\@evenhead{\scriptsize \hfil \leftmark\hbox{}}%modificado
   \if@draftclsmodefoot
      \def\@oddfoot{\scriptsize \@date\hfil DRAFT}%
      \def\@evenfoot{\scriptsize DRAFT\hfil \@date}%
   \fi
\else
   % all non-draft mode footers
   \if@SCIusingpubid
      % for title pages that are using a pubid
      % do not repeat pubid if using peer review option
      \if@peerreviewoption
      \else
         \footskip 0pt%
         \def\@oddfoot{\hss\normalfont\footnotesize\raisebox{1.5ex}[1.5ex]{\@pubid}\hss}%
         \def\@evenfoot{\hss\normalfont\footnotesize\raisebox{1.5ex}[1.5ex]{\@pubid}\hss}%
      \fi
   \fi
\fi}


% peer review cover page style
\def\ps@peerreviewcoverpagestyle{%
\def\@oddhead{}\def\@evenhead{}%
\def\@oddfoot{}\def\@evenfoot{}%
\if@draftclsmode
   \if@draftclsmodefoot
      \def\@oddfoot{\scriptsize \@date\hfil DRAFT}%
      \def\@evenfoot{\scriptsize DRAFT\hfil \@date}%
   \fi
\else
   % non-draft mode footers
   \if@SCIusingpubid
      \footskip 0pt%
      \def\@oddfoot{\hss\normalfont\footnotesize\raisebox{1.5ex}[1.5ex]{\@pubid}\hss}%
      \def\@evenfoot{\hss\normalfont\footnotesize\raisebox{1.5ex}[1.5ex]{\@pubid}\hss}%
   \fi
\fi}


% start with empty headings
\def\rightmark{}\def\leftmark{}


%% Defines the command for putting the header. \footernote{TEXT} is the same
%% as \markboth{TEXT}{TEXT}.
%% Note that all the text is forced into uppercase, if you have some text
%% that needs to be in lower case, for instance et. al., then either manually
%% set \leftmark and \rightmark or use \MakeLowercase{et. al.} within the
%% arguments to \markboth.
\def\markboth#1#2{\def\leftmark{\MakeUppercase{#1}}\def\rightmark{\MakeUppercase{#2}}}
\def\footernote#1{\markboth{#1}{#1}}

\def\today{\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day, \number\year}




%% CITATION AND BIBLIOGRAPHY COMMANDS
%%
%% V1.6 no longer supports the older, nonstandard \shortcite and \citename setup stuff
%
%
% Modify Latex2e \@citex to separate citations with "], ["
\def\@citex[#1]#2{%
  \let\@citea\@empty
  \@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{], [}%
     \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Citation `\@citeb' on page \thepage \space undefined}}%
       {\hbox{\csname b@\@citeb\endcsname}}}}{#1}}

% V1.6 we create hooks for the optional use of Donald Arseneau's
% cite.sty package. cite.sty is "smart" and will notice that the
% following format controls are already defined and will not
% redefine them. The result will be the proper sorting of the
% citation numbers and auto detection of 3 or more entry "ranges" -
% all in SCI style:  [1], [2], [5]--[7], [12]
% This also allows for an optional note, i.e., \cite[mynote]{..}.
% If the \cite with note has more than one reference, the note will
% be applied to the last of the listed references. It is generally
% desired that if a note is given, only one reference is listed in
% that \cite.
% Thanks to Mr. Arseneau for providing the required format arguments
% to produce the SCI style.
\def\citepunct{], [}
\def\citedash{]--[}


% V1.6b providing this command makes hyperref think the natbib package is
% in use so that it will not interfere with cite.sty. However, as a result,
% citation numbers will not be hyperlinked.
\def\NAT@parse{\typeout{SCIndustria error: Attempt to use fake Natbib command
which is provided to fool Hyperref.}}
% it easy enough to override via:
% \let\NAT@parse\undefined


% V1.6 class files should always provide these
\def\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty



% Provide support for the control entries of SCIndustria.bst V1.00 and later.
\def\bstctlcite#1{\@bsphack
  \@for\@citeb:=#1\do{%
    \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi}%
  \@esphack}

% V1.6 provide a way for a user to execute a command just before
% a given reference number - used to insert a \newpage to balance
% the columns on the last page
\edef\@SCItriggerrefnum{0}   % the default of zero means that
                              % the command is not executed
\def\@SCItriggercmd{\newpage}

% allow the user to alter the triggered command
\long\def\SCItriggercmd#1{\long\def\@SCItriggercmd{#1}}

% allow user a way to specify the reference number just before the
% command is executed
\def\SCItriggeratref#1{\@SCIndustriatmpcountA=#1%
\edef\@SCItriggerrefnum{\the\@SCIndustriatmpcountA}}%

% trigger command at the given reference
\def\@SCIbibitemprefix{\@SCIndustriatmpcountA=\@SCItriggerrefnum\relax%
\advance\@SCIndustriatmpcountA by -1\relax%
\ifnum\c@enumiv=\@SCIndustriatmpcountA\relax\@SCItriggercmd\relax\fi}

\def\@biblabel#1{[#1]}

\def\thebibliography#1{%\section*{References}%
    %\addcontentsline{toc}{section}{References}%
    % V1.6 add some rubber space here and provide a command trigger
    \footnotesize \vskip 0.3\baselineskip plus 0.1\baselineskip minus 0.1\baselineskip%
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep\relax
    \itemsep 0pt plus .5pt\relax%
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \let\@SCIlatexbibitem\bibitem%
    \def\bibitem{\@SCIbibitemprefix\@SCIlatexbibitem}%
\def\newblock{\hskip .11em plus .33em minus .07em}%
% originally:
%   \sloppy\clubpenalty4000\widowpenalty4000%
% by adding the \interlinepenalty here, we make it more
% difficult, but not impossible, for LaTeX to break within a reference.
% SCI almost never breaks a reference (but they do it more often with
% technotes). You may get an underfull vbox warning around the bibliography,
% but the final result will be much more like what SCI will publish.
% MDS 11/2000
\if@technote\sloppy\clubpenalty4000\widowpenalty4000\interlinepenalty100%
\else\sloppy\clubpenalty4000\widowpenalty4000\interlinepenalty500\fi%
    \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist






% TITLE PAGE COMMANDS
%
%
% \SCImembership is used to produce the sublargesize italic font used to indicate author
% SCI membership.
\def\SCImembership#1{{\sublargesize\normalfont\textit{#1}}}


% \authorrefmark{} produces a footnote type symbol to indicate author affiliation.
% When given an argument of 1 to 9, \authorrefmark{} follows the standard LaTeX footnote
% symbol sequence convention. However, for arguments 10 and above, \authorrefmark{}
% reverts to using lower case roman numerals, so it cannot overflow. Do note that you
% cannot use \footnotemark[] in place of \authorrefmark{} within \author as the footnote
% symbols will have been turned off to prevent \thanks from creating footnote marks.
% \authorrefmark{} produces a symbol that appears to LaTeX as having zero vertical
% height - this allows for a more compact line packing, but the user must ensure that
% the interline spacing is large enough to prevent \authorrefmark{} from colliding
% with the text above.
\def\authorrefmark#1{\raisebox{0pt}[0pt][0pt]{\textsuperscript{\footnotesize\ensuremath{\ifcase#1\or *\or \dagger\or \ddagger\or%
    \mathsection\or \mathparagraph\or \|\or **\or \dagger\dagger%
    \or \ddagger\ddagger \else\textsuperscript{\expandafter\romannumeral#1}\fi}}}}


% FONT CONTROLS AND SPACINGS FOR CONFERENCE MODE AUTHOR NAME AND AFFILIATION BLOCKS
%
% The default font styles for the author name and affiliation blocks (confmode)
\def\@SCIauthorblockNstyle{\normalfont\sublargesize}
\def\@SCIauthorblockAstyle{\normalfont\normalsize}
% The default if the user does not use an author block
\def\@SCIauthordefaulttextstyle{\normalfont\sublargesize}

% spacing from title (or special paper notice) to author name blocks (confmode)
% can be negative
\def\@SCIauthorblockconfadjspace{-0.25em}

% spacing between name and affiliation blocks (confmode)
% This can be negative.
% SCI doesn't want any added spacing here, but I will leave these
% controls in place in case they ever change their mind.
% Personally, I like 0.75ex.
%\def\@SCIauthorblockNtopspace{0.75ex}
%\def\@SCIauthorblockAtopspace{0.75ex}
\def\@SCIauthorblockNtopspace{0.0ex}
\def\@SCIauthorblockAtopspace{0.0ex}
% baseline spacing within name and affiliation blocks (confmode)
% must be positive, spacings below certain values will make
% the position of line of text sensitive to the contents of the
% line above it i.e., whether or not the prior line has descenders,
% subscripts, etc. For this reason it is a good idea to keep
% these above 2.6ex
\def\@SCIauthorblockNinterlinespace{2.6ex}
\def\@SCIauthorblockAinterlinespace{2.75ex}

% This tracks the required strut size.
% See the \@SCIauthorhalign command for the actual default value used.
\def\@SCIauthorblockXinterlinespace{2.7ex}

% variables to retain font size and style across groups
% values given here have no effect as they will be overwritten later
\gdef\@SCISAVESTATEfontsize{10}
\gdef\@SCISAVESTATEfontbaselineskip{12}
\gdef\@SCISAVESTATEfontencoding{OT1}
\gdef\@SCISAVESTATEfontfamily{ptm}
\gdef\@SCISAVESTATEfontseries{m}
\gdef\@SCISAVESTATEfontshape{n}

% saves the current font attributes
\def\@SCIcurfontSAVE{\global\let\@SCISAVESTATEfontsize\f@size%
\global\let\@SCISAVESTATEfontbaselineskip\f@baselineskip%
\global\let\@SCISAVESTATEfontencoding\f@encoding%
\global\let\@SCISAVESTATEfontfamily\f@family%
\global\let\@SCISAVESTATEfontseries\f@series%
\global\let\@SCISAVESTATEfontshape\f@shape}

% restores the saved font attributes
\def\@SCIcurfontRESTORE{\fontsize{\@SCISAVESTATEfontsize}{\@SCISAVESTATEfontbaselineskip}%
\fontencoding{\@SCISAVESTATEfontencoding}%
\fontfamily{\@SCISAVESTATEfontfamily}%
\fontseries{\@SCISAVESTATEfontseries}%
\fontshape{\@SCISAVESTATEfontshape}%
\selectfont}


% variable to indicate if the current block is the first block in the column
\newif\if@SCIprevauthorblockincol   \@SCIprevauthorblockincolfalse


% the command places a strut with height and depth = \@SCIauthorblockXinterlinespace
% we use this technique to have complete manual control over the spacing of the lines
% within the halign environment.
% We set the below baseline portion at 30%, the above
% baseline portion at 70% of the total length.
% Responds to changes in the document's \baselinestretch
\def\@SCIauthorstrutrule{\@SCIndustriatmpdimenA\@SCIauthorblockXinterlinespace%
\@SCIndustriatmpdimenA=\baselinestretch\@SCIndustriatmpdimenA%
\rule[-0.3\@SCIndustriatmpdimenA]{0pt}{\@SCIndustriatmpdimenA}}


% blocks to hold the authors' names and affilations.
% Makes formatting easy for conferences
%
% use real definitions in conference mode
% name block
\def\authorblockN#1{\relax\@SCIauthorblockNstyle% set the default text style
\gdef\@SCIauthorblockXinterlinespace{0pt}% disable strut for spacer row
% the \expandafter hides the \cr in conditional tex, see the array.sty docs
% for details, probably not needed here as the \cr is in a macro
% do a spacer row if needed
\if@SCIprevauthorblockincol\expandafter\@SCIauthorblockNtopspaceline\fi
\global\@SCIprevauthorblockincoltrue% we now have a block in this column
%restore the correct strut value
\gdef\@SCIauthorblockXinterlinespace{\@SCIauthorblockNinterlinespace}%
% input the author names
#1%
% end the row if the user did not already
\crcr}
% spacer row for names
\def\@SCIauthorblockNtopspaceline{\cr\noalign{\vskip\@SCIauthorblockNtopspace}}
%
% affiliation block
\def\authorblockA#1{\relax\@SCIauthorblockAstyle% set the default text style
\gdef\@SCIauthorblockXinterlinespace{0pt}%disable strut for spacer row
% the \expandafter hides the \cr in conditional tex, see the array.sty docs
% for details, probably not needed here as the \cr is in a macro
% do a spacer row if needed
\if@SCIprevauthorblockincol\expandafter\@SCIauthorblockAtopspaceline\fi
\global\@SCIprevauthorblockincoltrue% we now have a block in this column
%restore the correct strut value
\gdef\@SCIauthorblockXinterlinespace{\@SCIauthorblockAinterlinespace}%
% input the author affiliations
#1%
% end the row if the user did not already
\crcr}
% spacer row for affiliations
\def\@SCIauthorblockAtopspaceline{\cr\noalign{\vskip\@SCIauthorblockAtopspace}}


% allow papers to compile even if author blocks are used in modes other
% than conference or peerreviewca. For such cases, we provide dummy blocks.
\if@confmode
\else
   \if@peerreviewcaoption\else
      % not conference or peerreviewca mode
      \def\authorblockN#1{#1}%
      \def\authorblockA#1{#1}%
   \fi
\fi



% we provide our own halign so as not to have to depend on tabular
\def\@SCIauthorhalign{\@SCIauthordefaulttextstyle% default text style
   \lineskip=0pt\relax% disable line spacing
   \lineskiplimit=0pt\relax%
   \baselineskip=0pt\relax%
   \@SCIcurfontSAVE% save the current font
   \mathsurround\z@\relax% no extra spacing around math
   \let\\\@SCIauthorhaligncr% replace newline with halign friendly one
   \tabskip=0pt\relax% no column spacing
   \everycr{}% ensure no problems here
   \@SCIprevauthorblockincolfalse% no author blocks yet
   \def\@SCIauthorblockXinterlinespace{2.7ex}% default interline space
   \vtop\bgroup%vtop box
   \halign\bgroup&\relax\hfil\@SCIcurfontRESTORE\relax ##\relax
   \hfil\@SCIcurfontSAVE\@SCIauthorstrutrule\cr}

% ensure last line, exit from halign, close vbox
\def\end@SCIauthorhalign{\crcr\egroup\egroup}

% handle bogus star form
\def\@SCIauthorhaligncr{{\ifnum0=`}\fi\@ifstar{\@@SCIauthorhaligncr}{\@@SCIauthorhaligncr}}

% test and setup the optional argument to \\[]
\def\@@SCIauthorhaligncr{\@testopt\@@@SCIauthorhaligncr\z@skip}

% end the line and do the optional spacer
\def\@@@SCIauthorhaligncr[#1]{\ifnum0=`{\fi}\cr\noalign{\vskip#1\relax}}



% flag to prevent multiple \and warning messages
\newif\if@SCIWARNand
\@SCIWARNandtrue

% if in conference or peerreviewca modes, we support the use of \and as \author is a
% tabular environment, otherwise we warn the user that \and is invalid
% outside of conference or peerreviewca modes.
\def\and{\relax} % provide a bogus \and that we will then override

\renewcommand{\and}[1][\relax]{\if@SCIWARNand\typeout{** WARNING: \noexpand\and is valid only
                               when in conference or peerreviewca}\typeout{modes (line \the\inputlineno).}\fi\global\@SCIWARNandfalse}

\if@confmode%
\renewcommand{\and}[1][\hfill]{\end{@SCIauthorhalign}#1\begin{@SCIauthorhalign}}%
\fi
\if@peerreviewcaoption
\renewcommand{\and}[1][\hfill]{\end{@SCIauthorhalign}#1\begin{@SCIauthorhalign}}%
\fi


% page clearing command
% based on LaTeX2e's \cleardoublepage, but allows different page styles
% for the inserted blank pages
\def\@SCIcleardoublepage#1{\clearpage\if@twoside\ifodd\c@page\else
\hbox{}\thispagestyle{#1}\newpage\if@twocolumn\hbox{}\thispagestyle{#1}\newpage\fi\fi\fi}


% user command to invoke the title page
\def\maketitle{\par%
  \begingroup%
  \normalfont%
  \def\thefootnote{}%  the \thanks{} mark type is empty
  \def\footnotemark{}% and kill space from \thanks within author
  \footnotesize%       equal spacing between thanks lines
  \footnotesep 0.7\baselineskip%see global setting of \footnotesep for more info
  \normalsize%
  \if@peerreviewoption
     \newpage\global\@topnum\z@ \@maketitle\@SCIstatictitlevskip\@SCIaftertitletext%
     \thispagestyle{peerreviewcoverpagestyle}\@thanks%
  \else
     \if@twocolumn%
        \if@technote%
           \newpage\global\@topnum\z@ \@maketitle\@SCIstatictitlevskip\@SCIaftertitletext%
        \else
           \twocolumn[\@maketitle\@SCIdynamictitlevspace\@SCIaftertitletext]%
        \fi
     \else
        \newpage\global\@topnum\z@ \@maketitle\@SCIstatictitlevskip\@SCIaftertitletext%
     \fi
     \thispagestyle{titlepagestyle}\@thanks%
  \fi
  % pullup page for pubid if used.
  \if@SCIusingpubid
     \enlargethispage{-\@pubidpullup}%
  \fi
  \endgroup
  % Comentado por SCI -------------------
  \setcounter{footnote}{0}\let\maketitle\relax\let\@maketitle\relax
  % Fim do comentário -------------------
  \gdef\@thanks{}
  % v1.6b do not clear these as we will need the title again for peer review papers
  % \gdef\@author{}\gdef\@title{}%
  \let\thanks\relax}


% formats the Title, authors names, affiliations and special paper notice
% THIS IS A CONTROLLED SPACING COMMAND! Do not allow blank lines or unintentional
% spaces to enter the definition - use % at the end of each line
\def\@maketitle{\newpage
\begin{center}%
\if@technote%
   {\bfseries\large\@title\par}\vskip 1.3em{\lineskip .5em\@author\@specialpapernotice\par}%
\else% not a technote
   \vskip0.2em{\Huge\@title\par}\vskip1.0em\par%
   % V1.6 handle \author differently if in conference mode
   \if@confmode%
      {\@specialpapernotice\mbox{}\vskip\@SCIauthorblockconfadjspace%
      \mbox{}\hfill\begin{@SCIauthorhalign}\@author\end{@SCIauthorhalign}\hfill\mbox{}\par}%
   \else% peerreviewca, peerreview or journal
      \if@peerreviewcaoption
         % peerreviewca handles author names just like conference mode
         {\@specialpapernotice\mbox{}\vskip\@SCIauthorblockconfadjspace%
         \mbox{}\hfill\begin{@SCIauthorhalign}\@author\end{@SCIauthorhalign}\hfill\mbox{}\par}%
      \else % journal or peerreview
         {\lineskip.5em\sublargesize\@author\@specialpapernotice\par}%
      \fi
   \fi
\fi\end{center}}

























%===============================================
% user command to invoke the title page
\def\maketitleii{\par%
  \begingroup%
  \normalfont%
  \def\thefootnote{}%  the \thanks{} mark type is empty
  \def\footnotemark{}% and kill space from \thanks within author
  \footnotesize%       equal spacing between thanks lines
  \footnotesep 0.7\baselineskip%see global setting of \footnotesep for more info
  \normalsize%
  \if@peerreviewoption
     \newpage\global\@topnum\z@ \@maketitleii\@SCIstatictitlevskip\@SCIaftertitletext%
     \thispagestyle{peerreviewcoverpagestyle}\@thanks%
  \else
     \if@twocolumn%
        \if@technote%
           \newpage\global\@topnum\z@ \@maketitleii\@SCIstatictitlevskip\@SCIaftertitletext%
        \else
           \twocolumn[\@maketitleii\@SCIdynamictitlevspace\@SCIaftertitletext]%
        \fi
     \else
        \global\@topnum\z@ \@maketitleii\@SCIstatictitlevskip\@SCIaftertitletext%
     \fi
     \thispagestyle{titlepagestyle}\@thanks%
  \fi
  % pullup page for pubid if used.
  \if@SCIusingpubid
     \enlargethispage{-\@pubidpullup}%
  \fi
  \endgroup
  % Comentado por SCI -------------------
  \setcounter{footnote}{0}\let\maketitleii\relax\let\@maketitleii\relax
  % Fim do comentário -------------------
  \gdef\@thanks{}
  % v1.6b do not clear these as we will need the title again for peer review papers
  % \gdef\@author{}\gdef\@title{}%
  \let\thanks\relax}


% formats the Title, authors names, affiliations and special paper notice
% THIS IS A CONTROLLED SPACING COMMAND! Do not allow blank lines or unintentional
% spaces to enter the definition - use % at the end of each line
\def\@maketitleii{%\newpage
\begin{center}%
\if@technote%
   {\bfseries\large\@title\par}\vskip 1.3em{\lineskip .5em\@author\@specialpapernotice\par}%
\else% not a technote
   \vskip0.2em{\Huge\@title\par}\vskip1.0em\par%
   % V1.6 handle \author differently if in conference mode
   \if@confmode%
      {\@specialpapernotice\mbox{}\vskip\@SCIauthorblockconfadjspace%
      \mbox{}\hfill\begin{@SCIauthorhalign}\@author\end{@SCIauthorhalign}\hfill\mbox{}\par}%
   \else% peerreviewca, peerreview or journal
      \if@peerreviewcaoption
         % peerreviewca handles author names just like conference mode
         {\@specialpapernotice\mbox{}\vskip\@SCIauthorblockconfadjspace%
         \mbox{}\hfill\begin{@SCIauthorhalign}\@author\end{@SCIauthorhalign}\hfill\mbox{}\par}%
      \else % journal or peerreview
         {\lineskip.5em\sublargesize\@author\@specialpapernotice\par}%
      \fi
   \fi
\fi
\end{center}}
%===============================================














% V1.6b define the \SCIpeerreviewmaketitle as needed
\if@peerreviewoption
\def\SCIpeerreviewmaketitle{\@SCIcleardoublepage{empty}%
\if@twocolumnmode
\twocolumn[\@SCIpeerreviewmaketitle\@SCIdynamictitlevspace]
\else
\newpage\@SCIpeerreviewmaketitle\@SCIstatictitlevskip
\fi
\thispagestyle{titlepagestyle}}
\else
% \SCIpeerreviewmaketitle does nothing if peer review option has not been selected
\def\SCIpeerreviewmaketitle{\relax}
\fi

% peerreview formats the repeated title like the title in journal papers.
\def\@SCIpeerreviewmaketitle{\begin{center}%
\normalfont\normalsize\vskip0.2em{\Huge\@title\par}\vskip1.0em\par
\end{center}}



% V1.6
% this is a static rubber spacer between the title/authors and the main text
% used for single column text, or when the title appears in the first column
% of two column text (technotes).
\def\@SCIstatictitlevskip{{\normalfont\normalsize
% adjust spacing to next text
% v1.6b handle peer review papers
\if@peerreviewoption
% for peer review papers, the same value is used for both title pages
% regardless of the other paper modes
   \vskip 1\baselineskip plus 0.375\baselineskip minus 0.1875\baselineskip
\else
   \if@confmode% conference
      \vskip 1\baselineskip plus 0.375\baselineskip minus 0.1875\baselineskip%
   \else%
      \if@technote% technote
         \vskip 1\baselineskip plus 0.375\baselineskip minus 0.1875\baselineskip%
      \else% journal uses more space
         \vskip 2.5\baselineskip plus 0.75\baselineskip minus 0.375\baselineskip%
      \fi
   \fi
\fi}}


% V1.6
% This is a dynamically determined rigid spacer between the title/authors
% and the main text. This is used only for single column titles over two
% column text (most common)
% This is bit tricky because we have to ensure that the textheight of the
% main text is an integer multiple of \baselineskip
% otherwise underfull vbox problems may develop in the second column of the
% text on the titlepage
% The possible use of \pubid must also be taken into account.
\def\@SCIdynamictitlevspace{{%
    % we run within a group so that all the macros can be forgotten when we are done
    \def\thanks##1{\relax}%don't allow \thanks to run when we evaluate the vbox height
    \normalfont\normalsize% we declare more descriptive variable names
    \let\@maintextheight=\@SCIndustriatmpdimenA%height of the main text columns
    \let\@INTmaintextheight=\@SCIndustriatmpdimenB%height of the main text columns with integer # lines
    % set the nominal and minimum values for the title spacer
    % the dynamic algorithm will not allow the spacer size to
    % become less than \@MINtitlevspace - instead it will be
    % lengthened
    % default to journal values
    \def\@NORMtitlevspace{2.5\baselineskip}%
    \def\@MINtitlevspace{2\baselineskip}%
    % conferences and technotes need tighter spacing
    \if@confmode%conference
     \def\@NORMtitlevspace{1\baselineskip}%
     \def\@MINtitlevspace{0.75\baselineskip}%
    \fi
    \if@technote%technote
      \def\@NORMtitlevspace{1\baselineskip}%
      \def\@MINtitlevspace{0.75\baselineskip}%
    \fi%
    % get the height that the title will take up
    \if@peerreviewoption
       \settoheight{\@maintextheight}{\vbox{\hsize\textwidth \@SCIpeerreviewmaketitle}}%
    \else
       \settoheight{\@maintextheight}{\vbox{\hsize\textwidth \@maketitle}}%
    \fi
    \@maintextheight=-\@maintextheight% title takes away from maintext, so reverse sign
    % add the height of the page textheight
    \advance\@maintextheight by \textheight%
    % correct for title pages using pubid
    \if@peerreviewoption\else
       % peerreview papers use the pubid on the cover page only.
       % And the cover page uses a static spacer.
       \if@SCIusingpubid\advance\@maintextheight by -\@pubidpullup\fi
    \fi%
    % subtract off the nominal value of the title bottom spacer
    \advance\@maintextheight by -\@NORMtitlevspace%
    % \topskip takes away some too
    \advance\@maintextheight by -\topskip%
    % calculate the column height of the main text for lines
    % now we calculate the main text height as if holding
    % an integer number of \normalsize lines after the first
    % and discard any excess fractional remainder
    % we subtracted the first line, because the first line
    % is placed \topskip into the maintext, not \baselineskip like the
    % rest of the lines.
    \@INTmaintextheight=\@maintextheight%
    \divide\@INTmaintextheight  by \baselineskip%
    \multiply\@INTmaintextheight  by \baselineskip%
    % now we calculate how much the title spacer height will
    % have to be reduced from nominal (\@REDUCEmaintextheight is always
    % a positive value) so that the maintext area will contain an integer
    % number of normal size lines
    % we change variable names here (to avoid confusion) as we no longer
    % need \@INTmaintextheight and can reuse its dimen register
    \let\@REDUCEmaintextheight=\@INTmaintextheight%
    \advance\@REDUCEmaintextheight by -\@maintextheight%
    \advance\@REDUCEmaintextheight by \baselineskip%
    % this is the calculated height of the spacer
    % we change variable names here (to avoid confusion) as we no longer
    % need \@maintextheight and can reuse its dimen register
    \let\@COMPENSATElen=\@maintextheight%
    \@COMPENSATElen=\@NORMtitlevspace% set the nominal value
    % we go with the reduced length if it is smaller than an increase
    \ifdim\@REDUCEmaintextheight < 0.5\baselineskip\relax%
     \advance\@COMPENSATElen by -\@REDUCEmaintextheight%
     % if the resulting spacer is too small back out and go with an increase instead
     \ifdim\@COMPENSATElen<\@MINtitlevspace\relax%
      \advance\@COMPENSATElen by \baselineskip%
     \fi%
    \else%
     % go with an increase because it is closer to the nominal than a decrease
     \advance\@COMPENSATElen by -\@REDUCEmaintextheight%
     \advance\@COMPENSATElen by \baselineskip%
    \fi%
    % set the calculated rigid spacer
    \vspace{\@COMPENSATElen}}}



% V1.6
% we allow the user access to the last part of the title area
% useful in emergencies such as when a different spacing is needed
% This text is NOT compensated for in the dynamic sizer.
\let\@SCIaftertitletext=\relax
\def\SCIaftertitletext#1{\def\@SCIaftertitletext{#1}}


% V1.6 have abstract and keywords strip leading spaces, pars and newlines
% so that spacing is more tightly controlled.
\def\abstract{\normalfont%
    \if@twocolumn%
      \@SCIabskeysecsize\bfseries\textit{Abstract}---\,%
    \else%
      \begin{center}\vspace{-1.78ex}\@SCIabskeysecsize\textbf{Abstract}\end{center}\quotation\@SCIabskeysecsize%
    \fi\@SCIgobbleleadPARNLSP}
% V1.6 SCI wants only 1 pica from end of abstract to introduction heading when in
% conference mode (the heading already has this much above it)
\def\endabstract{\relax\if@confmode\vspace{0ex}\else\vspace{1.34ex}\fi\par\if@twocolumn\else\endquotation\fi%
    \normalfont\normalsize}

\def\resumo{\normalfont%
    \if@twocolumn%
      \@SCIabskeysecsize\bfseries\textit{Resumo}---\,%
    \else%
      \begin{center}\vspace{-1.78ex}\@SCIabskeysecsize\textbf{Resumo}\end{center}\quotation\@SCIabskeysecsize%
    \fi\@SCIgobbleleadPARNLSP}
% V1.6 SCI wants only 1 pica from end of abstract to introduction heading when in
% conference mode (the heading already has this much above it)
\def\endresumo{\relax\if@confmode\vspace{0ex}\else\vspace{1.34ex}\fi\par\if@twocolumn\else\endquotation\fi%
    \normalfont\normalsize}


\def\keywords{\normalfont%
    % SCI uses the term (in bold italics) "Index Terms" now.
    \if@twocolumn%
      \@SCIabskeysecsize\bfseries\textit{Index Terms}---\,\relax%
    \else%
      \begin{center}\@SCIabskeysecsize\bfseries Index Terms\end{center}\quotation\@SCIabskeysecsize%
    \fi\@SCIgobbleleadPARNLSP}
\def\endkeywords{\relax\if@technote\vspace{1.34ex}\else\vspace{0.67ex}\fi%
    \par\if@twocolumn\else\endquotation\fi%
    \normalsize\normalfont}


% gobbles all leading \, \\ and \par, upon finding first token that
% is not a \ , \\ or a \par, it ceases and returns that token
%
% used to strip leading \, \\ and \par from the input
% so that such things in the beginning of an environment will not
% affect the formatting of the text
\long\def\@SCIgobbleleadPARNLSP#1{\let\@SCIswallowthistoken=0%
\let\@SCIgobbleleadPARNLSPtoken#1%
\let\@SCIgobbleleadPARtoken=\par%
\let\@SCIgobbleleadNLtoken=\\%
\let\@SCIgobbleleadSPtoken=\ %
\def\@SCIgobbleleadSPMACRO{\ }%
\ifx\@SCIgobbleleadPARNLSPtoken\@SCIgobbleleadPARtoken%
\let\@SCIswallowthistoken=1%
\fi%
\ifx\@SCIgobbleleadPARNLSPtoken\@SCIgobbleleadNLtoken%
\let\@SCIswallowthistoken=1%
\fi%
\ifx\@SCIgobbleleadPARNLSPtoken\@SCIgobbleleadSPtoken%
\let\@SCIswallowthistoken=1%
\fi%
% a control space will come in as a macro
% when it is the last one on a line
\ifx\@SCIgobbleleadPARNLSPtoken\@SCIgobbleleadSPMACRO%
\let\@SCIswallowthistoken=1%
\fi%
% if we have to swallow this token, do so and taste the next one
% else spit it out and stop gobbling
\ifx\@SCIswallowthistoken 1\let\@SCInextgobbleleadPARNLSP=\@SCIgobbleleadPARNLSP\else%
\let\@SCInextgobbleleadPARNLSP=#1\fi%
\@SCInextgobbleleadPARNLSP}%




% TITLING OF SECTIONS
\def\@SCIsectpunct{:\ \,}  % Punctuation after run-in section heading  (headings which are
                            % part of the paragraphs), need little bit more than a space

\def\@seccntformat#1{\csname the#1dis\endcsname\hskip 0.5em\relax}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth%
     \def\@svsec{}%
  \else%
     \refstepcounter{#1}
     % load section label and spacer into \@svsec
     \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi%
  \@tempskipa #5\relax%
  \ifdim \@tempskipa>\z@% tempskipa determines whether is treated as a high
     \begingroup #6\relax% or low level heading
      \noindent % subsections are NOT indented
       % print top level headings. \@svsec is label, #8 is heading title
       %\@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}
       % SCI does not block indent the section title text, it flows like normal
       \relax{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}%
     \endgroup%
     % got rid of sectionmark stuff
     % \csname #1mark\endcsname{#7}
     \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth\relax\else%
               \protect\numberline{\csname the#1\endcsname}\fi#7}%
  \else % printout low level headings
     % svsechd seems to swallow the trailing space, protect it with \mbox{}
     % got rid of sectionmark stuff
     \def\@svsechd{#6\hskip #3\@svsec #8\@SCIsectpunct\mbox{}%\csname #1mark\endcsname{#7}
     \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth\relax\else%
               \protect\numberline{\csname the#1\endcsname}\fi#7}}
  \fi%skip down
  \@xsect{#5}}

% section* handler
\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax%
  \ifdim \@tempskipa>\z@%
     %\begingroup #4\@hangfrom{\hskip #1}{\interlinepenalty \@M #5\par}\endgroup
     % SCI does not block indent the section title text, it flows like normal
     \begingroup \noindent #4\relax{\hskip #1}{\interlinepenalty \@M #5\par}\endgroup%
  % svsechd swallows the trailing space, protect it with \mbox{}
  \else \def\@svsechd{#4\hskip #1\relax #5\@SCIsectpunct\mbox{}}\fi%
  \@xsect{#3}}


%% SECTION heading spacing and font
%%
% arguments are: #1 - sectiontype name
% (for \@sect)   #2 - section level
%                #3 - section heading indent
%                #4 - top separation (absolute value used, neg indicates not to indent main text)
%                     If negative, make stretch parts negative too!
%                #5 - (absolute value used) positive: bottom separation after heading,
%                      negative: amount to indent main text after heading
%                Both #4 and #5 negative means to indent main text and use negative top separation
%                #6 - font control
% You've got to have \normalfont\normalsize in the font specs below to prevent
% trouble when you do something like:
% \section{Note}{\ttfamily TT-TEXT} is known to ...
% SCI sometimes REALLY stretches the area before a section
% heading by up to about 0.5in. However, it may not be a good
% idea to let LaTeX have quite this much rubber.
\if@confmode%
% SCI wants section heading spacing to decrease for conference mode
\def\section{\@startsection{section}{1}{\z@}{1.5ex plus 1.5ex minus 0.5ex}%
{0.7ex plus 1ex minus 0ex}{\normalfont\normalsize\centering\scshape}}%
\def\subsection{\@startsection{subsection}{2}{\z@}{1.5ex plus 1.5ex minus 0.5ex}%
{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\itshape}}%
\else % for journals
\def\section{\@startsection{section}{1}{\z@}{3.0ex plus 1.5ex minus 1.5ex}% V1.6 3.0ex from 3.5ex
{0.7ex plus 1ex minus 0ex}{\normalfont\normalsize\centering\scshape}}%
\def\subsection{\@startsection{subsection}{2}{\z@}{3.5ex plus 1.5ex minus 1.5ex}%
{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\itshape}}%
\fi
% decided to put in a little rubber above the section, might help somebody
\def\subsubsection{\@startsection{subsubsection}{3}{\parindent}{0ex plus 0.1ex minus 0.1ex}%
{0ex}{\normalfont\normalsize\itshape}}%
\def\paragraph{\@startsection{paragraph}{4}{2\parindent}{0ex plus 0.1ex minus 0.1ex}%
{0ex}{\normalfont\normalsize\itshape}}%



%% ENVIRONMENTS
% "box" symbols at end of proofs
\def\QEDclosed{\mbox{\rule[0pt]{1.3ex}{1.3ex}}} % for a filled box
% V1.6 some journals use an open box instead that will just fit around a closed one
\def\QEDopen{{\setlength{\fboxsep}{0pt}\setlength{\fboxrule}{0.2pt}\fbox{\rule[0pt]{0pt}{1.3ex}\rule[0pt]{1.3ex}{0pt}}}}
\def\QED{\QEDclosed} % default to closed

\def\proof{\noindent\hspace{2em}{\itshape Proof: }}
\def\endproof{\hspace*{\fill}~\QED\par\endtrivlist\unskip}
%\itemindent is set to \z@ by list, so define new temporary variable
\newdimen\@SCItmpitemindent
\def\@begintheorem#1#2{\@SCItmpitemindent\itemindent\topsep 0pt\rmfamily\trivlist%
    \item[\hskip \labelsep{\indent\itshape #1\ #2:}]\itemindent\@SCItmpitemindent}
\def\@opargbegintheorem#1#2#3{\@SCItmpitemindent\itemindent\topsep 0pt\rmfamily \trivlist%
% V1.6 SCI is back to using () around theorem names which are also in italics
% Thanks to Christian Peel for reporting this.
    \item[\hskip\labelsep{\indent\itshape #1\ #2\ (#3):}]\itemindent\@SCItmpitemindent}
\def\@endtheorem{\endtrivlist\unskip}

% V1.6
% display command for the section the theorem is in - so that \thesection
% is not used as this will be in Roman numerals when we want arabic.
% LaTeX2e uses \def\@thmcounter#1{\noexpand\arabic{#1}} for the theorem number
% (second part) display and \def\@thmcountersep{.} as a separator.
\def\@SCIthmcounterin#1{\arabic{#1}}
% redefine the #1#2[#3] form of newtheorem to use a hook to \@SCIthmcounterin
\def\@xnthm#1#2[#3]{%
  \expandafter\@ifdefinable\csname #1\endcsname
    {\@definecounter{#1}\@newctr{#1}[#3]%
     \expandafter\xdef\csname the#1\endcsname{%
     \noexpand\@SCIthmcounterin{#3}\@thmcountersep\@thmcounter{#1}}%
     \global\@namedef{#1}{\@thm{#1}{#2}}%
     \global\@namedef{end#1}{\@endtheorem}}}



%% SET UP THE DEFAULT PAGESTYLE
\ps@headings
\pagenumbering{arabic}

% normally the page counter starts at 1
\setcounter{page}{1}
% however, for peerreview the cover sheet is page 0 or page -1
% (for duplex printing)
\if@peerreviewoption
   \if@twoside
      \setcounter{page}{-1}
   \else
      \setcounter{page}{0}
   \fi
\fi

% standard book class behavior - let bottom line float up and down as
% needed when single sided
\if@twoside\else\raggedbottom\fi
% if two column - turn on twocolumn, allow word spacings to stretch more and
% enforce a rigid position for the last lines
\if@twocolumnmode
% the peer review option delays invoking twocolumn
   \if@peerreviewoption\else
      \twocolumn
   \fi
\sloppy
\flushbottom
\fi




% \APPENDIX and \APPENDICES definitions

% This is the \@ifmtarg command from the LaTeX ifmtarg package
% by Peter Wilson (CUA) and Donald Arseneau
% \@ifmtarg is used to determine if an argument to a command
% is present or not.
% For instance:
% \@ifmtarg{#1}{\typeout{empty}}{\typeout{has something}}
% \@ifmtarg is used with our redefined \section command if
% \appendices is invoked.
% The command \section will behave slightly differently depending
% on whether the user specifies a title:
% \section{My appendix title}
% or not:
% \section{}
% This way, we can eliminate the blank lines where the title
% would be, and the unneeded : after Appendix in the table of
% contents
\begingroup
\catcode`\Q=3
\long\gdef\@ifmtarg#1{\@xifmtarg#1QQ\@secondoftwo\@firstoftwo\@nil}
\long\gdef\@xifmtarg#1#2Q#3#4#5\@nil{#4}
\endgroup
% end of \@ifmtarg defs

% save the "original" meaning of \section so we can redefine
% \section after a call to \appendix or \appendices
\let\@SCIappendixsavesection\section

% neat trick to grab and process the argument from \section{argument}
% we process differently if the user invoked \section{} with no
% argument (title)
% note we reroute the call to the old \section*
\def\@SCIprocessthesectionargument#1{%
\@ifmtarg{#1}{%
\@SCIappendixsavesection*{Appendix \thesectiondis}%
\addcontentsline{toc}{section}{Appendix \thesection}}{%
\@SCIappendixsavesection*{Appendix \thesectiondis \\* #1}%
\addcontentsline{toc}{section}{Appendix \thesection: #1}}}

% we use this if the user calls \section{} after
% \appendix-- which has no meaning. So, we ignore the
% command and its argument. Then, warn the user.
\def\@SCIdestroythesectionargument#1{\typeout{** WARNING: Ignoring useless
\protect\section\space in Appendix (line \the\inputlineno).}}


% remember \thesection forms will be displayed in \ref calls
% and in the Table of Contents.
% The \sectiondis form is used in the actual heading itself

% appendix command for one single appendix
% normally has no heading. However, if you want a
% heading, you can do so via the optional argument:
% \appendix[Optional Heading]
\def\appendix{\relax}
\renewcommand{\appendix}[1][]{\par%
    % v1.6 keep hyperref's identifiers unique
    \def\theHsection{Appendix.A}%
    % v1.6 adjust hyperref's string name for the section
    \xdef\Hy@chapapp{appendix}%
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \setcounter{paragraph}{0}%
    \def\thesection{}%
    \def\thesectiondis{}%
    \def\thesubsection{\Alph{subsection}}%
    \refstepcounter{section}% update the \ref counter
    \@ifmtarg{#1}{\@SCIappendixsavesection*{Appendix}%
                  \addcontentsline{toc}{section}{Appendix}}{%
             \@SCIappendixsavesection*{Appendix \\* #1}%
             \addcontentsline{toc}{section}{Appendix: #1}}%
    % redefine \section command for appendix
    % leave \section* as is
    \def\section{\@ifstar{\@SCIappendixsavesection*}{%
                    \@SCIdestroythesectionargument}}% throw out the argument
                                                     % of the normal form
}


% provides the user a way to choose between
% Appendix A
%    and
% Appendix I
% notation
% defaults to Roman.
\newif\ifuseRomanappendices
\useRomanappendicestrue


% appendices command for multiple appendices
% user then calls \section with an argument (possibly empty) to
% declare the individual appendices
\def\appendices{\par%
    % v1.6 keep hyperref's identifiers unique
    \def\theHsection{Appendix.\Alph{section}}%
    % v1.6 adjust hyperref's string name for the section
    \xdef\Hy@chapapp{appendix}%
    \setcounter{section}{-1}% we want \refstepcounter to use section 0
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \setcounter{paragraph}{0}%
    \ifuseRomanappendices%
    \def\thesection{\Roman{section}}%
    \def\thesectiondis{\Roman{section}}%
    \else%
    \def\thesection{\Alph{section}}%
    \def\thesectiondis{\Alph{section}}%
    \fi%
    \refstepcounter{section}% update the \ref counter
    \setcounter{section}{0}% NEXT \section will be the FIRST appendix
    % redefine \section command for appendices
    % leave \section* as is
    \def\section{\@ifstar{\@SCIappendixsavesection*}{% process the *-form
                    \refstepcounter{section}% or is a new section so,
                    \@SCIprocessthesectionargument}}% process the argument
                                                 % of the normal form
}



% \PARstart
% Definition for the big two line drop cap letter at the beginning of the
% first paragraph of journal papers. The first argument is the first letter
% of the first word, the second argument is the remaining letters of the
% first word which will be rendered in upper case.
% In V1.6 this has been completely rewritten to:
%
% 1. no longer have problems when the user begins an environment
%    within the paragraph that uses \PARstart.
% 2. auto-detect and use the current font family
% 3. revise handling of the space at the end of the first word so that
%    interword glue will now work as normal.
% 4. produce correctly aligned edges for the (two) indented lines.
%
% We generalize things via control macros - playing with these is fun too.
%
% the number of lines that are indented to clear it
\def\@SCIPARstartDROPLINES{2}
% minimum number of lines left on a page to allow a \@PARstart
% Does not take into consideration rubber shrink, so it tends to
% be overly cautious
\def\@SCIPARstartMINPAGELINES{2}
% the depth the letter is lowered below the baseline
% the height (and size) of the letter is determined by the sum
% of this value and the height of a capital "T" in the current
% font. It is a good idea to set this value in terms of the baselineskip
% so that it can respond to changes therein.
\def\@SCIPARstartDROPDEPTH{1.1\baselineskip}
% This is the separation distance from the drop letter to the main text.
% Lengths that depend on the font (i.e., ex, em, etc.) will be referenced
% to the font that is active when PARstart is called.
\def\@SCIPARstartSEP{0.15em}


% definition of \PARstart
% THIS IS A CONTROLLED SPACING AREA, DO NOT ALLOW SPACES WITHIN THESE LINES
%
% The token \@SCIPARstartfont will be globally defined after the first use
% of \PARstart and will be a font command which creates the big letter
% The first argument is the first letter of the first word and the second
% argument is the rest of the first word(s).
\def\PARstart#1#2{\par{%
% if this page does not have enough space, break it and lets start
% on a new one
\@SCIndustrianeedspace{\@SCIPARstartMINPAGELINES\baselineskip}{\relax}%
% calculate the desired height of the big letter
% it extends from the top of a capital "T" in the current font
% down to \@SCIPARstartDROPDEPTH below the current baseline
\settoheight{\@SCIndustriatmpdimenA}{T}%
\addtolength{\@SCIndustriatmpdimenA}{\@SCIPARstartDROPDEPTH}%
% extract the name of the current font in bold
% and place it in \@SCIPARstartFONTNAME
\def\@SCIPARstartGETFIRSTWORD##1 ##2\relax{##1}%
{\bfseries%
\edef\@SCIPARstartFONTNAMESPACE{\fontname\font\space}%
\xdef\@SCIPARstartFONTNAME{\expandafter\@SCIPARstartGETFIRSTWORD\@SCIPARstartFONTNAMESPACE\relax}}%
% define a font based on this name with a point size equal to the desired
% height of the drop letter
\font\@SCIPARstartsubfont\@SCIPARstartFONTNAME\space at \@SCIndustriatmpdimenA\relax%
% save this value as a counter (integer) value (sp points)
\@SCIndustriatmpcountA=\@SCIndustriatmpdimenA%
% now get the height of the actual letter produced by this font size
\settoheight{\@SCIndustriatmpdimenB}{\@SCIPARstartsubfont\MakeUppercase{#1}}%
% If something bogus happens like the first argument is empty or the
% current font is strange, do not allow a zero height.
\ifdim\@SCIndustriatmpdimenB=0pt\relax%
\typeout{** WARNING: PARstart drop letter has zero height! (line \the\inputlineno)}%
\typeout{ Forcing the drop letter font size to 10pt.}%
\@SCIndustriatmpdimenB=10pt%
\fi%
% and store it as a counter
\@SCIndustriatmpcountB=\@SCIndustriatmpdimenB%
% Since a font size doesn't exactly correspond to the height of the capital
% letters in that font, the actual height of the letter, \@SCIndustriatmpcountB,
% will be less than that desired, \@SCIndustriatmpcountA
% we need to raise the font size, \@SCIndustriatmpdimenA
% by \@SCIndustriatmpcountA / \@SCIndustriatmpcountB
% But, TeX doesn't have floating point division, so we have to use integer
% division. Hence the use of the counters.
% We need to reduce the denominator so that the loss of the remainder will
% have minimal affect on the accuracy of the result
\divide\@SCIndustriatmpcountB by 200%
\divide\@SCIndustriatmpcountA by \@SCIndustriatmpcountB%
% Then reequalize things when we use TeX's ability to multiply by
% floating point values
\@SCIndustriatmpdimenB=0.005\@SCIndustriatmpdimenA%
\multiply\@SCIndustriatmpdimenB by \@SCIndustriatmpcountA%
% \@SCIPARstartfont is globaly set to the calculated font of the big letter
% We need to carry this out of the local calculation area to to create the
% big letter.
\global\font\@SCIPARstartfont\@SCIPARstartFONTNAME\space at \@SCIndustriatmpdimenB%
% Now set \@SCIndustriatmpdimenA to the width of the big letter
% We need to carry this out of the local calculation area to set the
% hanging indent
\settowidth{\global\@SCIndustriatmpdimenA}{\@SCIPARstartfont\MakeUppercase{#1}}}%
% end of the isolated calculation environment
% add in the extra clearance we want
\advance\@SCIndustriatmpdimenA by \@SCIPARstartSEP%
% \@SCIndustriatmpdimenA has the width of the big letter plus the
% separation space and \@SCIPARstartfont is the font we need to use
% Now, we make the letter and issue the hanging indent command
% The letter is placed in a box of zero width and height so that other
% text won't be displaced by it.
\noindent\hangindent\@SCIndustriatmpdimenA\hangafter=-\@SCIPARstartDROPLINES%
\makebox[0pt][l]{\hspace{-\@SCIndustriatmpdimenA}\raisebox{-\@SCIPARstartDROPDEPTH}[0pt][0pt]{\@SCIPARstartfont\MakeUppercase{#1}}}\MakeUppercase{#2}}


% V1.6 \CMPARstart is no longer needed as \PARstart now uses whatever
% the current font family is.
% \CMPARstart is provided here for backward compatability.
\let\CMPARstart=\PARstart



% determines if the space remaining on a given page is equal to or greater
% than the specified space of argument one
% if not, execute argument two (only if the remaining space is greater than zero)
% and issue a \newpage
%
% example: \@SCIndustrianeedspace{2in}{\vfill}
%
% Does not take into consideration rubber shrinkage, so it tends to
% be overly cautious
% Based on an example posted by Donald Arseneau
% Note this macro uses \@SCIndustriatmpdimenB internally for calculations,
% so DO NOT PASS \@SCIndustriatmpdimenB to this routine
% if you need a dimen register, import with \@SCIndustriatmpdimenA instead
\def\@SCIndustrianeedspace#1#2{\penalty-100\begingroup%shield temp variable
\@SCIndustriatmpdimenB\pagegoal\advance\@SCIndustriatmpdimenB-\pagetotal% space left
\ifdim #1>\@SCIndustriatmpdimenB\relax% not enough space left
\ifdim\@SCIndustriatmpdimenB>\z@\relax #2\fi%
\newpage%
\fi\endgroup}



% BIOGRAPHY ENVIRONMENT
% Allows user to enter BIOGRAPHY leaving place for picture (adapts to font size)
% As of V1.5, a new optional argument allows you to have a real graphic!
% V1.5 and later also fixes the "colliding biographies" which could happen when a
% biography's text was shorter than the space for the photo.
% MDS 7/2001
% V1.6 prevent multiple biographies from making multiple TOC entries
\newif\if@biographyTOCentrynotmade
\global\@biographyTOCentrynotmadetrue

% biography counter so hyperref can jump directly to the biographies
% and not just the previous section
\newcounter{biography}
\setcounter{biography}{0}

% photo area size
\def\@SCIBIOphotowidth{1.0in}    % width of the biography photo area
\def\@SCIBIOphotodepth{1.25in}   % depth (height) of the biography photo area
% area cleared for photo
\def\@SCIBIOhangwidth{1.14in}    % width cleared for the biography photo area
\def\@SCIBIOhangdepth{1.25in}    % depth cleared for the biography photo area
                                  % actual depth will be a multiple of
                                  % \baselineskip, rounded up
\def\@SCIBIOskipN{4\baselineskip}% nominal value of the vskip above the biography

\newenvironment{biography}[2][]{\normalfont\footnotesize%
\unitlength 1in\parskip=0pt\par\parindent 1em\interlinepenalty500%
% we need enough space to support the hanging indent
% the nominal value of the spacer
% and one extra line for good measure
\@SCIndustriatmpdimenA=\@SCIBIOhangdepth%
\advance\@SCIndustriatmpdimenA by \@SCIBIOskipN%
\advance\@SCIndustriatmpdimenA by 1\baselineskip%
% if this page does not have enough space, break it and lets start
% with a new one
\@SCIndustrianeedspace{\@SCIndustriatmpdimenA}{\relax}%
% nominal spacer can strech, not shrink use 1fil so user can out stretch with \vfill
\vskip \@SCIBIOskipN plus 1fil minus 0\baselineskip%
% the default box for where the photo goes
\def\@SCItempbiographybox{{\setlength{\fboxsep}{0pt}\framebox{\begin{minipage}[b][\@SCIBIOphotodepth][c]{\@SCIBIOphotowidth}\centering PLACE\\ PHOTO\\ HERE \end{minipage}}}}%
%
% detect if the optional argument was supplied, this requires the
% \@ifmtarg command as defined in the appendix section above
% and if so, override the default box with what they want
\@ifmtarg{#1}{\relax}{\def\@SCItempbiographybox{\mbox{\begin{minipage}[b][\@SCIBIOphotodepth][c]{\@SCIBIOphotowidth}%
\centering%
#1%
\end{minipage}}}}% end if optional argument supplied
% Make an entry into the table of contents only if we have not done so before
\if@biographyTOCentrynotmade%
% link labels to the biography counter so hyperref will jump
% to the biography, not the previous section
\setcounter{biography}{-1}%
\refstepcounter{biography}%
\addcontentsline{toc}{section}{Biographies}%
\global\@biographyTOCentrynotmadefalse%
\fi%
% one more biography
\refstepcounter{biography}%
% Make an entry for this name into the table of contents
\addcontentsline{toc}{subsection}{#2}%
% V1.6 properly handle if a new paragraph should occur while the
% hanging indent is still active. Do this by redefining \par so
% that it will not start a new paragraph. (But it will appear to the
% user as if it did.) Also, strip any leading pars, newlines, or spaces.
\let\@SCIBIOORGparCMD=\par% save the original \par command
\edef\par{\hfil\break\indent}% the new \par will not be a "real" \par
\settoheight{\@SCIndustriatmpdimenA}{\@SCItempbiographybox}% get height of biography box
\@SCIndustriatmpdimenB=\@SCIBIOhangdepth%
\@SCIndustriatmpcountA=\@SCIndustriatmpdimenB% countA has the hang depth
\divide\@SCIndustriatmpcountA by \baselineskip%  calculates lines needed to produce the hang depth
\advance\@SCIndustriatmpcountA by 1% ensure we overestimate
% set the hanging indent
\hangindent\@SCIBIOhangwidth%
\hangafter-\@SCIndustriatmpcountA%
% reference the top of the photo area to the top of a capital T
\settoheight{\@SCIndustriatmpdimenB}{\mbox{T}}%
% set the photo box, give it zero width and height so as not to disturb anything
\noindent\makebox[0pt][l]{\hspace{-\@SCIBIOhangwidth}\raisebox{\@SCIndustriatmpdimenB}[0pt][0pt]{\raisebox{-\@SCIBIOphotodepth}[0pt][0pt]{\@SCItempbiographybox}}}%
% now place the author name and begin the bio text
\noindent\textbf{#2\ }\@SCIgobbleleadPARNLSP}{\relax\let\par=\@SCIBIOORGparCMD\par%
% 7/2001 V1.5 detect when the biography text is shorter than the photo area
% and pad the unused area - preventing a collision from the next biography entry
% MDS
\ifnum \prevgraf <\@SCIndustriatmpcountA\relax% detect when the biography text is shorter than the photo
    \advance\@SCIndustriatmpcountA by -\prevgraf% calculate how many lines we need to pad
    \advance\@SCIndustriatmpcountA by -1\relax% we compensate for the fact that we indented an extra line
    \@SCIndustriatmpdimenA=\baselineskip% calculate the length of the padding
    \multiply\@SCIndustriatmpdimenA by \@SCIndustriatmpcountA%
    \noindent\rule{0pt}{\@SCIndustriatmpdimenA}% insert an invisible support strut
\fi%
\par\normalfont}



% V1.6
% added biography without a photo environment
\newenvironment{biographynophoto}[1]{%
% Make an entry into the table of contents only if we have not done so before
\if@biographyTOCentrynotmade%
% link labels to the biography counter so hyperref will jump
% to the biography, not the previous section
\setcounter{biography}{-1}%
\refstepcounter{biography}%
\addcontentsline{toc}{section}{Biographies}%
\global\@biographyTOCentrynotmadefalse%
\fi%
% one more biography
\refstepcounter{biography}%
% Make an entry for this name into the table of contents
\addcontentsline{toc}{subsection}{#1}%
\normalfont\footnotesize\interlinepenalty500%
\vskip 4\baselineskip plus 1fil minus 0\baselineskip%
\parskip=0pt\par%
\noindent\textbf{#1\ }\@SCIgobbleleadPARNLSP}{\relax\par\normalfont}


% provide the user with some old font commands
% got this from article.cls
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}


% SPECIAL PAPER NOTICE COMMANDS
%
% holds the special notice text
\def\@specialpapernotice{\relax}

% for special papers, like invited papers, the user can do:
% \specialpapernotice{(Invited Paper)} before \maketitle
\def\specialpapernotice#1{\if@confmode%
\def\@specialpapernotice{{\sublargesize\textit{#1}\vspace*{1em}}}%
\else%
\def\@specialpapernotice{{\\*[1.5ex]\sublargesize\textit{#1}}\vspace*{-2ex}}%
\fi}




% PUBLISHER ID COMMANDS
% to insert a publisher's ID footer
% V1.6 \pubid has been changed so that the change in page size and style
% occurs in \maketitle. \pubid must now be issued prior to \maketitle
% use \pubidadjcol as before - in the second column of the title page
% These changes allow \maketitle to take the reduced page height into
% consideration when dynamically setting the space between the author
% names and the maintext.
%
% the amount the main text is pulled up to make room for the
% publisher's ID footer
% SCI uses about 1.3\baselineskip for journals,
% dynamic title spacing will clean up the fraction
\def\@pubidpullup{1.3\baselineskip}
\if@technote
% for technotes it must be an integer of baselineskip as there can be no
% dynamic title spacing for two column mode technotes (the title is in the
% in first column) and we should maintain an integer number of lines in the
% second column
% There are some examples (such as older issues of "Transactions on
% Information Theory") in which SCI really pulls the text off the ID for
% technotes - about 0.55in (or 4\baselineskip). We'll use 2\baselineskip
% and call it even.
\def\@pubidpullup{2\baselineskip}
\fi

% holds the ID text
\def\@pubid{\relax}

% flag so \maketitle can tell if \pubid was called
\newif\if@SCIusingpubid
\global\@SCIusingpubidfalse
% issue this command in the page to have the ID at the bottom
% V1.6 use before \maketitle
\def\pubid#1{\def\@pubid{#1} \global\@SCIusingpubidtrue}


% command which will pull up (shorten) the column it is executed in
% to make room for the publisher ID. Place in the second column of
% the title page when using \pubid
% Is smart enough not to do anything when in single column text or
% if the user hasn't called \pubid
% currently needed in for the second column of a page with the
% publisher ID. If not needed in future releases, please provide this
% command and define it as \relax for backward compatibility
% v1.6b do not allow command to operate if the peer review option has been
% selected because \pubidadjcol will not be on the cover page.
\def\pubidadjcol{\if@peerreviewoption\else\if@twocolumn\if@SCIusingpubid\enlargethispage{-\@pubidpullup}\fi\fi\fi}

% Special thanks to Peter Wilson, Daniel Luecking, and the other
% gurus at comp.text.tex, for helping me to understand how best to
% implement the pubid command in LaTeX.



%% Lockout some commands under various conditions

% general purpose bit bucket
\newsavebox{\@SCIndustriarubishbin}

% flags to prevent multiple warning messages
\newif\if@SCIWARNthanks
\newif\if@SCIWARNPARstart
\newif\if@SCIWARNCMPARstart
\newif\if@SCIWARNkeywords
\newif\if@SCIWARNbiography
\newif\if@SCIWARNbiographynophoto
\newif\if@SCIWARNpubid
\newif\if@SCIWARNpubidadjcol
\newif\if@SCIWARNSCImembership
\newif\if@SCIWARNSCIaftertitletext
\@SCIWARNthankstrue
\@SCIWARNPARstarttrue
\@SCIWARNCMPARstarttrue
\@SCIWARNkeywordstrue
\@SCIWARNbiographytrue
\@SCIWARNbiographynophototrue
\@SCIWARNpubidtrue
\@SCIWARNpubidadjcoltrue
\@SCIWARNSCImembershiptrue
\@SCIWARNSCIaftertitletexttrue


%% Lockout some commands when in various modes, but allow them to be restored if needed
%%
% save commands which might be locked out
% so that the user can later restore them if needed
\let\@SCISAVECMDthanks\thanks
\let\@SCISAVECMDPARstart\PARstart
\let\@SCISAVECMDCMPARstart\CMPARstart
\let\@SCISAVECMDkeywords\keywords
\let\@SCISAVECMDendkeywords\endkeywords
\let\@SCISAVECMDbiography\biography
\let\@SCISAVECMDendbiography\endbiography
\let\@SCISAVECMDbiographynophoto\biographynophoto
\let\@SCISAVECMDendbiographynophoto\endbiographynophoto
\let\@SCISAVECMDpubid\pubid
\let\@SCISAVECMDpubidadjcol\pubidadjcol
\let\@SCISAVECMDSCImembership\SCImembership
\let\@SCISAVECMDSCIaftertitletext\SCIaftertitletext


% disable \PARstart when in draft mode
% This may have originally been done because the pre-V1.6 drop letter
% algorithm had problems with a non-unity baselinestretch
% At any rate, it seems too formal to have a drop letter in a draft
% paper.
\if@draftclsmode
\def\PARstart#1#2{#1#2\if@SCIWARNPARstart\typeout{** ATTENTION: \noexpand\PARstart is disabled in draft mode (line \the\inputlineno).}\fi\global\@SCIWARNPARstartfalse}
\def\CMPARstart#1#2{#1#2\if@SCIWARNPARstart\typeout{** ATTENTION: \noexpand\CMPARstart is disabled in draft mode (line \the\inputlineno).}\fi\global\@SCIWARNCMPARstartfalse}
\fi
% and for technotes
\if@technote
\def\PARstart#1#2{#1#2\if@SCIWARNPARstart\typeout{** WARNING: \noexpand\PARstart is locked out for technotes (line \the\inputlineno).}\fi\global\@SCIWARNPARstartfalse}
\def\CMPARstart#1#2{#1#2\if@SCIWARNPARstart\typeout{** WARNING: \noexpand\CMPARstart is locked out for technotes (line \the\inputlineno).}\fi\global\@SCIWARNCMPARstartfalse}
\fi


% lockout unneeded commands when in conference mode
\if@confmode
% when locked out, \thanks, \keywords, \biography, \biographynophoto, \pubid,
% \SCImembership and \SCIaftertitletext will all swallow their given text.
% \PARstart and \CMPARstart will output a normal character instead
% warn the user about these commands only once to prevent the console screen
% from filling up with redundant messages
\def\thanks#1{\if@SCIWARNthanks\typeout{** WARNING: \noexpand\thanks is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNthanksfalse}
\def\PARstart#1#2{#1#2\if@SCIWARNPARstart\typeout{** WARNING: \noexpand\PARstart is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNPARstartfalse}
\def\CMPARstart#1#2{#1#2\if@SCIWARNPARstart\typeout{** WARNING: \noexpand\CMPARstart is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNCMPARstartfalse}

\renewenvironment{keywords}[1]{\if@SCIWARNkeywords\typeout{** WARNING: \noexpand\keywords is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNkeywordsfalse%
\setbox\@SCIndustriarubishbin\vbox\bgroup}{\egroup\relax}

% LaTeX treats environments and commands with optional arguments differently.
% the actual ("internal") command is stored as \\commandname
% (accessed via \csname\string\commandname\endcsname )
% the "external" command \commandname is a macro with code to determine
% whether or not the optional argument is presented and to provide the
% default if it is absent. So, in order to save and restore such a command
% we would have to save and restore \\commandname as well. But, if LaTeX
% ever changes the way it names the internal names, the trick would break.
% Instead let us just define a new environment so that the internal
% name can be left undisturbed.
\newenvironment{@SCIbogusbiography}[2][]{\if@SCIWARNbiography\typeout{** WARNING: \noexpand\biography is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNbiographyfalse%
\setbox\@SCIndustriarubishbin\vbox\bgroup}{\egroup\relax}
% and make biography point to our bogus biography
\let\biography=\@SCIbogusbiography
\let\endbiography=\end@SCIbogusbiography

\renewenvironment{biographynophoto}[1]{\if@SCIWARNbiographynophoto\typeout{** WARNING: \noexpand\biographynophoto is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNbiographynophotofalse%
\setbox\@SCIndustriarubishbin\vbox\bgroup}{\egroup\relax}

\def\pubid#1{\if@SCIWARNpubid\typeout{** WARNING: \noexpand\pubid is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNpubidfalse}
\def\pubidadjcol{\if@SCIWARNpubidadjcol\typeout{** WARNING: \noexpand\pubidadjcol is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNpubidadjcolfalse}
\def\SCImembership#1{\if@SCIWARNSCImembership\typeout{** WARNING: \noexpand\SCImembership is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNSCImembershipfalse}
\def\SCIaftertitletext#1{\if@SCIWARNSCIaftertitletext\typeout{** WARNING: \noexpand\SCIaftertitletext is locked out when in conference mode (line \the\inputlineno).}\fi\global\@SCIWARNSCIaftertitletextfalse}
\fi


% provide a way to restore the commands that are locked out
\def\SCIoverridecommandlockouts{%
\typeout{** ATTENTION: Overriding command lockouts (line \the\inputlineno).}%
\let\thanks\@SCISAVECMDthanks%
\let\PARstart\@SCISAVECMDPARstart%
\let\CMPARstart\@SCISAVECMDCMPARstart%
\let\keywords\@SCISAVECMDkeywords%
\let\endkeywords\@SCISAVECMDendkeywords%
\let\biography\@SCISAVECMDbiography%
\let\endbiography\@SCISAVECMDendbiography%
\let\biographynophoto\@SCISAVECMDbiographynophoto%
\let\endbiographynophoto\@SCISAVECMDendbiographynophoto%
\let\pubid\@SCISAVECMDpubid%
\let\pubidadjcol\@SCISAVECMDpubidadjcol%
\let\SCImembership\@SCISAVECMDSCImembership%
\let\SCIaftertitletext\@SCISAVECMDSCIaftertitletext}


\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End of SCIndustria.cls  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% That's all folks!
