$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent

function Update-ServicePage {
  param(
    [string]$Slug,
    [string]$Title,
    [string]$Meta,
    [string]$HeroTitle,
    [string]$HeroSub,
    [string]$Photo,
    [string]$Icon,
    [string]$BodyHtml
  )

  $path = Join-Path $root "services\$Slug\index.html"
  $html = [System.IO.File]::ReadAllText($path)

  $html = [regex]::Replace($html, '(?s)<title>.*?</title>', "<title>$Title</title>")
  $html = [regex]::Replace($html, '(?s)<meta name="description" content="[^"]*">', "<meta name=`"description`" content=`"$Meta`">")
  $html = [regex]::Replace($html, '(?s)<meta property="og:title" content="[^"]*">', "<meta property=`"og:title`" content=`"$Title`">")
  $html = [regex]::Replace($html, '(?s)<meta property="og:description" content="[^"]*">', "<meta property=`"og:description`" content=`"$Meta`">")
  $html = [regex]::Replace($html, '(?s)<meta name="twitter:title" content="[^"]*">', "<meta name=`"twitter:title`" content=`"$Title`">")
  $html = [regex]::Replace($html, '(?s)<meta name="twitter:description" content="[^"]*">', "<meta name=`"twitter:description`" content=`"$Meta`">")

  $main = @"
  <main>
    <section class="hos-page-hero hos-service-detail-hero" style="background-image:url('/assets/Site Images/services/$Photo')">
      <div class="hos-page-hero-overlay"></div>
      <div class="hos-page-hero-content">
        <p class="hos-page-hero-tag hos-anim">Our Services</p>
        <div class="hos-service-detail-hero-title hos-anim">
          <img class="hos-service-icon-img" src="/assets/Site Images/services/$Icon" width="48" height="48" alt="" aria-hidden="true">
          <h1 class="hos-page-hero-title">$HeroTitle</h1>
        </div>
        <p class="hos-page-hero-sub hos-anim">$HeroSub</p>
      </div>
    </section>
$BodyHtml
  </main>
"@

  $html = [regex]::Replace($html, '(?s)<main>.*?</main>', $main.TrimEnd())
  [System.IO.File]::WriteAllText($path, $html, [System.Text.UTF8Encoding]::new($false))
  Write-Output "Rewrote $Slug"
}

$cta = @'
        <div class="hos-service-detail-actions hos-anim">
          <a href="/contact-us/" class="hos-btn hos-btn-gold">Discuss This Service</a>
          <a href="/services/" class="hos-btn hos-btn-dark">All Services</a>
        </div>
'@

# Operations
Update-ServicePage -Slug "operations-consulting" `
  -Title "Operations Consulting | Humble Oak Solutions" `
  -Meta "Hands-on operations consulting for BC manufacturers and SMBs: workflows, inventory, lean improvement, and results you can measure." `
  -HeroTitle "Operations Consulting" `
  -HeroSub "Streamline your workflows, reduce waste, and improve performance with tailored process optimization strategies." `
  -Photo "svc-ops-photo.jpg" -Icon "icon-consultation.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Most small business owners don&rsquo;t have time to map every bottleneck on the floor. We do that work with you&mdash;then leave you with processes your team can actually run.</p>
      </div>
    </section>
    <section class="hos-stat-band hos-stat-band--service" aria-label="Representative results">
      <div class="hos-stat-band-inner">
        <div class="hos-stat-band-grid">
          <div class="hos-stat-item hos-anim"><span class="hos-stat-prefix">+</span><span class="hos-stat-num" data-target="293">0</span><span class="hos-stat-suffix">%</span><div class="hos-stat-label">Productivity Lift</div></div>
          <div class="hos-stat-item hos-anim"><span class="hos-stat-prefix">&minus;</span><span class="hos-stat-num" data-target="34">0</span><span class="hos-stat-suffix">%</span><div class="hos-stat-label">Order Cycle Time</div></div>
          <div class="hos-stat-item hos-anim"><span class="hos-stat-prefix">+</span><span class="hos-stat-num" data-target="31">0</span><span class="hos-stat-suffix">%</span><div class="hos-stat-label">Revenue Impact</div></div>
        </div>
      </div>
    </section>
    <section class="hos-service-detail-content hos-section hos-service-detail-content--continued">
      <div class="hos-service-detail-inner hos-prose">
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Process mapping and finding where work really gets stuck</li>
          <li>Lean and 5S improvements that stick on the floor</li>
          <li>Inventory systems, SOPs, and clearer day-to-day standards</li>
          <li>Forecasting, costing, and production planning</li>
          <li>KPIs and rhythms that keep the team aligned</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">How We Show Up</h2>
        <p class="hos-anim">We start on the floor, not in a slide deck. Material flow, work queues, WIP, handoffs&mdash;whatever is slowing you down. Then we redesign the process, write it down, and coach the team so the gains don&rsquo;t disappear after we leave.</p>
        <p class="hos-anim">That experience covers manufacturing, warehousing, logistics, and production planning&mdash;including shops that live in an ERP every day. The goal is simple: fewer fire drills, clearer priorities, and numbers that move in the right direction.</p>
$cta
      </div>
    </section>
"@

# Project management
Update-ServicePage -Slug "project-management" `
  -Title "Project &amp; Site Management | Humble Oak Solutions" `
  -Meta "Project and site management for facility moves, capital upgrades, commissioning, and contractor coordination across BC." `
  -HeroTitle "Project &amp; Site Management" `
  -HeroSub "From relocations to infrastructure upgrades, we plan and manage capital projects with precision and accountability." `
  -Photo "svc-pm-photo.jpg" -Icon "icon-hook.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Capital projects rarely fail on ideas. They fail on coordination. We keep schedules, budgets, contractors, and stakeholders pointed at the same finish line.</p>
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Facility moves and day-one operational launch</li>
          <li>Budgets, forecasts, and cost control</li>
          <li>Contractors, engineers, and internal teams in one plan</li>
          <li>Site logistics, commissioning, and readiness checks</li>
          <li>Safety planning, inspections, and clear status reporting</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">What That Looks Like In Practice</h2>
        <p class="hos-anim">We&rsquo;ve led full manufacturing facility relocations&mdash;land, build-out, and launch&mdash;while production kept moving through the transition. We&rsquo;ve also run construction and site work where trades, materials, and clients all needed one person who owned the timeline.</p>
        <p class="hos-anim">Whether you&rsquo;re moving a plant, upgrading infrastructure, or bringing new equipment online, you get field leadership and project controls that finish cleanly&mdash;not a binder that sits on a shelf.</p>
$cta
      </div>
    </section>
"@

# Government funding
Update-ServicePage -Slug "government-funding" `
  -Title "Government Funding Applications | Humble Oak Solutions" `
  -Meta "Grant strategy and funding applications for Canadian SMBs, with a multimillion-dollar track record including \$4.5M+ secured for infrastructure and equipment." `
  -HeroTitle "Government Funding Applications" `
  -HeroSub "Secure growth capital with expert support on grant strategy, funding applications, and government incentive programs." `
  -Photo "svc-gov-photo.jpg" -Icon "icon-application.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Canadian programs can fund real growth&mdash;but the applications are competitive and time-consuming. We help you pick the right program, tell a clear story, and submit work that holds up under review.</p>
      </div>
    </section>
    <section class="hos-stat-band hos-stat-band--service" aria-label="Funding impact">
      <div class="hos-stat-band-inner">
        <div class="hos-stat-band-grid">
          <div class="hos-stat-item hos-anim"><span class="hos-stat-prefix">$</span><span class="hos-stat-num" data-target="4">0</span><span class="hos-stat-suffix">.5M+</span><div class="hos-stat-label">Funding Secured</div></div>
          <div class="hos-stat-item hos-anim"><span class="hos-stat-num" data-target="5">0</span><span class="hos-stat-suffix">M+</span><div class="hos-stat-label">Multimillion Track Record</div></div>
          <div class="hos-stat-item hos-anim"><span class="hos-stat-num" data-target="100">0</span><span class="hos-stat-suffix">%</span><div class="hos-stat-label">End-to-End Support</div></div>
        </div>
      </div>
    </section>
    <section class="hos-service-detail-content hos-section hos-service-detail-content--continued">
      <div class="hos-service-detail-inner hos-prose">
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Finding programs you actually qualify for</li>
          <li>Narratives tied to real operational outcomes</li>
          <li>Budgets and supporting documents</li>
          <li>Submission prep, deadlines, and package quality</li>
          <li>Post-award reporting when the money lands</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Why It Matters</h2>
        <p class="hos-anim">Strong applications connect your project to capacity, productivity, safety, or expansion&mdash;in language funders understand. We&rsquo;ve helped secure multimillion-dollar support, including \$4.5M+ for infrastructure and equipment, so local businesses can invest without guessing their way through the paperwork.</p>
$cta
      </div>
    </section>
"@

# Web
Update-ServicePage -Slug "web-development" `
  -Title "Web Development &amp; Maintenance | Humble Oak Solutions" `
  -Meta "Clean, responsive websites for BC businesses&mdash;plus migrations off costly builders, forms, DNS, and ongoing maintenance you own." `
  -HeroTitle "Web Development &amp; Maintenance" `
  -HeroSub "Build a clean, responsive, and high-performing web presence with ongoing support to keep your site secure, updated, and optimized." `
  -Photo "svc-web-photo.jpg" -Icon "icon-internet.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Your website should earn trust in seconds and work on every device&mdash;without locking you into another monthly platform fee. We build and maintain sites you actually own.</p>
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Responsive sites built with HTML, CSS, and JavaScript</li>
          <li>Redesigns, content updates, and performance fixes</li>
          <li>Domain, DNS, and hosting setup</li>
          <li>Contact forms and Microsoft Forms integration</li>
          <li>Basic SEO, accessibility, and mobile layout cleanup</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Leaving Costly Builders Behind</h2>
        <p class="hos-anim">A lot of businesses are still paying for a website builder years after the site was finished. When it makes sense, we can move you to a static setup&mdash;same look and content, lower ongoing cost, files in Git, and the site under your control.</p>
        <p class="hos-anim">After launch we stay available for content changes, new pages, form tweaks, broken links, DNS updates, and the small technical issues that always show up later. No unnecessary tools. Just what the site needs.</p>
$cta
      </div>
    </section>
"@

# IT
Update-ServicePage -Slug "it-systems" `
  -Title "IT Systems Administration | Humble Oak Solutions" `
  -Meta "Practical IT support for Microsoft 365, endpoints, servers, and manufacturing environments&mdash;built for busy Canadian SMBs." `
  -HeroTitle "IT Systems Administration" `
  -HeroSub "Keep your infrastructure running smoothly with expert server management, user support, backup systems, and cybersecurity best practices." `
  -Photo "svc-it-photo.jpg" -Icon "icon-it-department.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Reliable IT is invisible until it breaks. We keep Microsoft 365, devices, and business systems steady&mdash;in the office and on the shop floor.</p>
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Microsoft 365, Exchange, and hybrid setups</li>
          <li>Intune, Autopilot, and day-to-day device management</li>
          <li>Active Directory, Windows Server, and user access</li>
          <li>Shared workstations, scanners, printers, and warehouse gear</li>
          <li>Backups, hardening, documentation, and vendor coordination</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Office And Plant, Same Standard</h2>
        <p class="hos-anim">Production floors are not regular offices. We&rsquo;ve supported shared shop stations, kiosk machines, warehouse scanners, label printers, engineering apps, and ERP-connected systems&mdash;with as little disruption as possible.</p>
        <p class="hos-anim">That same hands-on approach covers onboarding and offboarding, licensing cleanups, PowerShell for the repetitive admin work, and the infrastructure upgrades that usually get stuck between vendors. Enterprise discipline, without enterprise theatre.</p>
$cta
      </div>
    </section>
"@

# BI
Update-ServicePage -Slug "business-intelligence" `
  -Title "Business Intelligence | Humble Oak Solutions" `
  -Meta "Power BI dashboards, Power Query, and KPI reporting for manufacturers and SMBs who need numbers they can trust." `
  -HeroTitle "Business Intelligence" `
  -HeroSub "Unlock the power of your data with custom KPI dashboards, reporting tools, and performance tracking solutions." `
  -Photo "svc-bi-photo.jpg" -Icon "icon-business-intelligence.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Spreadsheets hide answers. Dashboards surface them&mdash;but only if the data underneath is clean. We build reporting leadership can act on the same day.</p>
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Power BI models, Power Query, and DAX measures</li>
          <li>Executive and operational dashboards</li>
          <li>KPI definition that matches how the business actually runs</li>
          <li>Excel automation where a full BI build isn&rsquo;t needed yet</li>
          <li>Reconciliation and data-quality cleanup</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">More Than Pretty Charts</h2>
        <p class="hos-anim">We start with the question you&rsquo;re trying to answer, then dig into the source systems. Clean the data, build the relationships, check the totals against the original system, and only then design the visuals. If the numbers don&rsquo;t reconcile, the dashboard doesn&rsquo;t ship.</p>
        <p class="hos-anim">For manufacturing and operations teams, that usually means clearer visibility into production, inventory, purchasing, quality, or revenue&mdash;plus the commentary that helps leadership decide what to do next.</p>
$cta
      </div>
    </section>
"@

# Automation
Update-ServicePage -Slug "automation-integration" `
  -Title "Automation &amp; Integration | Humble Oak Solutions" `
  -Meta "Practical automation with Power Query, VBA, PowerShell, and systems integration&mdash;less manual work, fewer avoidable errors." `
  -HeroTitle "Automation &amp; Integration" `
  -HeroSub "Boost efficiency through smart systems: digital inventory, production automation, and process control technologies." `
  -Photo "svc-automation-photo.jpg" -Icon "icon-automation.png" `
  -BodyHtml @"
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
        <p class="hos-lead hos-anim">Manual handoffs cost time and introduce errors. We automate the work that repeats every week&mdash;and connect the systems that should already be talking to each other.</p>
        <h2 class="hos-heading-section hos-anim">What We Help With</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Power Query and Excel workflows that refresh instead of rebuild</li>
          <li>VBA tools for cleaning, filtering, and report generation</li>
          <li>PowerShell for Microsoft 365 and admin busywork</li>
          <li>File moves, CSV prep, and reporting pipelines</li>
          <li>Light integration between ERP, Excel, Power BI, forms, and shared folders</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Right-Sized, Not Overbuilt</h2>
        <p class="hos-anim">Not every process needs a big software project. We look at the current workflow, where the errors come from, how often it runs, and who has to maintain it. Then we recommend something your team can keep running after we&rsquo;re gone.</p>
        <p class="hos-anim">That might be a cleaner Power Query model, a small VBA helper, a PowerShell script for mailbox and license reviews, or wiring a form into a static website. Same idea every time: less busywork, fewer surprises.</p>
$cta
      </div>
    </section>
"@

# Hub accordion blurbs
$hub = Join-Path $root "services\index.html"
$hubHtml = [System.IO.File]::ReadAllText($hub)
$replacements = @{
  'We help growing Canadian teams run leaner without adding headcount&mdash;with proven results like major productivity lifts, shorter order cycles, and stronger throughput.' =
    'Hands-on process work that removes bottlenecks&mdash;with results like major productivity lifts, shorter order cycles, and stronger throughput.'
  'Hands-on leadership for facility moves, capital upgrades, commissioning, and contractor coordination through closeout.' =
    'One accountable lead for facility moves, capital upgrades, and contractor coordination through closeout.'
  'Clean, responsive websites you own&mdash;plus migration off costly builders, forms, DNS, and ongoing maintenance.' =
    'Sites you own, migrations off costly builders, and the maintenance that keeps them working.'
  'Microsoft 365, endpoints, hybrid environments, and manufacturing IT support that keeps business-critical systems reliable.' =
    'Microsoft 365, devices, and shop-floor IT support that keeps critical systems reliable.'
  'Power BI, Power Query, and KPI dashboards that leadership can trust&mdash;built from validated source data, not guesswork.' =
    'Power BI and KPI dashboards built from clean source data&mdash;not guesswork.'
  'Power Query, VBA, PowerShell, and systems integration that cut repetitive work and reduce avoidable errors.' =
    'Automate the weekly busywork and connect the systems that should already talk to each other.'
  'Grant strategy and submissions with a multimillion-dollar track record&mdash;including $4.5M+ secured for infrastructure and equipment.' =
    'Grant strategy and submissions with a multimillion-dollar track record&mdash;including $4.5M+ secured for infrastructure and equipment.'
}
foreach ($k in $replacements.Keys) {
  $hubHtml = $hubHtml.Replace($k, $replacements[$k])
}
[System.IO.File]::WriteAllText($hub, $hubHtml, [System.Text.UTF8Encoding]::new($false))
Write-Output "Updated services hub blurbs"
Write-Output "Done."
