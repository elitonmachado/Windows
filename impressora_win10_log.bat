@echo off
rem Este script executa adições no registro para configurações de impressora e outras opções no Windows 10, gerando log em C:\programas

rem Defina o caminho do log
set log_file=C:\logs\registro_log.txt

rem Cria o diretório C:\programas se ele não existir
if not exist C:\programas mkdir C:\programas

rem Inicia o log
echo Iniciando script de configuração de registro > "%log_file%"
echo ============================================ >> "%log_file%"
echo %date% %time% >> "%log_file%"
echo ============================================ >> "%log_file%"

rem ------------------------------
rem Configurações para Impressora
rem ------------------------------

rem Adiciona a entrada RpcAuthnLevelPrivacyEnabled com o valor 0 na chave especificada.
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f >> "%log_file%" 2>&1

rem Adiciona a entrada SplWOW64TimeOutSeconds com o valor 0x3c na chave especificada no Registro.
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v SplWOW64TimeOutSeconds /t REG_DWORD /d 0x3c /f >> "%log_file%" 2>&1

rem Adiciona a entrada 713073804 com o valor 0 na chave especificada no Registro.
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 713073804 /t REG_DWORD /d 0 /f >> "%log_file%" 2>&1

rem ------------------------------
rem Configurações Adicionais
rem ------------------------------

rem 1. Adiciona a entrada DnsOnWire com o valor 1
set reg_key=HKEY_LOCAL_MACHINE\system\currentcontrolset\control\print
set reg_value=DnsOnWire
set reg_type=REG_DWORD
set reg_data=1

reg add "%reg_key%" /v %reg_value% /t %reg_type% /d %reg_data% /f >> "%log_file%" 2>&1

if %errorlevel% equ 0 (
    echo DnsOnWire adicionado com sucesso. >> "%log_file%"
) else (
    echo Falha ao adicionar DnsOnWire. >> "%log_file%"
)

rem 2. Adiciona a entrada DisableStrictNameChecking com o valor 1
set reg_key=HKEY_LOCAL_MACHINE\system\currentcontrolset\services\lanmanserver\parameters
set reg_value=DisableStrictNameChecking
set reg_type=REG_DWORD
set reg_data=1

reg add "%reg_key%" /v %reg_value% /t %reg_type% /d %reg_data% /f >> "%log_file%" 2>&1

if %errorlevel% equ 0 (
    echo DisableStrictNameChecking adicionado com sucesso. >> "%log_file%"
) else (
    echo Falha ao adicionar DisableStrictNameChecking. >> "%log_file%"
)

rem 3. Adiciona a entrada OptionalNames com o valor "aliasname"
set reg_key=HKEY_LOCAL_MACHINE\system\currentcontrolset\services\lanmanserver\parameters
set reg_value=OptionalNames
set reg_type=REG_SZ
set reg_data="aliasname"

reg add "%reg_key%" /v %reg_value% /t %reg_type% /d %reg_data% /f >> "%log_file%" 2>&1

if %errorlevel% equ 0 (
    echo OptionalNames adicionado com sucesso. >> "%log_file%"
) else (
    echo Falha ao adicionar OptionalNames. >> "%log_file%"
)

echo Script concluído em %date% %time% >> "%log_file%"
echo Todas as entradas foram processadas. >> "%log_file%"

echo Log gerado em %log_file%
