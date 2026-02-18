
cd ../../../../..

set "tag=-t dvdrhr/discobats:wan_router"
set "file=-f ./modules/simulation/tools/router/Dockerfile"
set "push=--push"
set "context=./modules/simulation/tools/router"

call docker build %tag% %file% %platform% %output% %push% %context%


exit /B

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%