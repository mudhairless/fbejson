@echo Clearing Old Build Files
del src\*.o
del lib\*.a
del tests\*.exe

@echo Building Components
%fbc% -c -i inc -w all -g -exx src/base64.bas
%fbc% -c -i inc -w all -g -exx src/array.bas
%fbc% -c -i inc -w all -g -exx src/object.bas
%fbc% -c -i inc -w all -g -exx src/pair.bas
%fbc% -c -i inc -w all -g -exx src/value.bas

@echo Building Libraries
%fbc% -lib src/base64.o -x lib\libfbbase64.a
%fbc% -lib src/array.o src/object.o src/pair.o src/value.o -x lib/libfbjson.a

@echo Running Tests
%fbc% -p lib -i inc -w all -g -exx tests/base64.bas
tests\base64.exe
%fbc% -p lib -i inc -w all -g -exx tests/json.bas 
tests\json.exe