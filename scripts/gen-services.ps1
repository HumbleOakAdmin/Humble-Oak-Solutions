$root = "C:\Humble Oak Solutions\Git"
$services = Get-Content "$root\scripts\services-data.json" -Raw | ConvertFrom-Json

$navTray = @('            <a href="/services/" class="hos-nav-services-overview">All Services</a>')
foreach ($s in $services) {
  $navTray += "            <a href=`"/services/$($s.slug)/`" data-service-slug=`"$($s.slug)`">$($s.title)</a>"
}

$navLinks = @(
'        <a href="/" class="hos-nav-link" data-page="home">Home</a>'
'        <a href="/about-us/" class="hos-nav-link" data-page="about">About</a>'
'        <div class="hos-nav-services" data-nav-section="services">'
'          <button type="button" class="hos-nav-link hos-nav-services-btn" id="hosNavServicesBtn" aria-expanded="false" aria-controls="hosNavServicesTray">Services</button>'
'          <div class="hos-nav-services-tray" id="hosNavServicesTray" hidden>'
) + $navTray + @(
'          </div>'
'        </div>'
'        <a href="/our-team/" class="hos-nav-link" data-page="team">Team</a>'
)

$navBlock = @"
  <div class="hos-nav-backdrop" id="hosNavBackdrop" aria-hidden="true"></div>
  <nav class="hos-nav" id="hosNav" aria-label="Main navigation">
    <button type="button" class="hos-nav-toggle" id="hosNavToggle" aria-label="Open menu" aria-expanded="false" aria-controls="hosNavPanel">
      <span></span><span></span><span></span>
    </button>
    <div class="hos-nav-panel" id="hosNavPanel">
      <a href="/" class="hos-nav-logo"><img src="/assets/Site Images/shared/logo-webflow-small.png" alt="Humble Oak Solutions"></a>
      <div class="hos-nav-links">
$($navLinks -join "`n")
      </div>
      <a href="/contact-us/" class="hos-nav-cta">Get in Touch</a>
    </div>
  </nav>
"@

$footerBlock = @"
  <footer class="hos-footer">
    <div class="hos-footer-inner">
      <div class="hos-footer-nav-cols">
        <div><a href="/" class="hos-footer-logo">Humble Oak Solutions</a><p>Founded and operated out of British Columbia, Canada.</p>
          <div class="hos-footer-social" aria-label="Social media">
            <a href="https://www.linkedin.com/company/humbleoaksolutions/" class="hos-footer-social-link" target="_blank" rel="noopener noreferrer" aria-label="Humble Oak Solutions on LinkedIn">
              <img src="/assets/icons/social-linkedin.svg" width="20" height="20" alt="">
            </a>
            <a href="https://www.instagram.com/humbleoakadmin/" class="hos-footer-social-link" target="_blank" rel="noopener noreferrer" aria-label="Humble Oak Solutions on Instagram">
              <img src="/assets/icons/social-instagram.svg" width="20" height="20" alt="">
            </a>
          </div></div>
        <div class="hos-footer-links">
          <a href="/" data-page="home">Home</a>
          <a href="/about-us/" data-page="about">About Us</a>
          <a href="/services/" data-page="services">Our Services</a>
          <a href="/our-team/" data-page="team">Our Team</a>
          <a href="/contact-us/" data-page="contact">Contact Us</a>
        </div>
      </div>
      <div class="hos-footer-bar"><span>&copy; 2026 Humble Oak Solutions &middot; BC, Canada</span></div>
    </div>
  </footer>
"@

$listRows = @()
foreach ($s in $services) {
  $iconClass = if ($s.iconClass) { "hos-service-icon-img $($s.iconClass)" } else { "hos-service-icon-img" }
  $idNum = [int]$s.num
  $bullets = ($s.bullets | ForEach-Object { "            <li>$_</li>" }) -join "`n"

  $page = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="referrer" content="strict-origin-when-cross-origin">
  <meta http-equiv="X-Content-Type-Options" content="nosniff">
  <meta name="robots" content="index, follow">
  <link rel="canonical" href="https://www.humbleoaksolutions.com/services/$($s.slug)/">
  <title>$($s.title) | Humble Oak Solutions</title>
  <meta name="description" content="$($s.meta)">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/assets/styles.css">
</head>
<body data-page="services" data-service="$($s.slug)">
$navBlock
  <main>
    <section class="hos-page-hero hos-service-detail-hero" style="background-image:url('/assets/Site Images/services/$($s.photo)')">
      <div class="hos-page-hero-overlay"></div>
      <div class="hos-page-hero-content">
        <p class="hos-page-hero-tag hos-anim">Our Services</p>
        <div class="hos-service-detail-hero-title hos-anim">
          <img class="$iconClass" src="/assets/Site Images/services/$($s.icon)" width="48" height="48" alt="">
          <h1 class="hos-page-hero-title">$($s.title)</h1>
        </div>
        <p class="hos-page-hero-sub hos-anim">$($s.short)</p>
      </div>
    </section>
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">$($s.intro)</p>
        <h2 class="hos-heading-section hos-anim">What We Deliver</h2>
        <ul class="hos-service-detail-list hos-anim">
$bullets
        </ul>
        <p class="hos-anim">$($s.closing)</p>
        <div class="hos-service-detail-actions hos-anim">
          <a href="/contact-us/" class="hos-btn hos-btn-gold">Discuss This Service</a>
          <a href="/services/" class="hos-btn hos-btn-dark">All Services</a>
        </div>
      </div>
    </section>
  </main>
$footerBlock
  <script src="/assets/site.js"></script>
</body>
</html>
"@

  $dir = Join-Path $root "services\$($s.slug)"
  New-Item -ItemType Directory -Path $dir -Force | Out-Null
  [System.IO.File]::WriteAllText((Join-Path $dir "index.html"), $page, [System.Text.UTF8Encoding]::new($false))

  $listRows += @"
        <div class="hos-service-row" id="svc-$idNum">
          <a class="hos-service-item hos-anim" href="/services/$($s.slug)/">
            <div class="hos-service-thumb" style="background-image:url('/assets/Site Images/services/$($s.photo)')" role="img" aria-label=""></div>
            <div class="hos-service-num">$($s.num)</div>
            <div class="hos-service-body">
              <div class="hos-service-title-row">
                <img class="$iconClass" src="/assets/Site Images/services/$($s.icon)" width="40" height="40" alt="">
                <h3 class="hos-heading-item">$($s.title)</h3>
              </div>
              <p>$($s.short)</p>
            </div>
            <span class="hos-service-toggle" aria-hidden="true">&rarr;</span>
          </a>
        </div>
"@
}

$listRows -join "`n`n" | Set-Content "$root\scripts\service-list-rows.html" -Encoding UTF8
$navBlock | Set-Content "$root\scripts\nav-block.html" -Encoding UTF8
Write-Output "Generated $($services.Count) pages"
