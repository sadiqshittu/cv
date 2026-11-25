# LaTeX

This repository contains class files, packages, and bibliographies for use in creating research papers.

To use, you will need to setup the proper load directories by putting the following before your document class:
```latex
\makeatletter\def\input@path{{latex/classes/}{latex/styles/}{latex/bibtex/}}\makeatother % Set load paths
```

## Classes
* **nsf-proposal**: Used to create grant proposals for the NSF.

## Packages
The following packages are available:
* **formatting**: Sets up various text formatting packages to enhance the look and feel of the papers.
* **stats**: Package to use when reporting statistics. Ensures that consistent precision and style is used for reporting all values.
* **tables**: Provides commands to enable more advanced tables, including ratings tables.
* **todo**: Supports the insertion of todo notes.

## Bibliographies
To be added later

## Completion
To get completion in TexStudio, you will need to move the files in `completion/` to the user cwl directory. This can be done manually or using the included scripts.
