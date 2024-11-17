###############################################################################
# Windows installer script for the WSL-based devcontainers development environment.
#
###############################################################################
# TODOs:
# - Ability to interactively edit the properties.
# - Check downloaded image for integrity.
# - Ability to select Ubuntu version
# - Self test
# - Testing if WSL distribution exists. Force delete, exit, prompt.
###############################################################################

Write-Output "Development Environment Installer"
Write-Output "================================="

$download_dir="D:\WSL"
$wsl_home_directory="D:\WSL"
$wsl_image_url="https://cloud-images.ubuntu.com/wsl/jammy/current/ubuntu-jammy-wsl-amd64-ubuntu.rootfs.tar.gz"
$wsl_image_path="$($download_dir)\ubuntu-jammy-wsl-amd64-ubuntu.rootfs.tar.gz"
$wsl_distribution_name="devcontainers"
$wsl_distribution_home="$($wsl_home_directory)\$($wsl_distribution_name)"
$wsl_default_username="developer"
$wsl_default_password="welcome"
$install_dotfiles="true"
$install_zsh="true"
$install_docker_engine="true"

Write-Output ""
Write-Output "Parameters:"
Write-Output "   WSL Image Download dir:         $($download_dir)"
Write-Output "   WSL Distribution Home:          $($wsl_distribution_home)"
Write-Output "   WSL Distribution Name:          $($wsl_distribution_name)"
Write-Output "   WSL Username:                   $($wsl_default_username)"
Write-Output "   WSL Password:                   $($wsl_default_password)"
Write-Output "   Install Sanyi's dotfiles:       $($install_dotfiles)"
Write-Output "   Install ZSH and set it default: $($install_zsh)"
Write-Output "   Install Docker Engine:          $($install_docker_engine)"
Write-Output ""


$confirm = Read-Host -Prompt "Do you wish to continue? y/n"
if ($confirm -ne 'y') {
  Write-Output "Installation is cancelled."
  exit
}

Write-Output ""
Write-Output "Installing Development environment distro on WSL..."

if (-Not (Test-Path -Path $download_dir -PathType Container)) {
    Write-Output "Target download directory does not exist. Creating it..."
    New-Item -Path $download_dir -ItemType Directory
}

if (-Not (Test-Path -Path $wsl_image_path -PathType Leaf)) {
    Write-Output "Downloading the latest WSL image..."
    Invoke-WebRequest  $wsl_image_url -OutFile $wsl_image_path
} else {
    Write-Output "Reusing downloaded WSL image."
}

Write-Output "Importing WSL image..."
wsl --import $wsl_distribution_name $wsl_distribution_home $wsl_image_path

Write-Output "Running WSL post-install script"
wsl -d $wsl_distribution_name -e ./wsl-post-install.sh "--default-username=$($wsl_default_username)" "--default-password=$($wsl_default_password)" "--install-dotfiles=$($install_dotfiles)" "--install-zsh=$($install_zsh)" "--install-docker-engine=$($install_docker_engine)"

Write-Output "Stopping WSL subsystem to reload new settings"
wsl --terminate $wsl_distribution_name
