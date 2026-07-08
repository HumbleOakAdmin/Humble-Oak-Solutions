// Run with: cscript //nologo scripts/gen-services.js  (or node if available)
// Minimal generator using WScript on Windows
var fso = new ActiveXObject("Scripting.FileSystemObject");
var root = fso.GetParentFolderName(fso.GetParentFolderName(WScript.ScriptFullName));

var json = fso.OpenTextFile(root + "\\scripts\\services-data.json", 1).ReadAll();
var services = JSON.parse(json);

var navTray = [
  '            <a href="/services/" class="hos-nav-services-overview">All Services</a>'
];
for (var i = 0; i < services.length; i++) {
  navTray.push('            <a href="/services/' + services[i].slug + '/" data-service-slug="' + services[i].slug + '">' + services[i].title + '</a>');
}

var navLinks = [
  '        <a href="/" class="hos-nav-link" data-page="home">Home</a>',
  '        <a href="/about-us/" class="hos-nav-link" data-page="about">About</a>',
  '        <div class="hos-nav-services" data-nav-section="services">',
  '          <button type="button" class="hos-nav-link hos-nav-services-btn" id="hosNavServicesBtn" aria-expanded="false" aria-controls="hosNavServicesTray">Services</button>',
  '          <div class="hos-nav-services-tray" id="hosNavServicesTray" hidden>',
  navTray.join('\n'),
  '          </div>',
  '        </div>',
  '        <a href="/our-team/" class="hos-nav-link" data-page="team">Team</a>'
].join('\n');

var navBlock = [
  '  <div class="hos-nav-backdrop" id="hosNavBackdrop" aria-hidden="true"></div>',
  '  <nav class="hos-nav" id="hosNav" aria-label="Main navigation">',
  '    <button type="button" class="hos-nav-toggle" id="hosNavToggle" aria-label="Open menu" aria-expanded="false" aria-controls="hosNavPanel">',
  '      <span></span><span></span><span></span>',
  '    </button>',
  '    <div class="hos-nav-panel" id="hosNavPanel">',
  '      <a href="/" class="hos-nav-logo"><img src="/assets/Site Images/shared/logo-webflow-small.png" alt="Humble Oak Solutions"></a>',
  '      <div class="hos-nav-links">',
  navLinks,
  '      </div>',
  '      <a href="/contact-us/" class="hos-nav-cta">Get in Touch</a>',
  '    </div>',
  '  </nav>'
].join('\n');

var footerBlock = [
  '  <footer class="hos-footer">',
  '    <div class="hos-footer-inner">',
  '      <div class="hos-footer-nav-cols">',
  '        <div><a href="/" class="hos-footer-logo">Humble Oak Solutions</a><p>Founded and operated out of British Columbia, Canada.</p>',
  '          <div class="hos-footer-social" aria-label="Social media">',
  '            <a href="https://www.linkedin.com/company/humbleoaksolutions/" class="hos-footer-social-link" target="_blank" rel="noopener noreferrer" aria-label="Humble Oak Solutions on LinkedIn">',
  '              <img src="/assets/icons/social-linkedin.svg" width="20" height="20" alt="">',
  '            </a>',
  '            <a href="https://www.instagram.com/humbleoakadmin/" class="hos-footer-social-link" target="_blank" rel="noopener noreferrer" aria-label="Humble Oak Solutions on Instagram">',
  '              <img src="/assets/icons/social-instagram.svg" width="20" height="20" alt="">',
  '            </a>',
  '          </div></div>',
  '        <div class="hos-footer-links">',
  '          <a href="/" data-page="home">Home</a>',
  '          <a href="/about-us/" data-page="about">About Us</a>',
  '          <a href="/services/" data-page="services">Our Services</a>',
  '          <a href="/our-team/" data-page="team">Our Team</a>',
  '          <a href="/contact-us/" data-page="contact">Contact Us</a>',
  '        </div>',
  '      </div>',
  '      <div class="hos-footer-bar"><span>&copy; 2026 Humble Oak Solutions &middot; BC, Canada</span></div>',
  '    </div>',
  '  </footer>'
].join('\n');

