call minikube image rm <IMAGE_APPLICATION_REMOTE>  || goto :error
call minikube image rm <IMAGE_APPLICATION_ROOT>  || goto :error
call minikube image rm <IMAGE_APPLICATION_ROUTER>  || goto :error

call minikube image load <IMAGE_APPLICATION_REMOTE>  || goto :error
call minikube image load <IMAGE_APPLICATION_ROOT>  || goto :error
call minikube image load <IMAGE_APPLICATION_ROUTER>  || goto :error

exit /b 0

:error
exit /b %errorlevel%