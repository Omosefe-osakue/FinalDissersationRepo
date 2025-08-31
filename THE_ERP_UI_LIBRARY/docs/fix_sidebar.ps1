$path = ".\_build\html\"
$files = Get-ChildItem -Path $path -Recurse -Include *.html

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw

    # Remove "Concepts & Theory" section
    $content = $content -replace '<p class="caption" role="heading"><span class="caption-text">Concepts &amp; Theory</span></p>', ''
    
    # Remove "Code Examples" link and list item
    $content = $content -replace '<li class="toctree-l1"><a class="reference internal" href="code_examples.html">Code Examples</a></li>', ''
    
    # Remove "Theoretical Background" link and list item
    $content = $content -replace '<li class="toctree-l1"><a class="reference internal" href="theory.html">Theoretical Background</a></li>', ''

    Set-Content -Path $file.FullName -Value $content
}

Write-Output "Fixed sidebar in HTML files."
