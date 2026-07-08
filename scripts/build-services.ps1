$root = "C:\Humble Oak Solutions\Git"
$services = @(
  @{
    slug = "operations-consulting"
    num = "01"
    title = "Operations Consulting"
    short = "Streamline your workflows, reduce waste, and improve performance with tailored process optimization strategies."
    meta = "Operations consulting for BC small businesses: process mapping, COGS analysis, lean improvement, and KPI frameworks."
    photo = "svc-ops-photo.jpg"
    icon = "icon-consultation.png"
    intro = "We help growing Canadian teams run leaner without adding headcount. From shop floor to back office, we map how work actually flows and remove friction that slows you down."
    bullets = @("Process mapping and value-stream review","True cost of goods sold and margin analysis","SOP development and documentation","KPI frameworks and management rhythms","Lean improvement and change management")
    closing = "Whether you are scaling production or tightening overhead, we deliver practical operations support sized for SMB budgets—not enterprise consulting theater."
  },
  @{
    slug = "project-management"
    num = "02"
    title = "Project & Site Management"
    short = "From relocations to infrastructure upgrades, we plan and manage capital projects with precision and accountability."
    meta = "Project and site management for relocations, tenant improvements, equipment moves, and capital projects across BC."
    photo = "svc-pm-photo.jpg"
    icon = "icon-hook.png"
    intro = "Capital projects rarely fail on ideas—they fail on coordination. We keep schedules, budgets, and stakeholders aligned from kickoff through closeout."
    bullets = @("Tenant improvements and facility relocations","Equipment moves and site logistics","Scheduling, budgeting, and vendor coordination","Field supervision and safety alignment","Executive-ready status reporting")
    closing = "You get a single accountable partner who speaks both operations and construction—so your team can stay focused on running the business."
  },
  @{
    slug = "web-development"
    num = "03"
    title = "Web Development & Maintenance"
    short = "Build a clean, responsive, and high-performing web presence with ongoing support to keep your site secure, updated, and optimized."
    meta = "Web development and maintenance: responsive sites, performance tuning, accessibility, and dependable post-launch support."
    photo = "svc-web-photo.jpg"
    icon = "icon-internet.png"
    intro = "Your website should earn trust in seconds and work flawlessly on every device. We design and maintain sites that reflect your brand and support real business goals."
    bullets = @("Responsive design aligned to your brand","Performance and Core Web Vitals tuning","Accessibility foundations","Hosting and DNS guidance","Content updates and security maintenance")
    closing = "From launch to long-term care, we keep your public face fast, secure, and easy to manage."
  },
  @{
    slug = "it-systems"
    num = "04"
    title = "IT Systems Administration"
    short = "Keep your infrastructure running smoothly with expert server management, user support, backup systems, and cybersecurity best practices."
    meta = "IT systems administration for SMBs: Microsoft 365, identity, backups, monitoring, and practical help-desk coverage."
    photo = "svc-it-photo.jpg"
    icon = "icon-it-department.png"
    intro = "Reliable IT is invisible until it breaks. We stabilize your environment, document what matters, and respond before small issues become outages."
    bullets = @("Microsoft 365 administration and licensing","Identity, access, and device management","Backup and recovery planning","Network hardening and monitoring","Help-desk coverage and end-user support")
    closing = "We bring enterprise-grade discipline to small and mid-sized environments—without enterprise-level complexity."
  },
  @{
    slug = "business-intelligence"
    num = "05"
    title = "Business Intelligence"
    short = "Unlock the power of your data with custom KPI dashboards, reporting tools, and performance tracking solutions."
    meta = "Business intelligence and Power BI dashboards: KPI modelling, automated reporting, and data your team can trust."
    photo = "svc-bi-photo.jpg"
    icon = "icon-business-intelligence.png"
    intro = "Spreadsheets hide answers. Dashboards surface them. We connect your data sources and build reporting your leadership can act on the same day."
    bullets = @("Power BI modelling and semantic layers","Automated data refreshes","Executive and operational dashboards","KPI definition workshops","Hands-on training for your team")
    closing = "When everyone trusts the numbers, decisions get faster—and a lot less stressful."
  },
  @{
    slug = "automation-integration"
    num = "06"
    title = "Automation & Integration"
    short = "Boost efficiency through smart systems—digital inventory, production automation, and process control technologies."
    meta = "Automation and systems integration: workflows, APIs, and tooling that eliminate manual handoffs for growing businesses."
    photo = "svc-automation-photo.jpg"
    icon = "icon-automation.png"
    intro = "Manual handoffs cost time and introduce errors. We connect the systems you already use so information moves once—automatically."
    bullets = @("Workflow automation across departments","API and middleware integrations","Inventory and production tooling","Forms, approvals, and notifications","Documentation and maintainable solutions")
    closing = "We automate what repeats and integrate what is disconnected—freeing your team for higher-value work."
  },
  @{
    slug = "government-funding"
    num = "07"
    title = "Government Funding Applications"
    short = "Secure growth capital with expert support on grant strategy, funding applications, and government incentive programs."
    meta = "Government funding and grant application support for Canadian SMBs—strategy, submissions, and post-award reporting."
    photo = "svc-gov-photo.jpg"
    icon = "icon-application.png"
    intro = "Canadian programs can fund real growth—but applications are competitive and time-consuming. We have helped clients secure millions in grants and know how to tell your story clearly."
    bullets = @("Program identification and eligibility review","Narrative and budget development","Submission preparation and deadlines","Compliance and post-award reporting","Alignment to provincial and federal incentives")
    closing = "We translate your project into language funders understand—so you can invest in equipment, people, and expansion with confidence."
  },
  @{
    slug = "erp-implementation"
    num = "08"
    title = "ERP Implementation & Support"
    short = "Select, deploy, and optimize ERP platforms that connect finance, operations, and inventory—without derailing day-to-day business."
    meta = "ERP implementation and support for growing businesses: selection, deployment, data migration, training, and ongoing optimization."
    photo = "svc-erp-photo.jpg"
    icon = "icon-erp.png"
    iconClass = "hos-service-icon-img hos-service-icon-img--erp"
    intro = "An ERP should unify your business—not overwhelm it. We guide selection, implementation, and adoption so your team actually uses the system and sees ROI."
    bullets = @("ERP selection and requirements workshops","Phased implementation planning","Data migration and validation","Integration with existing tools","User training and post-go-live support")
    closing = "From first vendor conversations through steady-state support, we keep ERP projects practical, on schedule, and aligned to how your business really operates."
  }
)

