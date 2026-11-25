% CWL for tables
%
% Author:
% Scott Ruoti <ruoti@utk.edu>
%
% Notes:
%
% Class license:
% MIT

#include:adjustbox
#include:array
#include:hhline
#include:multirow
#include:xcolor
#include:xparse

# Table commands
\rowheader{text}#t
\rowmultiheader{rowcount}{text}#t

\columnheader{text}#t
\columnhline#t
\columnhline[length]#t

\cell{alignment}{text}#t

\colorcells
\colorcells{startindex}
\colorcells{startindex}{firstcolor}{secondcolor}

\significant#t

# Table symbols
\sfull
\spart
\snone
\sna

\sgood
\sbad
\ssupported
\sunsupported
\soptional

# Ratings tables
\setupratingstable