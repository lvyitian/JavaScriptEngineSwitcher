set project_name=JavaScriptEngineSwitcher.ChakraCore
set project_source_dir=..\..\src\%project_name%
set project_bin_dir=%project_source_dir%\bin\Release
set binaries_dir=..\..\Binaries\ChakraCore
set licenses_dir=..\..\Licenses
set nuget_package_manager=..\..\.nuget\nuget.exe

call "..\setup.cmd"

rmdir lib /Q/S
rmdir runtimes /Q/S

del chakra-core-license.txt /Q/S
del chakra-samples-license.txt /Q/S
del jsrt-dotnet-license.txt /Q/S

%net40_msbuild% "%project_source_dir%\%project_name%.Net40.csproj" /p:Configuration=Release
xcopy "%project_bin_dir%\%project_name%.dll" lib\net40-client\
xcopy "%project_bin_dir%\ru-ru\%project_name%.resources.dll" lib\net40-client\ru-ru\

%dotnet_cli% build "%project_source_dir%" --framework net452 --configuration Release --no-dependencies --no-incremental
xcopy "%project_bin_dir%\net452\%project_name%.dll" lib\net452\
xcopy "%project_bin_dir%\net452\%project_name%.xml" lib\net452\
xcopy "%project_bin_dir%\net452\ru-ru\%project_name%.resources.dll" lib\net452\ru-ru\

%dotnet_cli% build "%project_source_dir%" --framework netstandard1.3 --configuration Release --no-dependencies --no-incremental
xcopy "%project_bin_dir%\netstandard1.3\%project_name%.dll" lib\netstandard1.3\
xcopy "%project_bin_dir%\netstandard1.3\%project_name%.xml" lib\netstandard1.3\
xcopy "%project_bin_dir%\netstandard1.3\ru-ru\%project_name%.resources.dll" lib\netstandard1.3\ru-ru\

xcopy "%binaries_dir%\x86\ChakraCore.dll" runtimes\win7-x86\native\
xcopy "%binaries_dir%\x64\ChakraCore.dll" runtimes\win7-x64\native\

copy "%licenses_dir%\chakra-core-license.txt" chakra-core-license.txt /Y
copy "%licenses_dir%\chakra-samples-license.txt" chakra-samples-license.txt /Y
copy "%licenses_dir%\jsrt-dotnet-license.txt" jsrt-dotnet-license.txt /Y

%nuget_package_manager% pack "..\%project_name%\%project_name%.nuspec"