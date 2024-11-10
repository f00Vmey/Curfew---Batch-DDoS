@echo off
setlocal enabledelayedexpansion

:: Prompt for the target web domain
set /p target=Enter the target web domain (e.g., yourtargetdomain.com): 

:: Verify that the user entered a domain
if "%target%"=="" (
    echo You must enter a valid domain. Exiting...
    pause
    exit /b
)

:: Check if the wordlist exists
if not exist directories.txt (
    echo Wordlist file 'directories.txt' not found. Exiting...
    pause
    exit /b
)

:: Loop through each word in the wordlist
for /f "tokens=*" %%a in (directories.txt) do (
    set dir=%%a
    echo Trying directory: !dir!

    :: Use curl to check if the directory exists and handle redirects, adding a user-agent to mimic a real browser
    for /f %%b in ('curl -s -L -o nul -w "%%{http_code}" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" https://%target%/!dir!/') do set status=%%b

    :: Check if the HTTP status code is 200 (found)
    if !status! == "200" (
        echo [FOUND] Directory !dir! found!
    ) else (
        echo [NOT FOUND] Directory !dir! does not exist or returned status !status!.
    )
)

echo Brute-forcing completed.
pause
endlocal
