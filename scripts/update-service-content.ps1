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
    [string]$IconClass,
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

  $iconAttr = if ($IconClass) { " class=`"hos-service-icon-img $IconClass`"" } else { ' class="hos-service-icon-img"' }

  $main = @"
  <main>
    <section class="hos-page-hero hos-service-detail-hero" style="background-image:url('/assets/Site Images/services/$Photo')">
      <div class="hos-page-hero-overlay"></div>
      <div class="hos-page-hero-content">
        <p class="hos-page-hero-tag hos-anim">Our Services</p>
        <div class="hos-service-detail-hero-title hos-anim">
          <img$iconAttr src="/assets/Site Images/services/$Icon" width="48" height="48" alt="" aria-hidden="true">
          <h1 class="hos-page-hero-title">$HeroTitle</h1>
        </div>
        <p class="hos-page-hero-sub hos-anim">$HeroSub</p>
      </div>
    </section>
    <section class="hos-service-detail-content hos-section">
      <div class="hos-service-detail-inner hos-prose">
$BodyHtml
        <div class="hos-service-detail-actions hos-anim">
          <a href="/contact-us/" class="hos-btn hos-btn-gold">Discuss This Service</a>
          <a href="/services/" class="hos-btn hos-btn-dark">All Services</a>
        </div>
      </div>
    </section>
  </main>
"@

  $html = [regex]::Replace($html, '(?s)<main>.*?</main>', $main.TrimEnd())
  [System.IO.File]::WriteAllText($path, $html, [System.Text.UTF8Encoding]::new($false))
  Write-Output "Updated $Slug"
}

# —— Operations Consulting ——
Update-ServicePage -Slug "operations-consulting" `
  -Title "Operations Consulting | Humble Oak Solutions" `
  -Meta "Operations consulting for BC manufacturers and SMBs: workflow optimization, lean improvement, inventory, KPIs, and measurable productivity gains." `
  -HeroTitle "Operations Consulting" `
  -HeroSub "Practical operations support that removes bottlenecks, improves throughput, and builds repeatable processes your team can sustain." `
  -Photo "svc-ops-photo.jpg" -Icon "icon-consultation.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">We help growing Canadian teams run leaner without adding headcount. From shop floor to back office, we map how work actually flows and remove friction that slows you down.</p>
        <div class="hos-service-impact hos-anim" aria-label="Representative results">
          <div class="hos-service-impact-item"><div class="hos-service-impact-num">+293%</div><div class="hos-service-impact-label">Productivity lift after inventory and process redesign</div></div>
          <div class="hos-service-impact-item"><div class="hos-service-impact-num">-34%</div><div class="hos-service-impact-label">Order cycle time reduction through workflow redesign</div></div>
          <div class="hos-service-impact-item"><div class="hos-service-impact-num">+31%</div><div class="hos-service-impact-label">Revenue impact from throughput and line-layout improvements</div></div>
        </div>
        <h2 class="hos-heading-section hos-anim">What We Deliver</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Process mapping, bottleneck analysis, and value-stream review</li>
          <li>Lean, 5S, and workflow optimization for production and warehouse teams</li>
          <li>Inventory management systems, SOPs, and standardized procedures</li>
          <li>Demand forecasting, costing models, and production planning</li>
          <li>KPI frameworks, staffing rhythms, and performance coaching</li>
          <li>Cross-functional coordination across operations, planning, and support teams</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">How We Work</h2>
        <p class="hos-anim">We start with how work really happens on the floor&mdash;not how it looks on a slide. That means reviewing material flow, work queues, schedule adherence, WIP, and the handoffs that create delay. Then we redesign the process, document the new standard, and coach the team so gains stick.</p>
        <p class="hos-anim">Our experience spans manufacturing, warehousing, logistics, and production planning environments, including ERP-supported scheduling and shop-order execution. The goal is always the same: clearer priorities, fewer fire drills, and measurable improvement.</p>
'@

# —— Project & Site Management ——
Update-ServicePage -Slug "project-management" `
  -Title "Project &amp; Site Management | Humble Oak Solutions" `
  -Meta "Project and site management for facility relocations, capital projects, commissioning, contractor coordination, and on-time delivery across BC." `
  -HeroTitle "Project &amp; Site Management" `
  -HeroSub "From facility moves to capital upgrades, we keep schedules, budgets, contractors, and stakeholders aligned through closeout." `
  -Photo "svc-pm-photo.jpg" -Icon "icon-hook.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">Capital projects rarely fail on ideas. They fail on coordination. We provide hands-on project and site leadership so complex work stays on schedule, under control, and ready for day-one operations.</p>
        <h2 class="hos-heading-section hos-anim">What We Deliver</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>End-to-end facility relocation and operational launch planning</li>
          <li>Capital project planning, budgeting, forecasting, and cost control</li>
          <li>Contractor, engineer, and internal stakeholder coordination</li>
          <li>Site logistics, commissioning support, and readiness checklists</li>
          <li>Site-specific safety and emergency response planning</li>
          <li>Trade coordination, milestone tracking, and quality/safety inspections</li>
          <li>Executive-ready status reporting and issue escalation</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Representative Experience</h2>
        <p class="hos-anim">Our team has led full manufacturing facility relocations&mdash;including development coordination and operational launch&mdash;while keeping production, batch systems, and support functions moving through transition. We have also managed construction and site projects where trades, materials, clients, and suppliers all needed one clear point of accountability.</p>
        <p class="hos-anim">Whether you are moving a plant, upgrading infrastructure, or commissioning new equipment, we bring practical field leadership and structured project controls so the work finishes cleanly.</p>
'@

# —— Government Funding ——
Update-ServicePage -Slug "government-funding" `
  -Title "Government Funding Applications | Humble Oak Solutions" `
  -Meta "Government funding and grant application support for Canadian SMBs: strategy, submissions, budgets, and post-award reporting with a multimillion-dollar track record." `
  -HeroTitle "Government Funding Applications" `
  -HeroSub "Secure growth capital with practical grant strategy, strong narratives, and submissions that speak the language funders expect." `
  -Photo "svc-gov-photo.jpg" -Icon "icon-application.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">Canadian programs can fund real growth, but applications are competitive and time-consuming. We help organizations identify the right programs, build a clear case, and submit work that stands up to review.</p>
        <div class="hos-service-impact hos-anim" aria-label="Funding impact">
          <div class="hos-service-impact-item"><div class="hos-service-impact-num">$4.5M+</div><div class="hos-service-impact-label">Government funding secured for infrastructure and equipment</div></div>
          <div class="hos-service-impact-item"><div class="hos-service-impact-num">Multi-M</div><div class="hos-service-impact-label">Track record supporting multimillion-dollar growth initiatives</div></div>
          <div class="hos-service-impact-item"><div class="hos-service-impact-num">End-to-end</div><div class="hos-service-impact-label">From eligibility review through submission and reporting support</div></div>
        </div>
        <h2 class="hos-heading-section hos-anim">What We Deliver</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Program identification and eligibility review</li>
          <li>Narrative development tied to real operational outcomes</li>
          <li>Budget, costing, and supporting documentation</li>
          <li>Submission preparation, deadlines, and package quality control</li>
          <li>Alignment to provincial and federal incentive programs</li>
          <li>Post-award reporting and compliance support</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Why It Matters</h2>
        <p class="hos-anim">Strong applications connect your project to measurable impact: capacity, productivity, safety, equipment modernization, or expansion. We translate operational plans into funder-ready language so you can invest in people, equipment, and infrastructure with confidence.</p>
'@

# —— Web Development ——
Update-ServicePage -Slug "web-development" `
  -Title "Web Development &amp; Website Maintenance | Humble Oak Solutions" `
  -Meta "Professional website development, GitHub Pages hosting, Webflow migration, maintenance, forms, DNS, and website support for businesses in British Columbia." `
  -HeroTitle "Practical Websites Built for Long-Term Ownership" `
  -HeroSub "Clean, responsive websites that are easy to maintain, cost-effective to host, and owned directly by your organization." `
  -Photo "svc-web-photo.jpg" -Icon "icon-internet.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">Humble Oak Solutions provides website development, migration, and maintenance for small and medium-sized organizations that need a professional online presence without unnecessary platform complexity or ongoing licensing costs.</p>
        <h2 class="hos-heading-section hos-anim">Website Development Services</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Static website development using HTML, CSS, and JavaScript</li>
          <li>Responsive desktop and mobile layouts</li>
          <li>Website redesigns and content updates</li>
          <li>Domain, DNS, and CNAME configuration</li>
          <li>Microsoft Forms and business-form integration</li>
          <li>Contact-form and email-routing configuration</li>
          <li>Basic search engine optimization</li>
          <li>Accessibility and usability improvements</li>
          <li>Website performance optimization</li>
          <li>Ongoing content and technical maintenance</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Website Migration</h2>
        <p class="hos-anim">Many organizations continue paying for website-building platforms long after the original site has been completed. We can help migrate suitable websites from platforms such as Webflow to a static hosting environment&mdash;preserving design and content while reducing recurring platform and hosting costs.</p>
        <ul class="hos-service-detail-list hos-anim">
          <li>Rebuilding or transferring existing website pages</li>
          <li>Preserving current appearance and navigation</li>
          <li>Replacing platform-specific forms</li>
          <li>Moving website files into Git version control</li>
          <li>Updating domain and DNS records</li>
          <li>Testing links, forms, layouts, and mobile compatibility</li>
          <li>Providing ownership of the completed website files</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Ongoing Maintenance</h2>
        <p class="hos-anim">Websites need occasional attention even when they are not being redesigned. We support content and image updates, new pages and service sections, form changes, broken-link repairs, domain and DNS changes, mobile layout corrections, technical troubleshooting, search metadata updates, backups and version control, and hosting and deployment support.</p>
        <h2 class="hos-heading-section hos-anim">A Practical Approach</h2>
        <p class="hos-anim">Our goal is not to introduce unnecessary tools or complexity. We assess what the website actually needs and recommend a solution that balances appearance, reliability, cost, and maintainability.</p>
        <p class="hos-anim"><strong>Need a new website, help maintaining an existing one, or a lower-cost alternative to your current platform?</strong> Contact us to discuss a practical website solution for your organization.</p>
'@

# —— IT Systems ——
Update-ServicePage -Slug "it-systems" `
  -Title "IT Systems Administration &amp; Microsoft 365 Support | Humble Oak Solutions" `
  -Meta "IT systems administration, Microsoft 365, Exchange, Intune, Active Directory, server, endpoint, and manufacturing technology support." `
  -HeroTitle "Reliable IT Support for Business-Critical Systems" `
  -HeroSub "Practical IT administration for organizations that depend on reliable infrastructure, cloud services, and connected workplace technology." `
  -Photo "svc-it-photo.jpg" -Icon "icon-it-department.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">Humble Oak Solutions provides practical IT systems administration and technical support for organizations that depend on reliable infrastructure, cloud services, business applications, and connected workplace technology. Our experience includes supporting office, manufacturing, warehouse, production, finance, engineering, and executive environments.</p>
        <h2 class="hos-heading-section hos-anim">IT Administration Services</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Microsoft 365 administration</li>
          <li>Exchange Online and hybrid Exchange support</li>
          <li>Microsoft Intune and mobile device management</li>
          <li>Windows Autopilot</li>
          <li>Active Directory and Group Policy</li>
          <li>Windows Server administration</li>
          <li>User account and access management</li>
          <li>Shared mailbox and distribution group administration</li>
          <li>Licensing and subscription management</li>
          <li>Endpoint deployment and configuration</li>
          <li>Shop-floor and shared workstation support</li>
          <li>Printer, scanner, and warehouse device support</li>
          <li>SQL Server access administration</li>
          <li>VMware ESXi support</li>
          <li>Storage and infrastructure coordination</li>
          <li>Domain, DNS, and website hosting support</li>
          <li>Technical documentation and user training</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Microsoft 365 and Hybrid Environments</h2>
        <p class="hos-anim">We support organizations using Microsoft 365 alongside existing on-premises systems, including onboarding and offboarding, mailbox administration, distribution groups, license review, Exchange hybrid troubleshooting, mobile and endpoint policies, Intune configuration, conditional access coordination, Microsoft Forms support, administrative scripting, and process documentation.</p>
        <h2 class="hos-heading-section hos-anim">Manufacturing and Operational IT</h2>
        <p class="hos-anim">Production and warehouse environments need a different approach than standard office IT. Our experience includes shared production workstations, shop-floor access, clock-in stations, warehouse scanners and mobile devices, kiosk-mode computers, label printers, engineering applications, product lifecycle management systems, ERP-connected operations, production displays, remote support tools, and other business-critical plant systems&mdash;with a focus on minimizing disruption.</p>
        <h2 class="hos-heading-section hos-anim">Enterprise Application Support</h2>
        <p class="hos-anim">We provide administration and operational support for ERP, PLM, Microsoft 365, Exchange, Intune, engineering data management, SQL-based applications, VMware environments, integration platforms, and production or warehouse systems. Support may include access management, troubleshooting, vendor coordination, documentation, testing, configuration assistance, and process improvement.</p>
        <h2 class="hos-heading-section hos-anim">Infrastructure and Security</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Cybersecurity hardening and vulnerability review coordination</li>
          <li>Server and storage modernization</li>
          <li>Managed service provider coordination</li>
          <li>Endpoint standardization and legacy system review</li>
          <li>Backup and recovery planning</li>
          <li>Software and license inventories</li>
          <li>Vendor and service-provider management</li>
          <li>Security documentation and infrastructure migration planning</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Representative Projects</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Deploying managed warehouse and production devices</li>
          <li>Configuring Microsoft Intune kiosk environments</li>
          <li>Modernizing shared shop-floor workstations</li>
          <li>Implementing Active Directory-based production access</li>
          <li>Supporting hybrid Microsoft 365 environments</li>
          <li>Reducing dependence on external ERP support</li>
          <li>Coordinating server, storage, and security upgrades</li>
          <li>Supporting ERP, PLM, production, warehouse, and engineering systems</li>
          <li>Creating PowerShell tools for administrative tasks</li>
          <li>Migrating websites to lower-cost hosting platforms</li>
        </ul>
        <p class="hos-anim"><strong>Need support managing Microsoft 365, business systems, endpoints, infrastructure, or operational technology?</strong> Contact us to discuss your current environment and support requirements.</p>
'@

# —— Business Intelligence ——
Update-ServicePage -Slug "business-intelligence" `
  -Title "Power BI &amp; Business Intelligence Consulting | Humble Oak Solutions" `
  -Meta "Power BI dashboards, Power Query, DAX, Excel automation, KPI development, manufacturing analytics, inventory reporting, and executive business intelligence." `
  -HeroTitle "Turn Operational Data Into Better Decisions" `
  -HeroSub "Practical business intelligence that helps organizations understand performance, identify risks, and act with confidence." `
  -Photo "svc-bi-photo.jpg" -Icon "icon-business-intelligence.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">Humble Oak Solutions develops practical business intelligence solutions that help organizations understand performance, identify risks, and make better operational decisions. Our approach goes beyond building charts. We work to understand the underlying process, define meaningful measures, validate the source data, and create reporting that management can trust.</p>
        <h2 class="hos-heading-section hos-anim">Business Intelligence Services</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Microsoft Power BI development</li>
          <li>Power Query and DAX</li>
          <li>Excel reporting and VBA</li>
          <li>SQL, data modelling, cleansing, and transformation</li>
          <li>KPI development</li>
          <li>Executive and operational dashboards</li>
          <li>Automated reporting and forecasting</li>
          <li>Exception reporting and source-system reconciliation</li>
          <li>Data-quality analysis</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">From Raw Data to Reliable Reporting</h2>
        <p class="hos-anim">A useful dashboard requires more than connecting to a spreadsheet. Our process may include understanding the business question, reviewing source systems, defining reporting logic, cleaning and standardizing data, building relationships between sources, developing measures, reconciling results to the original system, testing filters and reporting periods, designing clear visuals, and documenting the final solution.</p>
        <h2 class="hos-heading-section hos-anim">Manufacturing and Operations Analytics</h2>
        <p class="hos-anim">Dashboards should help leadership understand what changed, why it changed, where risk is concentrated, which issues need attention, and what action should come next. We can support both the technical dashboard and the management-level commentary used to communicate results.</p>
        <h2 class="hos-heading-section hos-anim">Data Quality and Reconciliation</h2>
        <p class="hos-anim">Reporting often reveals problems that already exist in source systems. We help identify duplicate records, missing dates, invalid status values, inconsistent naming, broken relationships, incorrect master data, misaligned reporting periods, unreconciled totals, incomplete historical records, and manual process gaps&mdash;so the organization can improve both the report and the underlying process.</p>
        <p class="hos-anim"><strong>Need clearer visibility into production, purchasing, inventory, quality, revenue, or operational performance?</strong> Contact us to discuss your reporting requirements and available data sources.</p>
'@

# —— Automation & Integration ——
Update-ServicePage -Slug "automation-integration" `
  -Title "Business Process Automation &amp; Systems Integration | Humble Oak Solutions" `
  -Meta "Power Query, VBA, PowerShell, Microsoft 365, data transformation, reporting automation, website forms, and business systems integration." `
  -HeroTitle "Reduce Repetitive Work and Improve Process Reliability" `
  -HeroSub "Practical automation and integration for recurring processes that consume time, create errors, or depend too heavily on manual work." `
  -Photo "svc-automation-photo.jpg" -Icon "icon-automation.png" -IconClass "" `
  -BodyHtml @'
        <p class="hos-lead hos-anim">Humble Oak Solutions helps organizations reduce manual effort by creating practical automation and integration solutions for recurring business processes. We focus on tasks that consume time, create avoidable errors, or depend too heavily on manual intervention.</p>
        <h2 class="hos-heading-section hos-anim">Automation Services</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Power Query automation</li>
          <li>Excel VBA</li>
          <li>PowerShell scripting</li>
          <li>Microsoft Forms</li>
          <li>CSV and Excel transformation</li>
          <li>File-processing automation</li>
          <li>Reporting workflow automation</li>
          <li>Microsoft 365 administration scripts</li>
          <li>Website form integration</li>
          <li>Git and GitHub workflows</li>
          <li>Integration-platform support</li>
          <li>Automated data refresh and exception reporting</li>
          <li>Process standardization</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">Excel and Power Query Automation</h2>
        <p class="hos-anim">Many organizations rely on spreadsheets that require the same manual preparation every week or month. We can automate importing files, combining exports, cleaning values, removing duplicates, applying business rules, standardizing dates, matching records between systems, filtering unnecessary rows, creating repeatable outputs, and refreshing Power BI data models.</p>
        <h2 class="hos-heading-section hos-anim">VBA, PowerShell, and Microsoft 365</h2>
        <p class="hos-anim">VBA remains useful for established Excel workflows such as data-cleaning tools, report-generation macros, deduplication, import/export, formatting, validation, and exception highlighting. PowerShell can improve consistency for user and contact exports, mailbox administration, distribution groups, license reviews, Exchange tasks, file processing, and other repeatable administrative work.</p>
        <h2 class="hos-heading-section hos-anim">System and Data Integration</h2>
        <p class="hos-anim">Organizations often depend on information moving between systems that were not designed to work together. Our experience includes workflows involving ERP, PLM, Microsoft 365, Excel, Power BI, SQL databases, website forms, shared folders, CSV files, integration platforms, GitHub, and reporting systems&mdash;covering extraction, preparation, field mapping, validation, troubleshooting, and documentation.</p>
        <h2 class="hos-heading-section hos-anim">Representative Projects</h2>
        <ul class="hos-service-detail-list hos-anim">
          <li>Automating recurring Excel and Power Query reporting</li>
          <li>Building VBA tools for filtering and deduplication</li>
          <li>Processing ERP exports into Power BI models</li>
          <li>Creating PowerShell tools for Microsoft 365 administration</li>
          <li>Embedding Microsoft Forms into static websites</li>
          <li>Automating file movement and transformation</li>
          <li>Supporting enterprise system integrations</li>
          <li>Standardizing recurring business reports</li>
          <li>Replacing manual preparation with refreshable data models</li>
          <li>Creating error checks and exception reports</li>
        </ul>
        <h2 class="hos-heading-section hos-anim">A Practical Automation Approach</h2>
        <p class="hos-anim">Not every process requires a large software implementation. We begin by reviewing the current workflow, systems involved, manual steps, common errors, desired output, frequency, and the people who maintain it. From there, we recommend an appropriate level of automation that the organization can support over time.</p>
        <p class="hos-anim"><strong>Have a recurring spreadsheet, reporting, file-processing, or administrative task that takes too much time?</strong> Contact us to discuss how it may be simplified or automated.</p>
'@

Write-Output "All service pages updated."
