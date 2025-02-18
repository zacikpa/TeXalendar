\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{calendar}
[2018/09/07 v1.0]
\LoadClass[a5paper,12pt]{article}

% Packages
\RequirePackage[
    landscape,
    bottom=4mm,
    top=4mm,
    left=0mm,
    right=0mm
    ]{geometry}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{xifthen}
\RequirePackage{keyval}
\RequirePackage{xcolor}
\RequirePackage{calc}
\RequirePackage{polyglossia}
\RequirePackage{fontspec}
\RequirePackage{ifthen}

%%
%% DOCUMENT
%%
% Pagestyle
\pagenumbering{gobble}

%%
%% WEEKPAGE 
%%
% Localisation
\input{localisation.tex}

%% Weekpage dimensioning and styling
\newcommand{\wkmnthwdth}{5mm}
\newcommand{\wkrxwdth}{98mm}
% this ensures simmetry about the fold:
\newcommand{\wklxwdth}{\wkrxwdth - \wkmnthwdth}
% three rules per day:
\newcommand{\wkrowh}{\textheight / 21}
\setlength{\arrayrulewidth}{0.1mm}


\definecolor{rulegray}{cmyk}{0,0,0,0.5}
\definecolor{rgray}{cmyk}{0,0,0,0.5}
\definecolor{darkred}{cmyk}{0.5,1,1,0}
\definecolor{pastelred}{cmyk}{0.2,1,1,0}

\newcommand{\weekdayfont}[1]{\footnotesize\textcolor{#1}}
\newcommand{\numdayfont}[1]{\Large\textcolor{#1}}
\newcommand{\monthfont}{\footnotesize\scshape\color{rgray}}
\newcommand{\holidayfont}{\footnotesize\textcolor{black}}
% must use \color instead of \textcolor for monthfont
% [no known reason]

% Keys and defaults
\define@key{week}{da}{\def\nda{#1}}
\define@key{week}{db}{\def\ndb{#1}}
\define@key{week}{dc}{\def\ndc{#1}}
\define@key{week}{dd}{\def\ndd{#1}}
\define@key{week}{de}{\def\nde{#1}}
\define@key{week}{df}{\def\ndf{#1}}
\define@key{week}{dg}{\def\ndg{#1}}
\define@key{week}{aholiday}{\def\hola{#1}}
\define@key{week}{bholiday}{\def\holb{#1}}
\define@key{week}{choliday}{\def\holc{#1}}
\define@key{week}{dholiday}{\def\hold{#1}}
\define@key{week}{eholiday}{\def\hole{#1}}
\define@key{week}{fholiday}{\def\holf{#1}}
\define@key{week}{gholiday}{\def\holg{#1}}
\define@key{week}{curmonth}{\def\ncmonth{#1}}
\define@key{week}{newmonth}{\def\nnmonth{#1}}
\define@key{week}{newday}{\def\nnday{#1}}
\setkeys{week}{
    da=00,db=00,dc=00,dd=00,de=00,df=00,dg=00,
    aholiday=None,
    bholiday=None,
    choliday=None,
    dholiday=None,
    eholiday=None,
    fholiday=None,
    gholiday=None,
    curmonth=default,
    newmonth=default,newday=3
}

% Weekpage auxiliaries
\newcommand{\wkmultirow}[1]{
    \multirow[c]{3}{*}{
        \rotatebox[origin=c]{90}{\monthfont #1}
    }
}

\newcommand{\wkday}[6]{
	% 1 day of the week
	% 2 number of the day
	% 3 month side label
    % 4 color of the weekday
    % 5 color of the day number
    % 6 holiday name
    \wkmultirow{#3}
    &
    \ifthenelse{\equal{#6}{}}
        {\weekdayfont{#4} #1}
        {\weekdayfont{black} #1}
    & \\ \cline{3-3}
    &
    \ifthenelse{\equal{#6}{}}
        {\numdayfont{#5}{#2}}
        {\numdayfont{black}{#2}}
    & \\ \cline{3-3}
    & \holidayfont{#6} & \\\cline{3-3}
    \cline{2-3}
}

\newcommand{\daymonth}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}

\newcommand\week{
    \color{rulegray}
    % mind the invisible rule used to set row height!
    \begin{tabular}{p{\wkmnthwdth}@{}p{\wklxwdth}@{\vline}p{\wkrxwdth}<{\rule[-2mm]{0pt}{\wkrowh}}}
    \cline{2-3}
    %\wkday{\wkdaya}{\nda}{\ncmonth}
    \wkday{\wkdaya}{\nda}{\daymonth{1}{1}{\ncmonth}}{black}{rgray}{\hola}
    \wkday{\wkdayb}{\ndb}{\daymonth{\nnday}{2}{\nnmonth}}{black}{rgray}{\holb}
    \wkday{\wkdayc}{\ndc}{\daymonth{\nnday}{3}{\nnmonth}}{black}{rgray}{\holc}
    \wkday{\wkdayd}{\ndd}{\daymonth{\nnday}{4}{\nnmonth}}{black}{rgray}{\hold}
    \wkday{\wkdaye}{\nde}{\daymonth{\nnday}{5}{\nnmonth}}{black}{rgray}{\hole}
    \wkday{\wkdayf}{\ndf}{\daymonth{\nnday}{6}{\nnmonth}}{black}{rgray}{\holf}
    \wkday{\wkdayg}{\ndg}{\daymonth{\nnday}{7}{\nnmonth}}{black}{black}{\holg}
    \end{tabular}
}

% Weekpage
\newcommand\weekpage[1]{%
	\setkeys{week}{#1}
    \begin{center}
		\week
    \end{center}
    \pagebreak
}

%%
%% TIMETABLE
%%
\newcommand{\tttitle}[1]{
    {\Large\scshape\textcolor{rgray}{#1}}
}

\newcommand{\timefont}[1]{
    \textcolor{black}{#1}
}

\newcommand{\ttdayfont}[1]{
    \textcolor{black}{#1}
}

\newcommand{\ttweekdays}{
    \ttdayfont{\wkdaya} &
    \ttdayfont{\wkdayb} &
    \ttdayfont{\wkdayc} &
    \ttdayfont{\wkdayd} &
    \ttdayfont{\wkdaye}
}

\newcommand{\ttcolwdth}{30mm}
\newcommand{\tttimewdth}{30mm}
\newcommand{\ttrowh}{5mm}

% https://tex.stackexchange.com/a/12712
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

\newcommand{\timetable}[1]{
    \noindent\rule{5mm}{0pt}\tttitle{#1}
    \hfill
    \begin{center}
    \color{rgray!60}

    \medskip

    \begin{tabular}{
        C{\tttimewdth} 
        |C{\ttcolwdth}<{\rule[-2mm]{0pt}{\ttrowh}}
        |C{\ttcolwdth}
        |C{\ttcolwdth}
        |C{\ttcolwdth}
        |C{\ttcolwdth}
    }
        & \ttweekdays \\\hline
        \timefont{08:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{09:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{10:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{11:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{12:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{13:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{14:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{15:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{16:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{17:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
        \timefont{18:00} & & & & & \\\cline{2-6}
        & & & &  \\\hline
    \end{tabular}
    \end{center}
    \vfill
    \pagebreak
}
