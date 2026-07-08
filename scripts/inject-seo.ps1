$root = Split-Path $PSScriptRoot -Parent
$base = "https://www.humbleoaksolutions.com"
$services = Get-Content (Join-Path $PSScriptRoot "services-data.json") -Raw | ConvertFrom-Json

function Encode-UrlPath([string]$path) {
  return ($path -split "/" | ForEach-Object { [uri]::EscapeDataString($_) }) -join "/"
}

function Get-OgImage([string]$relativePath) {
  return "$base/" + (Encode-UrlPath $relativePath.TrimStart("/"))
}

function Escape-Html([string]$text) {
  return [System.Web.HttpUtility]::HtmlEncode($text)
}

Add-Type -AssemblyName System.Web

$orgJson = @'
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Humble Oak Solutions",
    "url": "https://www.humbleoaksolutions.com/",
    "logo": "https://www.humbleoaksolutions.com/assets/Site%20Images/shared/logo-webflow-small.png",
    "description": "Canadian operations and IT consulting for small and growing businesses in British Columbia.",
    "address": {
      "@type": "PostalAddress",
      "addressRegion": "BC",
      "addressCountry": "CA"
    },
    "contactPoint": {
      "@type": "ContactPoint",
      "email": "info@humbleoaksolutions.com",
      "contactType": "customer service",
      "availableLanguage": "English"
    },
    "sameAs": [
      "https://www.linkedin.com/company/humbleoaksolutions/",
      "https://www.instagram.com/humbleoakadmin/"
    ]
  }
  </script>
'@

$pageImages = @{
  "index.html" = "assets/Site Images/home/home-hero.jpg"
  "about-us/index.html" = "assets/Site Images/about-us/about-values.jpg"
  "contact-us/index.html" = "assets/Site Images/home/home-hero.jpg"
  "our-team/index.html" = "assets/Site Images/our-team/team-jason.jpg"
  "services/index.html" = "assets/Site Images/home/home-services-background.jpeg"
}

$files = @(
  "index.html",
  "about-us/index.html",
  "contact-us/index.html",
  "our-team/index.html",
  "services/index.html"
) + ($services | ForEach-Object { "services/$($_.slug)/index.html" })

foreach ($rel in $files) {
  $path = Join-Path $root $rel
  if (-not (Test-Path $path)) { continue }
  $html = Get-Content $path -Raw -Encoding UTF8
  if ($html -match 'property="og:title"') { continue }

  $titleMatch = [regex]::Match($html, '<title>(?<title>[^<]*)</title>')
  $descMatch = [regex]::Match($html, '<meta name="description" content="(?<desc>[^"]*)">')
  $canonMatch = [regex]::Match($html, '<link rel="canonical" href="(?<canonical>[^"]*)">')
  if (-not $titleMatch.Success -or -not $descMatch.Success -or -not $canonMatch.Success) { continue }

  $title = [System.Web.HttpUtility]::HtmlDecode($titleMatch.Groups['title'].Value)
  $description = [System.Web.HttpUtility]::HtmlDecode($descMatch.Groups['desc'].Value)
  $canonical = $canonMatch.Groups['canonical'].Value

  $imageRel = $pageImages[$rel]
  if (-not $imageRel) {
    $slug = if ($rel -match 'services/([^/]+)/') { $Matches[1] } else { $null }
    $svc = $services | Where-Object { $_.slug -eq $slug } | Select-Object -First 1
    if ($svc) { $imageRel = "assets/Site Images/services/$($svc.photo)" }
  }
  if (-not $imageRel) { $imageRel = "assets/Site Images/shared/logo-webflow-small.png" }
  $ogImage = Get-OgImage $imageRel

  $seo = @"
  <meta name="theme-color" content="#1C1C1A">
  <meta name="author" content="Humble Oak Solutions">
  <link rel="icon" href="/assets/Site Images/shared/logo-webflow-small.png" type="image/png">
  <link rel="apple-touch-icon" href="/assets/Site Images/shared/logo-webflow-small.png">
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Humble Oak Solutions">
  <meta property="og:title" content="$(Escape-Html $title)">
  <meta property="og:description" content="$(Escape-Html $description)">
  <meta property="og:url" content="$canonical">
  <meta property="og:image" content="$ogImage">
  <meta property="og:locale" content="en_CA">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="$(Escape-Html $title)">
  <meta name="twitter:description" content="$(Escape-Html $description)">
  <meta name="twitter:image" content="$ogImage">
"@

  $html = $html -replace '(<meta name="description" content="[^"]*">)', "`$1`n$seo"
  $jsonLd = $orgJson

  if ($rel -eq "index.html") {
    $jsonLd += @'

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "Humble Oak Solutions",
    "url": "https://www.humbleoaksolutions.com/"
  }
  </script>
'@
  }

  if ($rel -eq "our-team/index.html") {
    $jsonLd += @'

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "ItemList",
    "itemListElement": [
      {
        "@type": "ListItem",
        "position": 1,
        "item": {
          "@type": "Person",
          "name": "Jason Ghag",
          "jobTitle": "Co-Founder",
          "worksFor": { "@type": "Organization", "name": "Humble Oak Solutions" }
        }
      },
      {
        "@type": "ListItem",
        "position": 2,
        "item": {
          "@type": "Person",
          "name": "Gary Ghag",
          "jobTitle": "Co-Founder",
          "worksFor": { "@type": "Organization", "name": "Humble Oak Solutions" }
        }
      }
    ]
  }
  </script>
