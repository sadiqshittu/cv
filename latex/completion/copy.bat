@ECHO OFF
for %%f in (*.cwl) do (
  if exist %appdata%\texstudio\completion\user\%%~nxf (
    del %appdata%\texstudio\completion\user\%%~nxf
  )
  copy %%~ff %appdata%\texstudio\completion\user\%%~nxf
)
