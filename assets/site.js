(function () {

  document.documentElement.classList.add("js-enabled");

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



  function getServiceDetail(item) {
    var row = item.closest(".hos-service-row");
    return row ? row.querySelector(".hos-service-detail") : null;
  }

  function closeAllServiceRows() {
    document.querySelectorAll(".hos-service-detail.open").forEach(function (d) {
      d.classList.remove("open");
      d.setAttribute("hidden", "");
    });
    document.querySelectorAll(".hos-service-item.is-open").forEach(function (i) {
      i.classList.remove("is-open");
      i.setAttribute("aria-expanded", "false");
      var t = i.querySelector(".hos-service-toggle");
      if (t) t.textContent = "+";
    });
  }

  function openServiceRow(item) {
    var detail = getServiceDetail(item);
    var toggle = item.querySelector(".hos-service-toggle");
    if (!detail) return;

    closeAllServiceRows();
    detail.classList.add("open");
    detail.removeAttribute("hidden");
    item.classList.add("is-open");
    item.setAttribute("aria-expanded", "true");
    if (toggle) toggle.textContent = "\u2212";
  }

  function toggleServiceRow(item) {
    var detail = getServiceDetail(item);
    if (!detail) return;

    if (detail.classList.contains("open")) {
      closeAllServiceRows();
      return;
    }

    openServiceRow(item);
  }

  function openServiceFromHash() {
    var hash = window.location.hash.replace("#", "");
    if (!hash || hash.indexOf("svc-") !== 0) return;
    var row = document.getElementById(hash);
    var item = row
      ? row.querySelector(".hos-service-item")
      : document.querySelector('.hos-service-item[data-detail-id="' + hash + '"]');
    if (!item) return;
    openServiceRow(item);
  }

  document.querySelectorAll(".hos-service-item[data-detail-id]").forEach(function (item) {
    item.setAttribute("role", "button");
    item.setAttribute("tabindex", "0");
    item.setAttribute("aria-expanded", "false");

    item.addEventListener("click", function () {
      toggleServiceRow(item);
    });

    item.addEventListener("keydown", function (e) {
      if (e.key === "Enter" || e.key === " ") {
        e.preventDefault();
        toggleServiceRow(item);
      }
    });
  });

  document.querySelectorAll(".hos-service-detail-btn").forEach(function (btn) {
    btn.addEventListener("click", function (e) {
      e.stopPropagation();
    });
  });

  if (document.querySelector(".hos-service-item[data-detail-id]")) {
    closeAllServiceRows();
    window.addEventListener("load", openServiceFromHash);
    window.addEventListener("hashchange", openServiceFromHash);
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


