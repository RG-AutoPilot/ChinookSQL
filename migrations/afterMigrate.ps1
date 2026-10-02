# Flyway callback: runs after every successful `flyway migrate`.
# Deploys the SSIS project (.ispac) to SSISDB, then runs the load package.
# Skips quietly if the SSIS pieces aren't present, so migrate still works elsewhere.

$IspacPath   = Join-Path $PSScriptRoot '..\SSIS\ChinookETL\bin\Development\ChinookETL.ispac'
$FolderName  = 'ChinookDemo'
$ProjectName = 'ChinookETL'
$PackageName = 'LoadGenres.dtsx'

# Server comes from the Flyway environment that is being migrated
if ($env:FLYWAY_URL -notmatch 'sqlserver://([^;]+)') { Write-Host 'SSIS: no SQL Server URL, skipping'; return }
$Server = $Matches[1]
if ($env:FLYWAY_URL -notmatch 'databaseName=([^;]+)') { Write-Host 'SSIS: no databaseName in URL, skipping'; return }
$Database = $Matches[1]
$ConnMgr  = '{3D4C2762-0215-4726-9B1B-F9EE776FC0C6}'   # ID of the ADO.NET connection manager in LoadGenres.dtsx (name has a dot, which the path parser dislikes)

if (-not (Test-Path $IspacPath)) { Write-Host "SSIS: $IspacPath not found, skipping"; return }

$Wizard = Get-ChildItem 'C:\Program Files*\Microsoft SQL Server\*\DTS\Binn\ISDeploymentWizard.exe' -ErrorAction SilentlyContinue |
    Sort-Object FullName -Descending | Select-Object -First 1
if (-not $Wizard) { Write-Host 'SSIS: ISDeploymentWizard.exe not found (install Integration Services), skipping'; return }

# Make sure the target folder exists (the wizard needs it)
sqlcmd -S $Server -E -C -b -Q "IF NOT EXISTS (SELECT 1 FROM SSISDB.catalog.folders WHERE name = N'$FolderName') EXEC SSISDB.catalog.create_folder @folder_name = N'$FolderName';"
if ($LASTEXITCODE -ne 0) { throw 'SSIS: could not create SSISDB folder' }

Write-Host "SSIS: deploying $ProjectName to $Server/SSISDB/$FolderName"
& $Wizard.FullName /Silent /SourcePath:"$((Resolve-Path $IspacPath).Path)" /DestinationServer:$Server /DestinationPath:"/SSISDB/$FolderName/$ProjectName"
if ($LASTEXITCODE -ne 0) { throw "SSIS deploy failed (exit $LASTEXITCODE)" }

Write-Host "SSIS: running $PackageName against $Database"
$Sql = @"
SET NOCOUNT ON;
DECLARE @id BIGINT;
EXEC SSISDB.catalog.create_execution @folder_name=N'$FolderName', @project_name=N'$ProjectName', @package_name=N'$PackageName', @use32bitruntime=0, @execution_id=@id OUTPUT;
EXEC SSISDB.catalog.set_execution_parameter_value @id, 50, N'SYNCHRONIZED', 1;
EXEC SSISDB.catalog.set_execution_property_override_value @id, N'\Package.Connections[$ConnMgr].Properties[ConnectionString]', N'Data Source=$Server;Initial Catalog=$Database;Integrated Security=True;TrustServerCertificate=True;', 0;
EXEC SSISDB.catalog.start_execution @id;
SELECT CASE status WHEN 7 THEN 'Succeeded' ELSE 'FAILED (status ' + CAST(status AS VARCHAR(5)) + ')' END
FROM SSISDB.catalog.executions WHERE execution_id = @id;
IF (SELECT status FROM SSISDB.catalog.executions WHERE execution_id=@id) <> 7 RAISERROR('SSIS package failed, execution_id %I64d', 16, 1, @id);
"@
sqlcmd -S $Server -E -C -b -h -1 -Q $Sql
if ($LASTEXITCODE -ne 0) { throw 'SSIS package run failed' }
