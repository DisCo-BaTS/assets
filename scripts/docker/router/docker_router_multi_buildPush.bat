
cd ../../../../..

REM set "builder=buildx"
set "builder="
set "platform=--platform linux/amd64,linux/arm64/v8"
REM set "output=--output type=docker"
set "tag=-t dvdrhr/discobats:wan_router"
set "file=-f ./modules/simulation/tools/router/Dockerfile"
set "push=--push"
set "context=./modules/simulation/tools/router"

call docker build %builder% %tag% %file% %platform% %output% %push% %context%

exit /B

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%