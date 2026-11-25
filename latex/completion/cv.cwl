% CWL for cv
%
% Author:
% Scott Ruoti <ruoti@utk.edu>
%
% Notes:
%
% Class license:
% MIT

#include:formatting

#include:bold-extra
#include:calc
#include:cite
#include:fancyhdr
#include:fontawesome
#include:lastpage
#include:listofitems
#include:titlesec
#include:xparse
#include:xstring

## Personal info
\name{full name}
\researchinterests{research interests; comma separated}
\address{mailing address}
\mobile{mobile phone number}
\email{email address}
\homepage{url w/o schema}
\github{id}
\gitlab{id}
\stackoverflow{id}{name}
\linkedin{id}
\twitter{handle}
\skype{id}
\extrainfo{info}


## CV items
\begin{degrees}
\end{degrees}
\degree{degree%text}{university%text}{date%text}{additional info%text}[itemized details%text]#/degrees

\begin{experience}
\end{experience}
\experience{position%text}{employer%text}{location%text}{dates%text}[itemized details%text]#/experience

\begin{funding}
\end{funding}
\grant{role%text}{title%text}{funder%text}{amount}[personal amount]{dates%text}[itemized details%text]#/funding

\begin{publications}
\end{publications}
\journal{title%text}{authors%text}{venue short-name}[acceptance rate]{proceedings name}{publication details%text}#/publications
\proceedings{title%text}{authors%text}{venue short-name}[acceptance rate]{proceedings name}{publication details%text}#/publications
\poster{title%text}{authors%text}{venue short-name}[acceptance rate]{proceedings name}[publication details%text]#/publications

\begin{presentations}
\end{presentations}
\presentation{title%text}{type}{location}{date}#/presentations

\begin{servicelist}
\end{servicelist}
\service{organization%text}{description%text}[location%text]#/servicelist

\begin{teaching}
\end{teaching}
\course{name%text}{number}{semester%text}#/teaching

\begin{phdstudents}
\end{phdstudents}
%\phd{name%text}{graduation semester%text}{dissertation title%text}[current position%text]#/phdstudents

\begin{msstudents}
\end{msstudents}
%\msthesis{name%text}{graduation semester%text}{thesis title%text}[current position%text]#/msstudents
%\msproject{name%text}{graduation semester%text}{project title%text}[current position%text]#/msstudents
%\mscourse{name%text}{graduation semester%text}[current position%text]#/msstudents

\begin{ugstudents}
\end{ugstudents}
%\ug{name%text}{graduation semester%text}[current position%text]#/ugstudents
%\reu{name%text}{graduation semester%text}{}home institution%text}#/ugstudents

\begin{honors}
\end{honors}
\honor{name%text}{organization%text}{year%text}#/honors

\begin{skills}
\end{skills}
\skill{name%text}{details%text}#/skills
