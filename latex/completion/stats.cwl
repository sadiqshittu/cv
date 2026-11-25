% CWL for stats
%
% Author:
% Scott Ruoti <ruoti@utk.edu>
%
% Notes:
%
% Class license:
% MIT

#include:listofitems
#include:pgfkeys
#include:siunitx
#include:xfp
#include:xparse

## Settings
\statsoptions{%<options%>}


## Basic calculations
\calc{expression}
\calc[%<options%>]{expression}


## Descriptive statistics
\percent{count}
\percent[%<options%>]{count}
\proportion{count}
\proportion[%<options%>]{count}
\proportion*{count}
\proportion*[%<options%>]{count}
\confidenceinterval{value}{delta}
\confidenceinterval[%<options%>]{value}{delta}
\confidenceinterval*{value}{delta}
\confidenceinterval*[%<options%>]{value}{delta}


## Comparing means
\reportp{p value}
\reportp[%<options%>]{p value}
\reportp*{p value}
\reportp*[%<options%>]{p value}

\ttest{degrees of freedom}{z score}{p value}
\ttest[%<options%>]{degrees of freedom}{z score}{p value}
\ttest*{degrees of freedom}{z score}{p value}
\ttest*[%<options%>]{degrees of freedom}{z score}{p value}

\anova{degrees of freedom IV1}{degrees of freedom IV2}{F score}{p value}
\anova[%<options%>]{degrees of freedom IV1}{degrees of freedom IV2}{F score}{p value}
\anova*{degrees of freedom IV1}{degrees of freedom IV2}{F score}{p value}
\anova*[%<options%>]{degrees of freedom IV1}{degrees of freedom IV2}{F score}{p value}


## Non-parametric tests
\chisq{degrees of freedom}{z score}{p value}
\chisq[%<options%>]{degrees of freedom}{z score}{p value}
\chisq*{degrees of freedom}{z score}{p value}
\chisq*[%<options%>]{degrees of freedom}{z score}{p value}


## Key/value pairs

#keyvals:\statsoptions
precision=
sample size=
alpha values=
p adjust=
p precision=
#endkeyvals

#keyvals:\calc,\confidenceinterval,\confidenceinterval*
precision=
#endkeyvals

#keyvals:\percent,\proportion,\proportion*
precision=
sample size=
#endkeyvals

#keyvals:\reportp,\reportp*
precision=
alpha values=
p adjust=
p precision=
#endkeyvals

#keyvals:\ttest,\ttest*,\anova,\anova*,\chisq,\chisq*
precision=
alpha values=
p adjust=
p precision=
score precision=
#endkeyvals
