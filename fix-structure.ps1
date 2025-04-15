# File: fix-structure.ps1
# Author: Khaylub Thompson-Calvin
# Description:
# This script standardizes and organizes the folder structure for the
# Food Pantry Notification System project. It moves documentation, source files,
# and HTML templates into an MVC-style layout and ensures critical HTML placeholders exist.

Write-Output "`nStarting project structure reorganization..."

# --------------------------------------------------------------------
# Step 1: Move Documentation Files to documentation/
# --------------------------------------------------------------------

# Move clarifying questions
if (Test-Path "Assignment1\clarifying-questions.md") {
    Move-Item -Path "Assignment1\clarifying-questions.md" -Destination "documentation\clarifying-questions.md" -Force
    Write-Output "Moved clarifying-questions.md to documentation/"
} elseif (Test-Path "Assignment1\clarifying-questions.txt") {
    Move-Item -Path "Assignment1\clarifying-questions.txt" -Destination "documentation\clarifying-questions.txt" -Force
    Write-Output "Moved clarifying-questions.txt to documentation/"
} else {
    Write-Output "No clarifying questions file found in Assignment1."
}

# Move implementation notes
if (Test-Path "Assignment1\implementation-notes.md") {
    Move-Item -Path "Assignment1\implementation-notes.md" -Destination "documentation\implementation-notes.md" -Force
    Write-Output "Moved implementation-notes.md to documentation/"
} else {
    Write-Output "No implementation-notes.md file found in Assignment1."
}

# --------------------------------------------------------------------
# Step 2: Move Main Application File to src/
# --------------------------------------------------------------------

if ((Test-Path "Assignment1\app.py") -and (-not (Test-Path "src\app.py"))) {
    Move-Item -Path "Assignment1\app.py" -Destination "src\app.py" -Force
    Write-Output "Moved app.py to src/"
} else {
    Write-Output "src\app.py already exists or app.py not found in Assignment1."
}

# --------------------------------------------------------------------
# Step 3: Move Templates Folder (if exists)
# --------------------------------------------------------------------

if (Test-Path "Assignment1\templates") {
    Get-ChildItem "Assignment1\templates\*" | ForEach-Object {
        $destination = Join-Path "src\views\templates" $_.Name
        Move-Item -Path $_.FullName -Destination $destination -Force
        Write-Output "Moved template: $($_.Name) to src\views\templates/"
    }
} else {
    Write-Output "No templates directory found in Assignment1."
}

# --------------------------------------------------------------------
# Step 4: Ensure Core HTML Template Placeholders Exist
# --------------------------------------------------------------------

function Ensure-TemplateExists($filename, $content) {
    $path = "src\views\templates\$filename"
    if (-not (Test-Path $path)) {
        $content | Out-File -FilePath $path -Encoding UTF8
        Write-Output "Created placeholder: $filename in src\views\templates/"
    } else {
        Write-Output "$filename already exists in src\views\templates/"
    }
}

Ensure-TemplateExists "login.html" @"
<!DOCTYPE html>
<html>
<head><title>Login</title></head>
<body>
    <h1>Login</h1>
    <form action="/login" method="post">
        <label>Username or Email:</label><input type="text" name="username" />
        <label>Password:</label><input type="password" name="password" />
        <button type="submit">Login</button>
    </form>
</body>
</html>
"@

Ensure-TemplateExists "register.html" @"
<!DOCTYPE html>
<html>
<head><title>Register</title></head>
<body>
    <h1>Register</h1>
    <form action="/register" method="post">
        <label>Full Name:</label><input type="text" name="fullname" />
        <label>Username:</label><input type="text" name="username" />
        <label>Email:</label><input type="email" name="email" />
        <label>Password:</label><input type="password" name="password" />
        <label>Confirm Password:</label><input type="password" name="confirmPassword" />
        <button type="submit">Register</button>
    </form>
</body>
</html>
"@

Ensure-TemplateExists "dashboard.html" @"
<!DOCTYPE html>
<html>
<head><title>Dashboard</title></head>
<body>
    <h1>Dashboard</h1>
    <p>Welcome to the Dashboard. Notifications will appear here.</p>
</body>
</html>
"@

# --------------------------------------------------------------------
# Completion Message
# --------------------------------------------------------------------

Write-Output "`nProject structure reorganization complete."
