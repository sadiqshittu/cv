% CWL for nsf-proposal
%
% Author:
% Scott Ruoti <ruoti@utk.edu>
%
% Notes:
%
% Class license:
% MIT

#include:xparse
#include:formatting
#include:fast-todo

#include:geometry

## Project commands
\program{name}
\project{name}

## Summary-specific items
#ifOption:summary

#include:titlesec
#include:ulem

#endif

## Description-specific items
#ifOption:description

#include:cite
#include:titlesec
#include:ulem
#include atbegshi

#include:adjustbox
#include:pgfgantt

## Gantt timeline
\begin{timeline}[options]{start tss}{end tss}
\end{timeline}

# Gantt elements

\ganttaim{text}{start tss}{end tss}
\ganttaim[options]{text}{start tss}{end tss}

\gantttask[options]{text}{start tss}{end tss}
\gantttask[options]{text}{start tss}{end tss}

\ganttactivity{text}{start tss}{end tss}
\ganttactivity[options]{text}{start tss}{end tss}

\ganttactivitygroup{text}{start tss}{end tss}
\ganttactivitygroup[options]{text}{start tss}{end tss}

\ganttmilestone{start tss}{end tss}
\ganttmilestone[options]{start tss}{end tss}

# Command variants for Gannt elements

\aim{text}{start tss}{end tss}
\aim[options]{text}{start tss}{end tss}

\task{text}
\task[options]{text}
\task[options]{text}[start tss][end tss]

\activity{color}{start tss}{end tss}
\activity[text]{color}{start tss}{end tss}
\activity[options][text]{color}{start tss}{end tss}

\activitybox{start tss}{end tss}
\activitybox[options]{start tss}{end tss}
\activitybox[options][inner text%text]{start tss}{end tss}
\activitybox*{start tss}{end tss}
\activitybox*[options]{start tss}{end tss}
\activitybox*[options][inner text%text]{start tss}{end tss}

\milestone{end tss}
\milestone[options]{end tss}

# Activity group commands

\begin{activitygroup}{start tss}
\begin{activitygroup}[options]{start tss}
\begin{activitygroup}[options][inner text%text]{start tss}
\end{activitygroup}

\begin{activitygroup*}{start tss}
\begin{activitygroup*}[options]{start tss}
\begin{activitygroup*}[options][inner text%text]{start tss}
\end{activitygroup*}

\agactivity{color}{duration}#/activitygroup
\agactivity[text]{color}{duration}#/activitygroup
\agactivity[options][text]{color}{duration}#/activitygroup

\agmilestone#/activitygroup
\agmilestone[options]#/activitygroup

#endif

## Budget-specific items
#ifOption:budget

#include:adjustbox
#include:array
#include:hhline
#include:makecell
#include:multirow

\begin{inline-table}
\end{inline-table}

\head{text}
\multi[rows]{text}
\multihead[rows]{text}

#endif
