
@ECHO OFF
SETLOCAL
REM Parameter parsing taken from the 'FooBar parameter demo' by Garret Wilson
REM (https://stackoverflow.com/questions/26551/how-can-i-pass-arguments-to-a-batch-file/50653047#50653047)

SET SCENARIO=%~1

IF "%SCENARIO%" == "" (
  GOTO usage
)

SET DEBUG=false
SET AUTOSTART=false
SET APP=discobats-sim-root-0.1-SNAPSHOT.jar
SET LIBRARY=

SHIFT
:args
SET PARAM=%~1
SET ARG=%~2

IF "%PARAM%" == "--lib" (
ECHO
  SHIFT
  IF NOT "%ARG%" == "" (
    SET LIBRARY=%ARG%
    SHIFT
  )
) ELSE IF "%PARAM%" == "--direct" (
  SHIFT
  SET AUTOSTART=true

) ELSE IF "%PARAM%" == "--debug" (
  SHIFT
  SET DEBUG=true
  
) ELSE IF "%PARAM%" == "" (
  GOTO endargs
  
) ELSE (
  ECHO:
  ECHO unrecognized option %1. 1>&2
  ECHO:
  GOTO usage
)
GOTO args
:endargs

REM DO SOMETHING BELOW

IF NOT "%APP%" == "" (
  SET APP_COMMAND= -jar %APP%
  SET AGENT_COMMAND= -javaagent:%APP%
)
IF "%DEBUG%" == "true" (
  SET DEBUG_COMMAND= -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=y
)

IF NOT "%LIBRARY%" == "" (
  SET LIBRARY_COMMAND= -lib %LIBRARY%
)
IF "%AUTOSTART%" == "true" (
  SET AUTOSTART_COMMAND= -a
)

SET START_COMMAND=java
SET START_COMMAND=%START_COMMAND% -Xms512m -Xmx2048m -XX:+HeapDumpOnOutOfMemoryError
SET START_COMMAND=%START_COMMAND% -Djava.net.preferIPv4Stack=true -Dlog4j2.skipJansi=false
SET START_COMMAND=%START_COMMAND%%DEBUG_COMMAND%
SET START_COMMAND=%START_COMMAND%%AGENT_COMMAND%
SET START_COMMAND=%START_COMMAND%%APP_COMMAND%
SET START_COMMAND=%START_COMMAND% -s %SCENARIO%
SET START_COMMAND=%START_COMMAND%%LIBRARY_COMMAND%
SET START_COMMAND=%START_COMMAND%%AUTOSTART_COMMAND%

CALL %START_COMMAND%
REM ECHO test %START_COMMAND%

REM java
REM "-Xms512m" "-Xmx2048m" "-XX:+HeapDumpOnOutOfMemoryError"
REM "-Djava.net.preferIPv4Stack=true" "-Dlog4j2.skipJansi=false"
REM "-javaagent:server-0.1-SNAPSHOT.jar"
REM -jar "server-0.1-SNAPSHOT.jar"
REM -s "..\assets\scenarios\local\scenario_local_scenery_observed_actorProxy_MTS.xml"
REM -a

REM %DEBUG%
REM %LIBRARY%

REM DO SIMETHING ABOVE

GOTO :eof

:usage
ECHO ============================
ECHO ^|^| DisCo-BaTS - START.CMD ^|^|
ECHO ============================
ECHO:
ECHO USAGE / ORDER:     ./START.CMD ^<path.xml^> [--direct] [--lib [^<path.jar^>]] [--debug]
ECHO:
ECHO ^<path.xml^>         path to a valid scenario xml file that should be simulated (REQUIRED)
ECHO --direct           directly start the simulation of the given scenario
ECHO --lib ^<path.jar^>   path to a library that is to be used instead of the one defined in the scenario file (OPTIONAL)
ECHO --debug            start java in debug mode to be able to attach a remote debugger to port 8000 (OPTIONAL)
ECHO:

EXIT /B 1