'@
  }

  if ($rel -match '^services/([^/]+)/index\.html$') {
    $slug = $Matches[1]
    $svc = $services | Where-Object { $_.slug -eq $slug } | Select-Object -First 1
    if ($svc) {
      $svcUrl = "$base/services/$slug/"
      $serviceObj = @{
        "@context" = "https://schema.org"
        "@type" = "Service"
        name = $svc.title
        description = $svc.meta
        url = $svcUrl
        provider = @{
          "@type" = "Organization"
          name = "Humble Oak Solutions"
          url = "https://www.humbleoaksolutions.com/"
        }
        areaServed = @{
          "@type" = "Country"
          name = "Canada"
        }
      }
      $breadcrumbObj = @{
        "@context" = "https://schema.org"
        "@type" = "BreadcrumbList"
        itemListElement = @(
          @{ "@type" = "ListItem"; position = 1; name = "Home"; item = "https://www.humbleoaksolutions.com/" },
          @{ "@type" = "ListItem"; position = 2; name = "Services"; item = "https://www.humbleoaksolutions.com/services/" },
          @{ "@type" = "ListItem"; position = 3; name = $svc.title; item = $svcUrl }
        )
      }
      $serviceJson = ($serviceObj | ConvertTo-Json -Depth 6 -Compress)
      $breadcrumbJson = ($breadcrumbObj | ConvertTo-Json -Depth 6 -Compress)
      $jsonLd += "`n  <script type=`"application/ld+json`">`n  $serviceJson`n  </script>"
      $jsonLd += "`n  <script type=`"application/ld+json`">`n  $breadcrumbJson`n  </script>"
    }
  }

  if ($rel -eq "contact-us/index.html") {
    $jsonLd += @'

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "ContactPage",
    "name": "Contact Humble Oak Solutions",
    "url": "https://www.humbleoaksolutions.com/contact-us/",
    "mainEntity": {
      "@type": "Organization",
      "name": "Humble Oak Solutions",
      "email": "info@humbleoaksolutions.com",
      "contactPoint": [
        { "@type": "ContactPoint", "email": "info@humbleoaksolutions.com", "contactType": "customer service" },
        { "@type": "ContactPoint", "email": "jason.ghag@humbleoaksolutions.com", "contactType": "sales", "areaServed": "CA" },
        { "@type": "ContactPoint", "email": "gary.ghag@humbleoaksolutions.com", "contactType": "technical support", "areaServed": "CA" }
      ]
    }
  }
  </script>
'@
  }

  $html = $html -replace '</head>', "$jsonLd`n</head>"
  [System.IO.File]::WriteAllText($path, $html, [System.Text.UTF8Encoding]::new($false))
  Write-Output "Updated SEO: $rel"
}
