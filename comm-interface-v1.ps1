Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore

# Ustawienia responsywne na podstawie rozdzielczości ekranu
$screen = [System.Windows.SystemParameters]::PrimaryScreenHeight
$screenWidth = [System.Windows.SystemParameters]::PrimaryScreenWidth
$scale = if ($screen -ge 2160) { 1.8 } elseif ($screen -ge 1440) { 1.3 } else { 1.0 }

$windowHeight = 700 * $scale
$windowWidth = 900 * $scale
$buttonHeight = 80 * $scale
$buttonFontSize = 13 * $scale
$outputFontSize = 11 * $scale
$mainMargin = 15 * $scale

[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:sys="clr-namespace:System;assembly=mscorlib"
        Title="Konserwacja Windows 11" 
        Height="$windowHeight" Width="$windowWidth"
        WindowStartupLocation="CenterScreen"
        Background="{DynamicResource SystemControlBackgroundChromeMediumLowBrush}"
        Foreground="{DynamicResource SystemControlForegroundBaseHighBrush}"
        FontFamily="Segoe UI"
        ResizeMode="CanResize">
    
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Background" Value="{DynamicResource SystemControlBackgroundListMediumBrush}"/>
            <Setter Property="Foreground" Value="{DynamicResource SystemControlForegroundBaseHighBrush}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="BorderBrush" Value="{DynamicResource SystemControlForegroundBaseMediumLowBrush}"/>
            <Setter Property="Padding" Value="12"/>
            <Setter Property="FontSize" Value="$buttonFontSize"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                CornerRadius="4"
                                Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="{DynamicResource SystemControlBackgroundListLowBrush}"/>
                                <Setter Property="BorderBrush" Value="{DynamicResource SystemControlForegroundBaseHighBrush}"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter Property="Background" Value="{DynamicResource SystemControlAccentBrush}"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <Style TargetType="TextBox">
            <Setter Property="Background" Value="{DynamicResource SystemControlBackgroundChromeMediumBrush}"/>
            <Setter Property="Foreground" Value="{DynamicResource SystemControlForegroundBaseHighBrush}"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="BorderBrush" Value="{DynamicResource SystemControlForegroundBaseMediumLowBrush}"/>
            <Setter Property="Padding" Value="12"/>
            <Setter Property="FontSize" Value="$outputFontSize"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="VerticalScrollBarVisibility" Value="Auto"/>
        </Style>
    </Window.Resources>
    
    <Grid Margin="$mainMargin">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        
        <!-- Header -->
        <StackPanel Grid.Row="0" Margin="0,0,0,15">
            <TextBlock Text="Narzędzie Konserwacji Windows 11" 
                       FontSize="20" FontWeight="SemiBold"
                       Foreground="{DynamicResource SystemControlForegroundBaseHighBrush}"/>
            <TextBlock Text="Wybierz operację naprawczą poniżej" 
                       FontSize="13" Opacity="0.8"
                       Foreground="{DynamicResource SystemControlForegroundBaseMediumBrush}"
                       Margin="0,5,0,0"/>
        </StackPanel>
        
        <!-- Buttons ScrollViewer -->
        <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto" Margin="0,0,0,15">
            <StackPanel>
                <Button Name="btnSFC" Height="$buttonHeight" Margin="0,0,0,10">
                    <StackPanel VerticalAlignment="Center">
                        <TextBlock TextAlignment="Center" FontWeight="SemiBold" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="🔧 SKANUJ I NAPRAW SYSTEM"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="11" Opacity="0.8" Margin="0,5,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="SFC /SCANNOW + DISM /RESTOREHEALTH"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="10" Opacity="0.6" Margin="0,3,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="⚠ Wymaga restartu systemu"/>
                        </TextBlock>
                    </StackPanel>
                </Button>

                <Button Name="btnWMI" Height="$buttonHeight" Margin="0,0,0,10">
                    <StackPanel VerticalAlignment="Center">
                        <TextBlock TextAlignment="Center" FontWeight="SemiBold" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="📋 NAPRAW REPOZYTORIUM WMI"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="11" Opacity="0.8" Margin="0,5,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="WINMGMT /VERIFYREPOSITORY + /SALVAGEREPOSITORY"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="10" Opacity="0.6" Margin="0,3,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="⚠ Wymaga restartu systemu"/>
                        </TextBlock>
                    </StackPanel>
                </Button>

                <Button Name="btnNET" Height="$buttonHeight" Margin="0,0,0,10">
                    <StackPanel VerticalAlignment="Center">
                        <TextBlock TextAlignment="Center" FontWeight="SemiBold" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="🌐 NAPRAW KARTY SIECIOWE"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="11" Opacity="0.8" Margin="0,5,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="NETSH INT IP RESET + WINSOCK RESET"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="10" Opacity="0.6" Margin="0,3,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="⚠ Wymaga restartu systemu"/>
                        </TextBlock>
                    </StackPanel>
                </Button>

                <Button Name="btnIP" Height="$buttonHeight" Margin="0,0,0,0">
                    <StackPanel VerticalAlignment="Center">
                        <TextBlock TextAlignment="Center" FontWeight="SemiBold" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="🔄 ODŚWIEŻ ADRES IP I DNS"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="11" Opacity="0.8" Margin="0,5,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="IPCONFIG /RELEASE + /FLUSHDNS + /RENEW"/>
                        </TextBlock>
                        <TextBlock TextAlignment="Center" FontSize="10" Opacity="0.6" Margin="0,3,0,0" Foreground="{Binding RelativeSource={RelativeSource AncestorType=Button}, Path=Foreground}">
                            <Run Text="✓ Nie wymaga restartu"/>
                        </TextBlock>
                    </StackPanel>
                </Button>
            </StackPanel>
        </ScrollViewer>
        
        <!-- Output Panel -->
        <Border Grid.Row="2" 
                Background="{DynamicResource SystemControlBackgroundChromeMediumBrush}"
                BorderThickness="1"
                BorderBrush="{DynamicResource SystemControlForegroundBaseMediumLowBrush}"
                CornerRadius="4"
                Padding="12"
                Height="250">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                
                <Grid Grid.Row="0" Margin="0,0,0,8">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    
                    <TextBlock Text="Wyjście operacji:" 
                               FontSize="12" FontWeight="SemiBold"
                               Foreground="{DynamicResource SystemControlForegroundBaseHighBrush}"/>
                    
                    <Button Name="btnExportLogs" 
                            Grid.Column="1"
                            Height="32"
                            Padding="12,6"
                            FontSize="11">
                        <TextBlock Text="💾 Eksportuj logi"/>
                    </Button>
                </Grid>
                
                <TextBox Name="txtOutput" 
                         Grid.Row="1"
                         IsReadOnly="True" 
                         TextWrapping="Wrap"
                         AcceptsReturn="True"
                         VerticalAlignment="Stretch"/>
                
                <TextBlock Name="txtStatusExport"
                           Grid.Row="2"
                           FontSize="10"
                           Opacity="0.6"
                           Margin="0,8,0,0"
                           Foreground="{DynamicResource SystemControlForegroundBaseMediumBrush}"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

$restartNeeded = $false
$isProcessing = $false

$reader=(New-Object System.Xml.XmlNodeReader $XAML)
$Window=[Windows.Markup.XamlReader]::Load($reader)

function Write-FormattedOutput {
    param(
        [string]$Message,
        [string]$Type = "info"
    )
    
    $timestamp = Get-Date -Format "HH:mm:ss"
    $txtOutput = $Window.FindName("txtOutput")
    
    $prefix = switch($Type) {
        "info"    { "ℹ️  " }
        "success" { "✅ " }
        "warning" { "⚠️  " }
        "error"   { "❌ " }
        "step"    { "▶️  " }
        default   { "• " }
    }
    
    $formattedMsg = "[$timestamp] $prefix$Message`n"
    $txtOutput.AppendText($formattedMsg)
    $txtOutput.ScrollToEnd()
}

function Clear-Output {
    $Window.FindName("txtOutput").Clear()
}

function Disable-AllButtons {
    $Window.FindName("btnSFC").IsEnabled = $false
    $Window.FindName("btnWMI").IsEnabled = $false
    $Window.FindName("btnNET").IsEnabled = $false
    $Window.FindName("btnIP").IsEnabled = $false
}

function Enable-AllButtons {
    $Window.FindName("btnSFC").IsEnabled = $true
    $Window.FindName("btnWMI").IsEnabled = $true
    $Window.FindName("btnNET").IsEnabled = $true
    $Window.FindName("btnIP").IsEnabled = $true
}

# Obsługa przycisku SFC
$Window.FindName("btnSFC").Add_Click({
    Clear-Output
    Write-FormattedOutput "Uruchamianie skanowania i naprawy systemu..." "step"
    Write-FormattedOutput "To może potrwać kilka minut..." "info"
    
    Disable-AllButtons
    
    try {
        Write-FormattedOutput "Etap 1/2: Uruchamianie SFC /SCANNOW..." "step"
        $sfcOutput = cmd /c "sfc /scannow 2>&1"
        Write-FormattedOutput $sfcOutput "info"
        
        Write-FormattedOutput "Etap 2/2: Uruchamianie DISM /RESTOREHEALTH..." "step"
        $dismOutput = cmd /c "dism /online /cleanup-image /restorehealth 2>&1"
        Write-FormattedOutput $dismOutput "info"
        
        Write-FormattedOutput "Operacja zakończona sukcesem!" "success"
        $restartNeeded = $true
    }
    catch {
        Write-FormattedOutput "Błąd podczas operacji: $_" "error"
    }
    finally {
        Enable-AllButtons
    }
})

# Obsługa przycisku WMI
$Window.FindName("btnWMI").Add_Click({
    Clear-Output
    Write-FormattedOutput "Sprawdzanie i naprawa repozytorium WMI..." "step"
    
    Disable-AllButtons
    
    try {
        Write-FormattedOutput "Etap 1/2: Weryfikacja repozytorium WMI..." "step"
        $verifyOutput = cmd /c "winmgmt /verifyrepository 2>&1"
        Write-FormattedOutput $verifyOutput "info"

        if ($verifyOutput -match "repository is inconsistent" -or $verifyOutput -match "niespójn") {
            Write-FormattedOutput "Wykryto niespójność w repozytorium!" "warning"
            Write-FormattedOutput "Etap 2/2: Uruchamianie naprawy repozytorium..." "step"
            
            $repairOutput = cmd /c "winmgmt /salvagerepository 2>&1"
            Write-FormattedOutput $repairOutput "info"
            Write-FormattedOutput "Repozytorium zostało naprawione!" "success"
        } else {
            Write-FormattedOutput "Repozytorium WMI jest spójne i nie wymaga naprawy." "success"
        }
        
        $restartNeeded = $true
    }
    catch {
        Write-FormattedOutput "Błąd podczas operacji: $_" "error"
    }
    finally {
        Enable-AllButtons
    }
})

# Obsługa przycisku NETSH
$Window.FindName("btnNET").Add_Click({
    Clear-Output
    Write-FormattedOutput "Resetowanie ustawień kart sieciowych..." "step"
    Write-FormattedOutput "To może potrwać kilka minut..." "info"
    
    Disable-AllButtons
    
    try {
        Write-FormattedOutput "Etap 1/2: Resetowanie stosu TCP/IP..." "step"
        $netshIpOutput = cmd /c "netsh int ip reset 2>&1"
        Write-FormattedOutput $netshIpOutput "info"
        
        Write-FormattedOutput "Etap 2/2: Resetowanie Winsock..." "step"
        $winsockOutput = cmd /c "netsh winsock reset 2>&1"
        Write-FormattedOutput $winsockOutput "info"
        
        Write-FormattedOutput "Operacja zakończona sukcesem!" "success"
        $restartNeeded = $true
    }
    catch {
        Write-FormattedOutput "Błąd podczas operacji: $_" "error"
    }
    finally {
        Enable-AllButtons
    }
})

# Obsługa przycisku IPCONFIG
$Window.FindName("btnIP").Add_Click({
    Clear-Output
    Write-FormattedOutput "Odświeżanie adresu IP i czyszczenie cache DNS..." "step"
    
    Disable-AllButtons
    
    try {
        Write-FormattedOutput "Etap 1/3: Zwalnianie adresu IP..." "step"
        $releaseOutput = cmd /c "ipconfig /release 2>&1"
        Write-FormattedOutput $releaseOutput "info"
        
        Write-FormattedOutput "Etap 2/3: Czyszczenie cache DNS..." "step"
        $flushOutput = cmd /c "ipconfig /flushdns 2>&1"
        Write-FormattedOutput $flushOutput "info"
        
        Write-FormattedOutput "Etap 3/3: Odnawianie adresu IP..." "step"
        $renewOutput = cmd /c "ipconfig /renew 2>&1"
        Write-FormattedOutput $renewOutput "info"
        
        Write-FormattedOutput "Operacja zakończona sukcesem! Sieć zostanie odświeżona." "success"
    }
    catch {
        Write-FormattedOutput "Błąd podczas operacji: $_" "error"
    }
    finally {
        Enable-AllButtons
    }
})

# Obsługa przycisku Eksportuj Logi
$Window.FindName("btnExportLogs").Add_Click({
    try {
        $txtStatus = $Window.FindName("txtStatusExport")
        $txtStatus.Text = "⏳ Przygotowywanie eksportu..."
        
        Export-SystemLogs
    }
    catch {
        $txtStatus.Text = "❌ Błąd podczas eksportu: $_"
    }
})

$Window.Add_Closing({
    if ($restartNeeded) {
        Show-RestartPrompt
    }
})

$Window.ShowDialog()

function Show-RestartPrompt {
    $msgBox = [System.Windows.MessageBox]::Show(
        "Wykonano operacje wymagające restartu systemu.`n`nZalecany jest restart, aby zmiany zostały w pełni zastosowane.",
        "Restart wymagany",
        [System.Windows.MessageBoxButton]::OKCancel,
        [System.Windows.MessageBoxImage]::Information
    )
    
    if ($msgBox -eq "OK") {
        Write-Host "Planowanie restartu systemu za 60 sekund..." -ForegroundColor Cyan
        cmd /c "shutdown /r /t 60 /c `"Restart zaplanowany przez narzędzie naprawy systemu`""
    }
}

function Export-SystemLogs {
    Add-Type -AssemblyName System.Windows.Forms
    
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $defaultFileName = "scan-WIN_$timestamp.txt"
    
    $saveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveFileDialog.Filter = "Pliki tekstowe (*.txt)|*.txt|Wszystkie pliki (*.*)|*.*"
    $saveFileDialog.FileName = $defaultFileName
    $saveFileDialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
    
    $dialogResult = $saveFileDialog.ShowDialog()
    
    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        try {
            $exportPath = $saveFileDialog.FileName
            $txtOutput = $Window.FindName("txtOutput")
            $outputContent = $txtOutput.Text
            $txtStatus = $Window.FindName("txtStatusExport")
            
            $sbReport = New-Object System.Text.StringBuilder
            
            # Header
            $sbReport.AppendLine("=== RAPORT NAPRAWY SYSTEMU WINDOWS 11 ===") | Out-Null
            $sbReport.AppendLine("Data i godzina eksportu: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')") | Out-Null
            $sbReport.AppendLine("Nazwa komputera: $env:COMPUTERNAME") | Out-Null
            $sbReport.AppendLine("Użytkownik: $env:USERNAME") | Out-Null
            $sbReport.AppendLine("") | Out-Null
            
            # Historia operacji
            $sbReport.AppendLine("=== HISTORIA OPERACJI Z INTERFEJSU ===") | Out-Null
            $sbReport.AppendLine($outputContent) | Out-Null
            $sbReport.AppendLine("") | Out-Null
            
            # CBS.log
            $cbsLogPath = "C:\Windows\Logs\CBS\cbs.log"
            if (Test-Path $cbsLogPath) {
                $sbReport.AppendLine("=== LOGI SFC (CBS.LOG) ===") | Out-Null
                try {
                    $cbsContent = Get-Content -Path $cbsLogPath -Raw -ErrorAction SilentlyContinue
                    $sbReport.AppendLine($cbsContent) | Out-Null
                }
                catch {
                    $sbReport.AppendLine("⚠️  Nie udało się odczytać CBS.LOG: $_") | Out-Null
                }
            }
            else {
                $sbReport.AppendLine("⚠️  Plik CBS.LOG nie został znaleziony na tym systemie.") | Out-Null
            }
            
            $sbReport.AppendLine("") | Out-Null
            $sbReport.AppendLine("=== KONIEC RAPORTU ===") | Out-Null
            
            # Zapis do pliku
            Set-Content -Path $exportPath -Value $sbReport.ToString() -Encoding UTF8
            
            $txtStatus.Text = "✅ Eksport zakończony: $([System.IO.Path]::GetFileName($exportPath))"
            [System.Windows.MessageBox]::Show("Logi zostały pomyślnie wyeksportowane do:`n`n$exportPath", "Eksport zakończony", "OK", "Information")
        }
        catch {
            $txtStatus.Text = "❌ Błąd podczas eksportu: $_"
            [System.Windows.MessageBox]::Show("Błąd podczas eksportu logów:`n$_", "Błąd eksportu", "OK", "Error")
        }
    }
    else {
        $txtStatus.Text = "Anulowano eksport."
    }
}
