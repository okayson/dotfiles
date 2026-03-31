# This script installs various tools using winget.
# Note: If a security error occurs, type the following.
#       Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$packages = @(
    "JesseDuffield.lazygit"
    "dandavison.delta"
)
# "BurntSushi.ripgrep"
# "sharkdp.fd";
# "Git.Git";

foreach ($pkg in $packages) {

    Write-Host "Processing: $($pkg)"

    winget install --id $pkg -e `
        --accept-package-agreements `
        --accept-source-agreements
    Write-Host ""
}

