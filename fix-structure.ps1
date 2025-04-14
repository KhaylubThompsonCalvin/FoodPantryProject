# fix-structure.ps1
# This script reorganizes the project structure into the new layout.
# It assumes your base directory is the folder that contains Assignment1, docs, src, tests, etc.

Write-Output "Starting to fix project structure..."

# --- 1. Move Documentation Files ---
# If clarifying-questions.md is found in Assignment1, move it to docs.
if (Test-Path "Assignment1\clarifying-questions.md") {
    Move-Item -Path "Assignment1\clarifying-questions.md" -Destination "docs\clarifying-questions.md" -Force
    Write-Output "Moved clarifying-questions.md to docs."
} else {
    Write-Output "No clarifying-questions.md found in Assignment1."
}

# If implementation-notes.md is found in Assignment1, move it to docs.
if (Test-Path "Assignment1\implementation-notes.md") {
    Move-Item -Path "Assignment1\implementation-notes.md" -Destination "docs\implementation-notes.md" -Force
    Write-Output "Moved implementation-notes.md to docs."
} else {
    Write-Output "No implementation-notes.md found in Assignment1."
}

# --- 2. Move the Main Application File ---
# Check if Assignment1\app.py exists AND src\app.py does not (to prevent overwrite)
if ((Test-Path "Assignment1\app.py") -and (-not (Test-Path "src\app.py"))) {
    Move-Item -Path "Assignment1\app.py" -Destination "src\app.py" -Force
    Write-Output "Moved app.py to src."
} else {
    Write-Output "Either src\app.py already exists or Assignment1\app.py is missing."
}

# --- 3. Move HTML Templates ---
# If the old templates folder exists under Assignment1, move its contents.
if (Test-Path "Assignment1\templates") {
    Get-ChildItem "Assignment1\templates\*" | ForEach-Object {
        $destination = Join-Path "src\views\templates" $_.Name
        Move-Item -Path $_.FullName -Destination $destination -Force
        Write-Output "Moved $($_.Name) to src\views\templates."
    }
} else {
    Write-Output "No templates folder found in Assignment1."
}

# --- 4. Verify Critical HTML Files in src\views\templates ---

# Ensure login.html exists; if not, create a basic placeholder.
if (-not (Test-Path "src\views\templates\login.html")) {
    @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Food Pantry Notification System</title>
</head>
<body>
    <h1>Login</h1>
    <form action="/login" method="post">
        <label for="username">Username or Email:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
"@ | Out-File "src\views\templates\login.html" -Encoding UTF8
    Write-Output "Created placeholder login.html in src\views\templates."
} else {
    Write-Output "login.html already exists in src\views\templates."
}

# Ensure register.html exists; if not, create a placeholder.
if (-not (Test-Path "src\views\templates\register.html")) {
    @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Food Pantry Notification System</title>
</head>
<body>
    <h1>Register</h1>
    <form action="/register" method="post">
        <label for="fullname">Full Name:</label>
        <input type="text" id="fullname" name="fullname" required>
        <br>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
        <br>
        <button type="submit">Register</button>
    </form>
</body>
</html>
"@ | Out-File "src\views\templates\register.html" -Encoding UTF8
    Write-Output "Created placeholder register.html in src\views\templates."
} else {
    Write-Output "register.html already exists in src\views\templates."
}

# Ensure dashboard.html exists; if not, create a basic placeholder.
if (-not (Test-Path "src\views\templates\dashboard.html")) {
    @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Food Pantry Notification System</title>
</head>
<body>
    <h1>Dashboard</h1>
    <p>Welcome to the Dashboard! This page will display notifications and user details.</p>
</body>
</html>
"@ | Out-File "src\views\templates\dashboard.html" -Encoding UTF8
    Write-Output "Created placeholder dashboard.html in src\views\templates."
} else {
    Write-Output "dashboard.html already exists in src\views\templates."
}

Write-Output "Project structure update complete."
