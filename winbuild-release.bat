@IF "%fbc%"=="" (
    @echo Please run SET FBC=fbc32 or your preferred compiler first
    @goto :eof
)

@echo Clearing Old Build Files
del src\*.o
del lib\*.a
del tests\*.exe

@echo Building Components
%fbc% -c -i inc -w all  -exx src/base64.bas
%fbc% -c -i inc -w all  -exx src/array.bas
%fbc% -c -i inc -w all  -exx src/object.bas
%fbc% -c -i inc -w all  -exx src/pair.bas
%fbc% -c -i inc -w all  -exx src/value.bas

@echo Building Libraries
%fbc% -lib src/base64.o -x lib\libfbebase64.a
%fbc% -lib src/array.o src/object.o src/pair.o src/value.o -x lib/libfbejson.a

@echo Running Tests
%fbc% -p lib -i inc -w all  -exx tests/base64.bas
tests\base64.exe
%fbc% -p lib -i inc -w all  -exx tests/json.bas 
tests\json.exe