function esc(s) { return String(s).replace(/&/g, '&amp;').replace(/"/g, '&quot;'); }

function servicePage(s) {
  var iconClass = s.iconClass ? 'hos-service-icon-img ' + s.iconClass : 'hos-service-icon-img';
  var bullets = '';
  for (var b = 0; b < s.bullets.length; b++) {
    bullets += '            <li>' + s.bullets[b] + '</li>\n';
  }
  return [
    '<!doctype html>',
    '<html lang="en">',
    '<head>',
    '  <meta charset="UTF-8">',
    '  <meta name="viewport" content="width=device-width, initial-scale=1.0">',
    '  <meta name="referrer" content="strict-origin-when-cross-origin">',
    '  <meta http-equiv="X-Content-Type-Options" content="nosniff">',
    '  <meta name="robots" content="index, follow">',
    '  <link rel="canonical" href="https://www.humbleoaksolutions.com/services/' + s.slug + '/">',
    '  <title>' + esc(s.title) + ' | Humble Oak Solutions</title>',
    '  <meta name="description" content="' + esc(s.meta) + '">',
    '  <link rel="preconnect" href="https://fonts.googleapis.com">',
    '  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>',
    '  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">',
    '  <link rel="stylesheet" href="/assets/styles.css">',
    '</head>',
    '<body data-page="services" data-service="' + s.slug + '">',
    navBlock,
    '  <main>',
    '    <section class="hos-page-hero hos-service-detail-hero" style="background-image:url(\'/assets/Site Images/services/' + s.photo + '\')">',
    '      <div class="hos-page-hero-overlay"></div>',
    '      <div class="hos-page-hero-content">',
    '        <p class="hos-page-hero-tag hos-anim">Our Services</p>',
    '        <div class="hos-service-detail-hero-title hos-anim">',
    '          <img class="' + iconClass + '" src="/assets/Site Images/services/' + s.icon + '" width="48" height="48" alt="">',
    '          <h1 class="hos-page-hero-title">' + s.title + '</h1>',
    '        </div>',
    '        <p class="hos-page-hero-sub hos-anim">' + s.short + '</p>',
    '      </div>',
    '    </section>',
    '    <section class="hos-service-detail-content hos-section">',
    '      <div class="hos-service-detail-inner hos-prose">',
    '        <p class="hos-lead hos-anim">' + s.intro + '</p>',
    '        <h2 class="hos-heading-section hos-anim">What We Deliver</h2>',
    '        <ul class="hos-service-detail-list hos-anim">',
    bullets.trim(),
    '        </ul>',
    '        <p class="hos-anim">' + s.closing + '</p>',
    '        <div class="hos-service-detail-actions hos-anim">',
    '          <a href="/contact-us/" class="hos-btn hos-btn-gold">Discuss This Service</a>',
    '          <a href="/services/" class="hos-btn hos-btn-dark">All Services</a>',
    '        </div>',
    '      </div>',
    '    </section>',
    '  </main>',
    footerBlock,
    '  <script src="/assets/site.js"></script>',
    '</body>',
    '</html>'
  ].join('\n');
}

function serviceRow(s) {
  var iconClass = s.iconClass ? 'hos-service-icon-img ' + s.iconClass : 'hos-service-icon-img';
  var idNum = parseInt(s.num, 10);
  return [
    '        <div class="hos-service-row" id="svc-' + idNum + '">',
    '          <a class="hos-service-item hos-anim" href="/services/' + s.slug + '/">',
    '            <div class="hos-service-thumb" style="background-image:url(\'/assets/Site Images/services/' + s.photo + '\')" role="img" aria-label=""></div>',
    '            <div class="hos-service-num">' + s.num + '</div>',
    '            <div class="hos-service-body">',
    '              <div class="hos-service-title-row">',
    '                <img class="' + iconClass + '" src="/assets/Site Images/services/' + s.icon + '" width="40" height="40" alt="">',
    '                <h3 class="hos-heading-item">' + s.title + '</h3>',
    '              </div>',
    '              <p>' + s.short + '</p>',
    '            </div>',
    '            <span class="hos-service-toggle" aria-hidden="true">&rarr;</span>',
    '          </a>',
    '        </div>'
  ].join('\n');
}

var listRows = [];
for (var j = 0; j < services.length; j++) {
  var dir = root + '\\services\\' + services[j].slug;
  if (!fso.FolderExists(dir)) fso.CreateFolder(dir);
  var pagePath = dir + '\\index.html';
  fso.CreateTextFile(pagePath, true).Write(servicePage(services[j]));
  listRows.push(serviceRow(services[j]));
}

var listOut = root + '\\scripts\\service-list-rows.html';
fso.CreateTextFile(listOut, true).Write(listRows.join('\n\n'));

WScript.Echo('Generated ' + services.length + ' service pages');