function Get-NavLinksHtml {
  $lines = @('        <a href="/" class="hos-nav-link" data-page="home">Home</a>',
    '        <a href="/about-us/" class="hos-nav-link" data-page="about">About</a>',
    '        <div class="hos-nav-services" data-nav-section="services">',
    '          <button type="button" class="hos-nav-link hos-nav-services-btn" id="hosNavServicesBtn" aria-expanded="false" aria-controls="hosNavServicesTray">Services</button>',
    '          <div class="hos-nav-services-tray" id="hosNavServicesTray" hidden>',
    '            <a href="/services/" class="hos-nav-services-overview">All Services</a>')
  foreach ($s in $services) {
    $lines += "            <a href=`"/services/$($s.slug)/`" data-service-slug=`"$($s.slug)`">$($s.title)</a>"
  }
  $lines += @('          </div>',
    '        </div>',
    '        <a href="/our-team/" class="hos-nav-link" data-page="team">Team</a>')
  return ($lines -join "`n")
}

function Get-NavBlock {
  return @"
  <div class="hos-nav-backdrop" id="hosNavBackdrop" aria-hidden="true"></div>
  <nav class="hos-nav" id="hosNav" aria-label="Main navigation">
    <button type="button" class="hos-nav-toggle" id="hosNavToggle" aria-label="Open menu" aria-expanded="false" aria-controls="hosNavPanel">
      <span></span><span></span><span></span>
    </button>
    <div class="hos-nav-panel" id="hosNavPanel">
      <a href="/" class="hos-nav-logo"><img src="/assets/Site Images/shared/logo-webflow-small.png" alt="Humble Oak Solutions"></a>
      <div class="hos-nav-links">
$(Get-NavLinksHtml)
      </div>
      <a href="/contact-us/" class="hos-nav-cta">Get in Touch</a>
    </div>
  </nav>
"@
}

function Get-FooterBlock {
  return @"
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
}

function Get-ServicePageHtml($s) {
  $iconClass = if ($s.iconClass) { $s.iconClass } else { "hos-service-icon-img" }
  $bullets = ($s.bullets | ForEach-Object { "            <li>$_</li>" }) -join "`n"
  return @"
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
$(Get-NavBlock)
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
$(Get-FooterBlock)
  <script src="/assets/site.js"></script>
</body>
</html>
"@
}

function Get-ServiceRowHtml($s) {
  $iconClass = if ($s.iconClass) { $s.iconClass } else { "hos-service-icon-img" }
  return @"
        <div class="hos-service-row" id="svc-$($s.num.TrimStart('0'))">
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

# Generate individual service pages
foreach ($s in $services) {
  $dir = Join-Path $root "services\$($s.slug)"
  New-Item -ItemType Directory -Path $dir -Force | Out-Null
  [System.IO.File]::WriteAllText((Join-Path $dir "index.html"), (Get-ServicePageHtml $s), [System.Text.UTF8Encoding]::new($false))
}

# Build services index list rows
$listRows = ($services | ForEach-Object { Get-ServiceRowHtml $_ }) -join "`n"

Write-Output "Generated $($services.Count) service pages"
Write-Output "NAV_START"
Get-NavBlock
Write-Output "LIST_START"
$listRows
