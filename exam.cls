% exam class by Nate Iverson
%    This file is part of the course document classes.
%
%    Course document classes is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    Foobar is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with Course Document classes.  If not, see <http://www.gnu.org/licenses/>.
%
% Native options:
%
% raggedbottom (default)
%
% options from article.cls (also passed to geometry package):
%
% a4paper
% a5paper
% letterpaper (default)
% legalpaper
% executivepaper
% landscape
% draft
% final
% openright
% openany
% leqno
% fleqn
% openbib

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exam}[3/01/2012 version 1.0.5]
\def\@examv{1.0.5}

% Pass papersize options to article and geometry.
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{article} 
                        \PassOptionsToPackage{a4paper}{geometry}
                        \PassOptionsToPackage{a4paper}{hyperref}
}
\DeclareOption{a5paper}{\PassOptionsToClass{a5paper}{article} 
                        \PassOptionsToPackage{a5paper}{geometry}
                        \PassOptionsToPackage{a5paper}{hyperref}
}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{article} 
                            \PassOptionsToPackage{letterpaper}{geometry}
                            \PassOptionsToPackage{letterpaper}{hyperref}
}
\DeclareOption{legalpaper}{\PassOptionysToClass{legalpaper}{article} 
                           \PassOptionsToPackage{legalpaper}{geometry}
                           \PassOptionsToPackage{legalpaper}{hyperref}
}
\DeclareOption{executivepaper}{\PassOptions{executivepaper}{article} 
                               \PassOptionsToPackage{executivepaper}{geometry}
                               \PassOptionsToPackage{executivepaper}{hyperref}
}
\DeclareOption{landscape}{\PassOptionsToClass{landscape}{article} 
                          \PassOptionsToPackage{landscape}{geometry}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareOption{final}{\PassOptionsToClass{final}{article}}
\DeclareOption{openright}{\PassOptionsToClass{openright}{article}}
\DeclareOption{openany}{\PassOptionsToClass{openany}{article}}
\DeclareOption{leqno}{\PassOptionsToClass{leqno}{article}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{article}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{article}}


% pass hyperref options to ensure chapters are converted to
% PDF bookmarks passing it to geometry actually makes sure
% you convert to the correct paper size too!
\DeclareOption{unicode}{\PassOptionsToPackage{unicode}{hyperref}}

\DeclareOption{pdftex}{\PassOptionsToPackage{pdftex}{hyperref}
\PassOptionsToPackage{pdftex}{geometry}}

\DeclareOption{dvipdfm}{\PassOptionsToPackage{dvipdfm}{hyperref}
\PassOptionsToPackage{dvipdfm}{geometry}}

\DeclareOption{dvips}{\PassOptionsToPackage{dvips}{hyperref}
\PassOptionsToPackage{dvips}{geometry}
}
\DeclareOption{raggedbottom}{\raggedbottom}
\DeclareOption{flushbottom}{\flushbottom}

\PassOptionsToClass{oneside}{article}
\def\@coord{false}
\DeclareOption{coord}{
\let\@coord\empty
\def\@coord{true}}
% pass unknown options to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{unicode,pdftex,letterpaper,raggedbottom}
\ProcessOptions

\LoadClass{article}
%\usepackage[noTeX]{mmap}

% Below used to set margins
% 1 inch margins pagenumbers only in 3/4 inch, footnotes included as part
% of text
\RequirePackage{geometry}
\geometry{margin=.75in, nofoot, headsep=10pt}% options appended.

\RequirePackage{calc}
\RequirePackage{ifthen}

% define some variable for the exam maketitle.
\def\course#1{\def\@course{#1}}
\def\term#1{\def\@term{#1}}
\def\title#1{\def\@title{#1}}
\def\author#1{\def\@author{#1}}
\def\date#1{\def\@date{#1}}

\def\@keywords{\@title\  (\@points\ points)\ /\ \@course\ /\ \@author\  /\ \@term\ /\ \@date}
\def\keywords#1{
\let\@keywords\empty
\def\@keywords{#1}}

\def\@points{100}
\def\points#1{
\let\@points\empty
\def\@points{#1}}

\def\@classtime{}
\def\classtime#1{
\def\@classtime{#1}}

\def\@section{}
\def\section#1{
\def\@section{#1}}

\def\@instructor{}
\def\instructor#1{
\def\@instructor{#1}}

% make sure to include pdftex in all relevent packages
% as it will automatically put bookmarks in pdf files generated
\RequirePackage{hyperref} 
\hypersetup{%
  pdfencoding=auto,
  bookmarksnumbered,
  plainpages=false,
  pdfstartview= FitH,
  colorlinks=false,
}
\newlength{\lengthA}\newlength{\lengthB}\newlength{\lengthC}\newlength{\lengthD}
\newlength{\lengtha}\newlength{\lengthb}\newlength{\lengthc}\newlength{\lengthd}
\newlength{\maxl}
\newlength{\underlinelength}
\setlength{\underlinelength}{3.5in}

\newcommand{\ps@body}{
  \renewcommand{\@oddhead}{\hfill \thepage}
  \renewcommand{\@evenhead}{\hfill \thepage}
  \renewcommand{\@oddfoot}{}
  \renewcommand{\@evenfoot}{}
}

\renewcommand{\maketitle}{
  % The below needs to be in the actual document aka after \@author
  % have been defined. That is why here.
  \hypersetup{%
    pdfauthor={\@author},
    pdftitle={\@title},
    pdfsubject={\@title \ (\@points\ points)\ /\ \@course\  /\ \@date },
    pdfkeywords={\@keywords}, 
    pdfcreator={exam.cls v\@examv \ by Nate Iverson},
  } 
\ifthenelse{\equal{\@coord}{true}}{
  \let\@classtime\empty
  \def\@classtime{}
}
{
  \let\@instructor\empty
  \def\@instructor{\@author}
}
\settowidth{\lengthA}{Name: }
\settowidth{\lengthB}{Class time: \@classtime}
\settowidth{\lengthC}{Instructor: \@instructor}
\settowidth{\lengthD}{Section: \@section}
\setlength{\lengthA}{\underlinelength-\lengthA}
\setlength{\lengthB}{\underlinelength-\lengthB}
\setlength{\lengthC}{\underlinelength-\lengthC}
\setlength{\lengthD}{\underlinelength-\lengthD}
\settowidth{\lengtha}{\@title}
\settowidth{\lengthb}{\@course}
\settowidth{\lengthc}{\@term}
\settowidth{\lengthd}{\@date}
\ifthenelse{\lengthtest{\lengtha>\lengthb}\or\lengthtest{\lengtha=\lengthb} 
}
  {
   \ifthenelse{\lengthtest{\lengtha>\lengthc}\or\lengthtest{\lengtha=\lengthc}}
    {
      \ifthenelse{\lengthtest{\lengtha>\lengthd}\or\lengthtest{\lengtha=\lengthd}}
      {\setlength{\maxl}{\lengtha}}{\setlength{\maxl}{\lengthd}}
    }
    { 
      \ifthenelse{\lengthtest{\lengthc>\lengthd}\or\lengthtest{\lengthc=\lengthd}}
      {\setlength{\maxl}{\lengthc}}{\setlength{\maxl}{\lengthd}}
    }
  }
  {
   \ifthenelse{\lengthtest{\lengthb>\lengthc}\or\lengthtest{\lengthb=\lengthc}}
    {
      \ifthenelse{\lengthtest{\lengthb>\lengthd}\or\lengthtest{\lengthb=\lengthd}}
      {\setlength{\maxl}{\lengthb}}{\setlength{\maxl}{\lengthd}}
    }
    {
      \ifthenelse{\lengthtest{\lengthc>\lengthd}\or\lengthtest{\lengthc=\lengthd}}
      {\setlength{\maxl}{\lengthc}}{\setlength{\maxl}{\lengthd}}
    }
  }
\setlength{\lengtha}{\maxl+10pt-\lengtha}
\setlength{\lengthb}{\maxl+10pt-\lengthb}
\setlength{\lengthc}{\maxl+10pt-\lengthc}
\setlength{\lengthd}{\maxl+10pt-\lengthd}
\pagestyle{body}
\thispagestyle{empty}
\noindent \@title \hspace*{\lengtha} \underline{Name: \hspace{\lengthA}}\\
\@course \hspace*{\lengthb} \underline{Class time: \@classtime \hspace{\lengthB}}
\hfill \@points \ points \\
\@term \hspace*{\lengthc} \underline{Instructor: \@instructor \hspace{\lengthC}}
\hfill Score: \phantom{\ \@points \ points} \\
\@date  \hspace*{\lengthd} \underline{Section: \@section \hspace{\lengthD}}\\

}

\let\newItemize=\itemize
\renewenvironment{itemize}{\newItemize\leftskip=-0.5cm}{\endlist}

\let\newEnumerate=\enumerate
\renewenvironment{enumerate}{\newEnumerate\leftskip=-0.5cm}{\endlist}
