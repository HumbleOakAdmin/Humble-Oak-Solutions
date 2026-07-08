(function () {
  var nav = document.getElementById("hosNav");
  var navToggle = document.getElementById("hosNavToggle");
  var navBackdrop = document.getElementById("hosNavBackdrop");
  var navServices = document.querySelector(".hos-nav-services");
  var navServicesBtn = document.getElementById("hosNavServicesBtn");
  var navServicesTray = document.getElementById("hosNavServicesTray");

  function setNavOpen(open) {
    if (!nav || !navToggle) return;
    nav.classList.toggle("is-open", open);
    navToggle.setAttribute("aria-expanded", open ? "true" : "false");
    navToggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
    if (navBackdrop) navBackdrop.classList.toggle("is-visible", open);
    if (!open) setServicesTrayOpen(false);
  }

  function setServicesTrayOpen(open) {
    if (!navServices || !navServicesBtn || !navServicesTray) return;
    navServices.classList.toggle("is-open", open);
    navServicesBtn.classList.toggle("active", open);
    navServicesBtn.setAttribute("aria-expanded", open ? "true" : "false");
    if (open) navServicesTray.removeAttribute("hidden");
    else navServicesTray.setAttribute("hidden", "");
  }

  if (navToggle) {
    navToggle.addEventListener("click", function () {
      setNavOpen(!nav.classList.contains("is-open"));
    });
  }

  if (navServicesBtn) {
    navServicesBtn.addEventListener("click", function (e) {
      e.stopPropagation();
      if (!nav || !nav.classList.contains("is-open")) {
        setNavOpen(true);
        setServicesTrayOpen(true);
        return;
      }
      setServicesTrayOpen(!navServices.classList.contains("is-open"));
    });
  }

  document.querySelectorAll(".hos-nav-links a:not(.hos-nav-services-overview), .hos-nav-services-tray a, .hos-nav-cta").forEach(function (link) {
    link.addEventListener("click", function () {
      setNavOpen(false);
      setServicesTrayOpen(false);
    });
  });

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      setServicesTrayOpen(false);
      setNavOpen(false);
    }
  });

  document.addEventListener("click", function (e) {
    if (!navServices || !navServices.classList.contains("is-open")) return;
    if (navServices.contains(e.target)) return;
    setServicesTrayOpen(false);
  });

  if (nav) {
    window.addEventListener("scroll", function () {
      nav.classList.toggle("scrolled", window.scrollY > 60);
    });
  }

  var page = document.body.getAttribute("data-page");
  var serviceSlug = document.body.getAttribute("data-service");
  document.querySelectorAll(".hos-nav-link").forEach(function (link) {
    if (link.getAttribute("data-page") === page) link.classList.add("active");
  });
  if (page === "services") {
    if (navServicesBtn) navServicesBtn.classList.add("active");
    if (serviceSlug) {
      var activeService = document.querySelector('.hos-nav-services-tray a[data-service-slug="' + serviceSlug + '"]');
      if (activeService) activeService.classList.add("active");
    } else {
      var overview = document.querySelector(".hos-nav-services-overview");
      if (overview && window.location.pathname.replace(/\/$/, "") === "/services") overview.classList.add("active");
    }
  }
  document.querySelectorAll(".hos-footer-links a[data-page]").forEach(function (link) {
    if (link.getAttribute("data-page") === page) link.classList.add("active");
  });

  var anims = document.querySelectorAll(".hos-anim");
  if (anims.length) {
    var obs = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("visible");
            obs.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.15 }
    );
    anims.forEach(function (el) {
      obs.observe(el);
    });
  }

  var counters = document.querySelectorAll(".hos-stat-num");
  if (counters.length) {
    var cObs = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (!entry.isIntersecting) return;
          var el = entry.target;
          var target = parseInt(el.getAttribute("data-target"), 10) || 0;
          var dur = 1500;
          var start = null;

          function frame(ts) {
            if (!start) start = ts;
            var p = Math.min((ts - start) / dur, 1);
            el.textContent = Math.floor((1 - Math.pow(1 - p, 3)) * target);
            if (p < 1) requestAnimationFrame(frame);
            else el.textContent = String(target);
          }
          requestAnimationFrame(frame);
          cObs.unobserve(el);
        });
      },
      { threshold: 0.5 }
    );
    counters.forEach(function (el) {
      cObs.observe(el);
    });
  }

  var form = document.getElementById("hosContactForm");
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var first = form.querySelector("[name='firstName']").value.trim();
      var last = form.querySelector("[name='lastName']").value.trim();
      var email = form.querySelector("[name='email']").value.trim();
      var company = form.querySelector("[name='company']").value.trim();
      var message = form.querySelector("[name='message']").value.trim();
      var subject = encodeURIComponent("Website Contact Form Submission");
      var body = encodeURIComponent(
        "Name: " +
          first +
          " " +
          last +
          "\nEmail: " +
          email +
          "\nCompany: " +
          company +
          "\n\nMessage:\n" +
          message
      );
      window.location.href =
        "mailto:info@humbleoaksolutions.com?subject=" + subject + "&body=" + body;
    });
  }
})();
