
cd ../../../../..

set "interactive=-it"
set "port=-p 23144:23144"
set "image=dvdrhr/discobats:wan_router_2.1.3"

call docker run %interactive% %port% %image%

exit /B

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%