%% Start of file `cv.cls'.
% Class for creating CV and supplementary documents
%
% Author:
% Scott Ruoti <ruoti@utk.edu>
%
% Notes:
% Inspired by Awesome-CV (https://github.com/posquit0/Awesome-CV)
%
% Class license:
% MIT

%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\ProvidesClass{cv}[2021/11/03 v1.0.3]
\NeedsTeXFormat{LaTeX2e}

%-------------------------------------------------------------------------------
%                Class options
%-------------------------------------------------------------------------------

\newif\ifcv@debug
\cv@debugfalse
\DeclareOption{debug}{\cv@debugtrue}

\newif\ifcv@cv
\cv@cvfalse
\DeclareOption{cv}{\cv@cvtrue}

\newif\ifcv@application
\cv@applicationfalse
\DeclareOption{application}{\cv@applicationtrue}

\newif\ifcv@statement
\cv@statementfalse
\DeclareOption{statement}{\cv@statementtrue\cv@applicationtrue}

\newif\ifcv@letter
\cv@letterfalse
\DeclareOption{letter}{\cv@lettertrue\cv@applicationtrue}

% Load options and underlying class
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass[letterpaper,11pt]{article}


%-------------------------------------------------------------------------------
%                Debug mode
%-------------------------------------------------------------------------------
\ifcv@debug
	\PassOptionsToPackage{showframe}{geometry}

	% Draw lines around minipages to aid in layout
	\newsavebox{\cv@minipagebox}
	\newenvironment{cv@minipage}
		{\begin{lrbox}{\cv@minipagebox}\begin{minipage}}
		{\end{minipage}\end{lrbox}\begingroup\setlength{\fboxsep}{0pt}\fbox{\usebox{\cv@minipagebox}}\endgroup}
\else
	\newenvironment{cv@minipage}{\begin{minipage}}{\end{minipage}}
\fi


%-------------------------------------------------------------------------------
%                Packages
%-------------------------------------------------------------------------------
\RequirePackage{formatting}

\RequirePackage{bold-extra}				% Adds bold small-caps
\RequirePackage{calc}					% Allows calculations on dimensions
\RequirePackage{cite}					% Nicer citations
\RequirePackage{fancyhdr}				% Allows for a fancy footer
\RequirePackage{fontawesome}			% Icons
\RequirePackage{hyperref}				% Hyperlinks
\RequirePackage{lastpage}				% Allows querying of the number of pages
\RequirePackage{listofitems}			% List handling
\RequirePackage{geometry}				% Page geometry
\RequirePackage[explicit]{titlesec}		% Redefinition of titles and section headers
\RequirePackage{xparse}					% Advanced command creation
\RequirePackage{xstring}				% Advanced string handling


%-------------------------------------------------------------------------------
%                Load personal info
%-------------------------------------------------------------------------------

% Primary information
\newcommand*{\name}[1]{\def\cv@name{#1}}
\newcommand*{\reseachinterests}[1]{\def\cv@researchinterests{#1}}
\newcommand*{\address}[1]{\def\cv@address{#1}}

% Secondary information
\newcommand*{\workphone}[1]{\def\cv@workphone{#1}}
\newcommand*{\mobile}[1]{\def\cv@mobile{#1}}
\newcommand*{\workemail}[1]{\def\cv@workemail{#1}}
\newcommand*{\email}[1]{\def\cv@email{#1}}
\newcommand*{\homepage}[1]{\def\cv@homepage{#1}}

\newcommand*{\github}[1]{\def\cv@github{#1}}
\newcommand*{\gitlab}[1]{\def\cv@gitlab{#1}}
\newcommand*{\stackoverflow}[2]{
	\def\cv@stackoverflowid{#1}
	\def\cv@stackoverflowname{#2}
}
\newcommand*{\linkedin}[1]{\def\cv@linkedin{#1}}
\newcommand*{\twitter}[1]{\def\cv@twitter{#1}}
\newcommand*{\skype}[1]{\def\cv@skype{#1}}
\newcommand*{\extrainfo}[1]{\def\cv@extrainfo{#1}}

% Injest information
\input{personal-info}


%-------------------------------------------------------------------------------
%                Commands for displaying CV items
%-------------------------------------------------------------------------------

%% Setup commands to inject item seperator for a list
\newif\ifcv@itemSeperatorNeeded

\newcommand*{\cv@initItemSeperator}[1]{%
	\def\cv@itemSeperatorValue{#1}
	\cv@itemSeperatorNeededfalse
}

\newcommand*{\cv@addItemSeperator}{\ifcv@itemSeperatorNeeded \cv@itemSeperatorValue \fi \cv@itemSeperatorNeededtrue}


%% Setup CV lists
%\cv@newItemListEnvironment{name}{top spacing}[inner definitions]
\NewDocumentCommand{\cv@newItemListEnvironment}{m m o}{%
	\newenvironment{#1}{%
		\begingroup
		\setlength{\parskip}{0pt}
		\cv@initItemSeperator{\vskip #2}
		\IfValueT{#3}{#3}
	}{
		\endgroup
	}
}


%% Setup formatted column items
\newlength{\cv@columnsep}
\setlength{\cv@columnsep}{1em}

\newlength{\cv@defaultLeftColumnSize}
\setlength{\cv@defaultLeftColumnSize}{.5in}

\newlength{\cv@defaultRightColumnSize}
\setlength{\cv@defaultRightColumnSize}{1.5in}

\newcommand*{\cv@columnItemDetails}[1]{%
	\begingroup
	\cv@itemDetailsStyle
	\setlist[itemize]{topsep=\parsep,parsep=0pt}
	\begin{itemize}#1\end{itemize}
	\endgroup
}

%\cv@threeColumnItem[left column size][right column size]{left contents}{middle contents}{right contents}[details]
\NewDocumentCommand{\cv@threeColumnItem}{O{\cv@defaultLeftColumnSize} O{\cv@defaultRightColumnSize} m m m o}{%
	\begin{cv@minipage}{\textwidth}
		\begin{cv@minipage}[t]{#1}\raggedright#3\end{cv@minipage}\hfill%
		\begin{cv@minipage}[t]{\textwidth-#1-#2-2\cv@columnsep}#4\end{cv@minipage}\hfill%
		\begin{cv@minipage}[t]{#2}\raggedleft#5\end{cv@minipage}%
		\IfValueT{#6}{\cv@columnItemDetails{#6}}
	\end{cv@minipage}
	\vskip 0pt
}

%\cv@twoColumnItemLeft[left column size]{left contents}{middle contents}[details]
\NewDocumentCommand{\cv@twoColumnItemLeft}{O{\cv@defaultLeftColumnSize} m m o}{%
	\begin{cv@minipage}{\textwidth}
		\begin{cv@minipage}[t]{#1}\raggedright#2\end{cv@minipage}\hfill%
		\begin{cv@minipage}[t]{\textwidth-#1-\cv@columnsep}#3\end{cv@minipage}%
		\IfValueT{#4}{\cv@columnItemDetails{#4}}
	\end{cv@minipage}
	\vskip 0pt
}

%\cv@twoColumnItemRight[right column size]{middle contents}{right contents}[details]
\NewDocumentCommand{\cv@twoColumnItemRight}{O{\cv@defaultRightColumnSize} m m o}{%
	\begin{cv@minipage}{\textwidth}%
		\begin{cv@minipage}[t]{\textwidth-#1-\cv@columnsep}#2\end{cv@minipage}\hfill%
		\begin{cv@minipage}[t]{#1}\raggedleft#3\end{cv@minipage}%
		\IfValueT{#4}{\cv@columnItemDetails{#4}}
	\end{cv@minipage}
	\vskip 0pt
}


%-------------------------------------------------------------------------------
%                Reverse counter
%-------------------------------------------------------------------------------

% Counter to keep track of the current reverse counter
\newcounter{cv@reverseCounterNumber}
\setcounter{cv@reverseCounterNumber}{0}

%\cv@initReverseCounter{startingNumber}
\NewDocumentCommand{\cv@initReverseCounter}{O{1}}{%
	% Get the name for the step counters we will create
	\stepcounter{cv@reverseCounterNumber}
	\edef\cv@reverseCounterDisplay{cv@reverseCounter@display@\thecv@reverseCounterNumber}
	\edef\cv@reverseCounterCount{cv@reverseCounter@count@\thecv@reverseCounterNumber}
	
	% When the counter doesn't exist on the first pass, show negative numbers (as we don't know the top number yet)
	\ifcsname c@\cv@reverseCounterDisplay\endcsname\else
		\newcounter{\cv@reverseCounterDisplay}
		\setcounter{\cv@reverseCounterDisplay}{#1*-1}
	\fi
	
	% Every pass we need to check how many items there are in the list for the countdown
	\newcounter{\cv@reverseCounterCount}
	\setcounter{\cv@reverseCounterCount}{#1}
}

% Display the reverse counter
\newcommand*{\cv@theReverseCounter}{\csname the\cv@reverseCounterDisplay\endcsname}

% Get the counter name in case it is need for an alternate format
\newcommand*{\cv@theReverseCounterName}{\cv@reverseCounterDisplay}

% Update both the display counter and the counter tracking total number of items
\newcommand*{\cv@stepReverseCounter}{%
	\addtocounter{\cv@reverseCounterDisplay}{-1}%
	\addtocounter{\cv@reverseCounterCount}{1}%
}

% At the end of the document, write current counts to the aux file so we can reverse them on the next run
\AtEndDocument{
	% Iterate over each reverse counter
	\ifnum \value{cv@reverseCounterNumber} > 0
		\loop
			% Get the names of the relevant counters
			\edef\cv@reverseCounterDisplay{cv@reverseCounter@display@\thecv@reverseCounterNumber}
			\edef\cv@reverseCounterCount{cv@reverseCounter@count@\thecv@reverseCounterNumber}
			
			% Write a command to aux (which will be run at the start of the document).
			% This command will define the reverse counters and set their correct initial value.
			\immediate\write\@mainaux{%
				\string\ifcsname\space c@\cv@reverseCounterDisplay\string\endcsname\string\else%
					\string\newcounter{\cv@reverseCounterDisplay}%
				\string\fi%
				\string\setcounter{\cv@reverseCounterDisplay}{\number\value{\cv@reverseCounterCount}}%
			}
		
			% Loop logic
			\addtocounter{cv@reverseCounterNumber}{-1}
		\ifnum \value{cv@reverseCounterNumber} > 0 \repeat
	\fi
}


%-------------------------------------------------------------------------------
%                Document styling
%-------------------------------------------------------------------------------

%% Margins
\geometry{margin=.75in}


%% Hyperlinks
% TODO: Consider adding link coloring
\hypersetup{hidelinks}

%% List styling
\setlist{leftmargin=2em,itemsep=0pt}

%% Paragraph styling
\setlength{\parindent}{0pt}
\ifcv@cv \else
	\setlength{\parskip}{.5\baselineskip plus 2pt}
%	\setlength{\parskip}{\baselineskip plus 1pt}
\fi

%% CV lists
\newlength{\cv@itemsep}
\setlength{\cv@itemsep}{\baselineskip}

\newlength{\cv@itemseptight}
\setlength{\cv@itemseptight}{.5\cv@itemsep}

\newlength{\cv@itemsepverytight}
\setlength{\cv@itemsepverytight}{.5\cv@itemseptight}


%% emph styling
\ifcv@cv
	\let\emph\textbf
\else
	\RequirePackage{ulem}
	\RenewDocumentCommand{\emph}{m}
	{{\itshape\uline{#1}}}
\fi

%% CV item styling
\def\cv@itemTitleStyle{\normalfont\bfseries}
\def\cv@itemSubtitleStyle{\normalfont\itshape}
\def\cv@itemDetailsStyle{\normalfont}

\def\cv@itemPubTitleStyle{\normalfont}
\def\cv@itemExtraInfoStyle{\normalfont\scshape\small}

\def\cv@itemEmphStyle{\bfseries}


%-------------------------------------------------------------------------------
%                Header and footer
%-------------------------------------------------------------------------------

% Setup the header and footer
\pagestyle{fancy}

% Setup new footer
\fancyhf{} % Disable header
\ifcv@letter \else
	\fancyfoot[L]{\today}
	\fancyfoot[C]{\cv@name~~$\cdotp$~~\@title}
	\fancyfoot[R]{Page \thepage\space of \pageref*{LastPage}}
\fi

\renewcommand*{\headrulewidth}{0pt}

% Print a title item
%\cv@titleItem{value}{icon}[link prefix]
\NewDocumentCommand{\cv@titleItem}{m m o}{%
	\ifdefined #1%
		\cv@addItemSeperator
		\IfValueTF{#3}{\href{#3#1}{#2\nobreakspace#1}}{#1}%
	\fi
}

\ifcv@cv
	\title{Curriculum Vitae}
\fi

% Make the modified title
\renewcommand*{\maketitle}{%
	\begin{center}
		\begingroup
		\setlength{\parskip}{0pt}
		
		{\Huge\bfseries\cv@name}
		
		\begingroup
		\scshape
		\cv@initItemSeperator{\enskip$\cdot$\enskip}
		\setsepchar{,}\readlist*\interestlist{\cv@researchinterests}
		\foreachitem \interest \in \interestlist {\cv@addItemSeperator\interest}
		\endgroup
		
		\ifdefined \cv@address
			\faHome\nobreakspace\cv@address
		\fi
		
		\begingroup
		\cv@initItemSeperator{~~\textbar\space\space}
		\ifcv@application%
			\cv@titleItem{\cv@mobile}{\faMobile}[tel:]%
			\cv@titleItem{\cv@email}{\faEnvelope}[mailto:]%
		\else%
			\cv@titleItem{\cv@workphone}{\faPhoneSquare}[tel:]%
			\cv@titleItem{\cv@workemail}{\faEnvelope}[mailto:]%
		\fi%
		\cv@titleItem{\cv@homepage}{\faGlobe}[https://]%
		\cv@titleItem{\cv@github}{\faGithubSquare}[https://github.com/]%
		\cv@titleItem{\cv@gitlab}{\faGitlab}[https://gitlab.com/]%
		\cv@titleItem{\cv@stackoverflowname}{\faStackOverflow}[https://stackoverflow.com/users/\cv@stackoverflowid/]%
		\cv@titleItem{\cv@linkedin}{\faLinkedinSquare}[https://www.linkedin.com/in/]%
		\cv@titleItem{\cv@twitter}{\faTwitterSquare}[https://twitter.com/]%
		\cv@titleItem{\cv@skype}{\faSkype}%
		\ifdefined\cv@extrainfo\cv@titleItemSeperator\cv@extrainfo\fi
		\endgroup
	
		\ifcv@statement
			\vskip 2.5\baselineskip
			{\normalfont\bfseries\scshape\huge\@title}\vskip .1em \hrule height .1em
		\fi
		
		\endgroup
	\end{center}
}


%-------------------------------------------------------------------------------
%                Section headings
%-------------------------------------------------------------------------------

\ifcv@cv
	\titleformat{\section}
		{\normalfont\bfseries\Large}
		{}
		{0pt}
		{#1\leavevmode\leaders\hrule\hfill \kern\z@}
	\titlespacing*{\section}{0pt}{7ex plus 2ex minus .4ex}{2.3ex plus .2ex}
	
	\titleformat{\subsection}
		{\normalfont\large\bfseries}
		{}
		{0pt}
		{#1}
		
\fi

\ifcv@statement
	\titlespacing*{\section}{0pt}{2.0ex plus 1ex minus .2ex}{-0.2ex plus .2ex}
	\titlespacing*{\subsection}{0pt}{2.25ex plus 1ex minus .2ex}{-.5ex plus .2ex}
	
	
	\titleformat{\paragraph}[runin]
		{\normalfont\normalsize\bfseries}{\theparagraph}{}{#1}[:]
	\titlespacing{\paragraph}{\parindent}{\z@}{1em}
	
	\titleformat{\subparagraph}[runin]
		{\normalfont\normalsize\itshape}{\thesubparagraph}{}{#1}[:]
	\titlespacing{\subparagraph}{\parindent}{\z@}{1em}
\fi


%-------------------------------------------------------------------------------
%                Education
%-------------------------------------------------------------------------------
%\degree{degree%text}{university%text}{date%text}{additional info%text}[itemized details%text]#/degrees

\cv@newItemListEnvironment{degrees}{\cv@itemsep}[\def\degree{\cv@addItemSeperator\cv@degreeItem}]
\NewDocumentCommand{\cv@degreeItem}{ m m m m o }{
	\cv@twoColumnItemRight
		{{\cv@itemTitleStyle #1}\\{\cv@itemSubtitleStyle #2}}
		{{\cv@itemExtraInfoStyle #3\\#4}}[#5]
}


%-------------------------------------------------------------------------------
%                Experience
%-------------------------------------------------------------------------------
%\experience{position%text}{employer%text}{location%text}{dates%text}[itemized details%text]#/experience

\cv@newItemListEnvironment{experience}{\cv@itemsep}[\def\job{\cv@addItemSeperator\cv@jobItem}]
\NewDocumentCommand{\cv@jobItem}{ m m m m o }{
	\cv@twoColumnItemRight
		{{\cv@itemTitleStyle #1}\\{\cv@itemSubtitleStyle #2, #3}}
		{{\cv@itemExtraInfoStyle #4}}[#5]
}


%-------------------------------------------------------------------------------
%                Funding
%-------------------------------------------------------------------------------
%\grant{role%text}{title%text}{funder%text}{amount}[personal amount]{dates%text}[itemized details%text]#/funding

\cv@newItemListEnvironment{funding}{\cv@itemsep}[\def\grant{\cv@addItemSeperator\cv@grantItem}]
\NewDocumentCommand{\cv@grantItem}{ m m m m o m o }{
	\cv@threeColumnItem
		{\cv@itemTitleStyle #1}
		{{\cv@itemPubTitleStyle #2}\\{\cv@itemDetailsStyle\itshape #3}}
		{{\cv@itemExtraInfoStyle #6\\Total: #4\IfValueT{#5}{\\Mine: #5}}}[#7]
}


%-------------------------------------------------------------------------------
%                Publications
%-------------------------------------------------------------------------------
%\journal{title%text}{authors%text}{venue short-name}[acceptance rate]{proceedings name}{publication details%text}#/publications
%\proceedings{title%text}{authors%text}{venue short-name}[acceptance rate]{proceedings name}{publication details%text}#/publications
%\poster{title%text}{authors%text}{venue short-name}[acceptance rate]{proceedings name}[publication details%text]#/publications


\NewDocumentEnvironment{publications}{O{}}{%
	\begingroup
	\setlength{\parskip}{0pt}
	\cv@initItemSeperator{\vskip \cv@itemseptight}
	\cv@initReverseCounter
	\def\cv@pubPrefix{#1}
	
	\def\journal{\cv@addItemSeperator\cv@journalItem}
	\def\proceedings{\cv@addItemSeperator\cv@proceedingsItem}
	\def\poster{\cv@addItemSeperator\cv@posterItem}
	\def\preprint{\cv@addItemSeperator\cv@preprintItem}
}{\endgroup}

\NewDocumentCommand{\cv@journalItem}{ m m m o m m }{
	\cv@publicationItem{#1}{#2}{#3}[#4]{\textit{#5}, #6}
}

\NewDocumentCommand{\cv@proceedingsItem}{ m m m o m m }{
	\cv@publicationItem{#1}{#2}{#3}[#4]{\textit{Proceedings of the #5}. #6}
}

\NewDocumentCommand{\cv@posterItem}{ m m m o m o }{
	\cv@publicationItem{#1}{#2}{#3}[#4]{Poster at the \textit{#5}\IfValueT{#6}{. #6}}
}

\NewDocumentCommand{\cv@preprintItem}{ m m m m o }{
	\cv@publicationItem{#1}{#2}{#3}{\textit{#4}\IfValueT{#5}{, #5}}
}

\NewDocumentCommand{\cv@publicationItem}{ m m m o m }{
	\setsepchar{,}\readlist*\authorlist{#2}
	
	\cv@threeColumnItem
		{\cv@stepReverseCounter [\cv@pubPrefix\cv@theReverseCounter]}
		{
		% Iterate over authors, ensuring names stay together and highlighting CV owner's name
			\begingroup
			\cv@itemDetailsStyle
			\cv@initItemSeperator{, }
			\foreachitem \author \in \authorlist {%
				\cv@addItemSeperator
				\begingroup
				\IfStrEq{\author}{\cv@name}{\cv@itemEmphStyle}{}%
				\StrSubstitute{\author}{ }{~}
				\endgroup
			}.
			\endgroup
			{\cv@itemPubTitleStyle #1}{\cv@itemDetailsStyle{}, #5.}%
		}
		{{\cv@itemExtraInfoStyle{} #3\IfValueT{#4}{\\Acceptance: #4\%}}}
}


%-------------------------------------------------------------------------------
%                Presentations
%-------------------------------------------------------------------------------\
%\presentation{title%text}{type}{location}{date}#/presentations

\cv@newItemListEnvironment{presentations}{\cv@itemseptight}[
	\cv@initReverseCounter
	\def\presentation{\cv@addItemSeperator\cv@presentationItem}
]
\NewDocumentCommand{\cv@presentationItem}{ m m m m }{
	\cv@threeColumnItem
		{\cv@stepReverseCounter\cv@theReverseCounter.}
		{{\cv@itemPubTitleStyle #1}\\{\cv@itemDetailsStyle #2, #3}}
		{{\cv@itemExtraInfoStyle #4}}
}


%-------------------------------------------------------------------------------
%                Service
%-------------------------------------------------------------------------------
%\service{organization%text}{description%text}[location%text]#/servicelist

\cv@newItemListEnvironment{servicelist}{\cv@itemsepverytight}[
	\cv@initReverseCounter
	\def\service{\cv@addItemSeperator\cv@serviceItem}
]
\NewDocumentCommand{\cv@serviceItem}{m m o}{
	\cv@threeColumnItem[\cv@defaultLeftColumnSize][1.6in]
		{\cv@stepReverseCounter\cv@theReverseCounter.}
		{{\cv@itemDetailsStyle{#1}}}
		{{\cv@itemExtraInfoStyle #2}}
}


%-------------------------------------------------------------------------------
%                Teaching
%-------------------------------------------------------------------------------
%\course{name%text}{number}{semester%text}#/teaching

\cv@newItemListEnvironment{teaching}{\cv@itemsepverytight}[\def\course{\cv@addItemSeperator\cv@courseItem}]
\NewDocumentCommand{\cv@courseItem}{m m m o}{
	\cv@threeColumnItem[\cv@defaultRightColumnSize]
		{{\cv@itemDetailsStyle #2}}
		{{\cv@itemDetailsStyle #1}}
		{{\cv@itemExtraInfoStyle #3}}
		[#4]
}


%-------------------------------------------------------------------------------
%                Students
%-------------------------------------------------------------------------------
%\phd{name%text}{graduation semester%text}{dissertation title%text}[current position%text]#/phdstudents
%\msthesis{name%text}{graduation semester%text}{thesis title%text}[current position%text]#/msstudents
%\msproject{name%text}{graduation semester%text}{project title%text}[current position%text]#/msstudents
%\mscourse{name%text}{graduation semester%text}[current position%text]#/msstudents
%\ug{name%text}{graduation semester%text}[current position%text]#/ugstudents
%\reu{name%text}{graduation semester%text}{}home institution%text}#/ugstudents

\cv@newItemListEnvironment{phdstudents}{\cv@itemsep}[
	\def\phd{\cv@addItemSeperator\cv@phdstudentItem}
]
\NewDocumentCommand{\cv@phdstudentItem}{m m m o}{\cv@studentItem{#1}{#2}[#4][Dissertation: \textit{#3}]}

\cv@newItemListEnvironment{msstudents}{\cv@itemseptight}[
	\def\msthesis{\cv@addItemSeperator\cv@msthesisItem}
	\def\msproject{\cv@addItemSeperator\cv@msprojectItem}
	\def\mscourse{\cv@addItemSeperator\cv@mscourseItem}
]
\NewDocumentCommand{\cv@msthesisItem}{m m m o}{\cv@studentItem{#1}{#2}[#4][Thesis: \textit{#3}]}
\NewDocumentCommand{\cv@msprojectItem}{m m m o}{\cv@studentItem{#1}{#2}[#4][Project in Lieu of Thesis: \textit{#3}]}
\NewDocumentCommand{\cv@mscourseItem}{m m o}{\cv@studentItem{#1}{#2}[#3]}

\cv@newItemListEnvironment{ugstudents}{\cv@itemsepverytight}[
	\def\ug{\cv@addItemSeperator\cv@ugstudentItem}
	\def\reu{\cv@addItemSeperator\cv@reuStudentItem}
]
\NewDocumentCommand{\cv@ugstudentItem}{m m o}{\cv@studentItem{#1}{#2}[#3]}
\NewDocumentCommand{\cv@reuStudentItem}{m m m}{\cv@studentItem{#1}{#2}[REU student from #3]}

\NewDocumentCommand{\cv@studentItem}{m m o o}{
	\cv@twoColumnItemRight
		{{\cv@itemDetailsStyle #1\IfValueT{#3}{, #3}\IfValueT{#4}{\\#4}}}
		{{\cv@itemExtraInfoStyle #2}}
}


%-------------------------------------------------------------------------------
%                Honors
%-------------------------------------------------------------------------------
%\honor{name%text}{organization%text}{year%text}#/honors

\cv@newItemListEnvironment{honors}{\cv@itemseptight}[\def\honor{\cv@addItemSeperator\cv@honorItem}]
\NewDocumentCommand{\cv@honorItem}{m m m}{
	\cv@twoColumnItemLeft	
		{\cv@itemDetailsStyle #3}
		{{\cv@itemSubtitleStyle #1}\\{\cv@itemDetailsStyle #2}}
}


%-------------------------------------------------------------------------------
%                Skills
%-------------------------------------------------------------------------------
%\skill{name%text}{details%text}#/skills

\cv@newItemListEnvironment{skills}{\cv@itemsepverytight}[\def\skill{\cv@addItemSeperator\cv@skillItem}]
\NewDocumentCommand{\cv@skillItem}{m m o}{
	\cv@twoColumnItemLeft[\cv@defaultRightColumnSize]
		{\raggedleft\cv@itemTitleStyle #1}
		{
			#2
			\IfValueT{#3}{
				\begingroup
				\setlist[itemize]{topsep=.25\parsep,parsep=0pt}
				\begin{itemize}#3\end{itemize}
				\vspace{\cv@itemsepverytight}
				\endgroup
			}
		}
}

%-------------------------------------------------------------------------------
%                Affiliations
%-------------------------------------------------------------------------------
%\affiliation{role%text}{organization%text}[dates%text]#/affiliations

\cv@newItemListEnvironment{affiliations}{\cv@itemsepverytight}[\def\affiliation{\cv@addItemSeperator\cv@affiliationItem}]
\NewDocumentCommand{\cv@affiliationItem}{ m m o }{
	\cv@twoColumnItemRight
		{{\cv@itemDetailsStyle #1, }{\cv@itemTitleStyle #2}}
		{{\cv@itemExtraInfoStyle \IfValueT{#3}{#3}}}
}
\endinput