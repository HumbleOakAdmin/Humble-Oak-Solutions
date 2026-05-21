(function () {
  var nav = document.getElementById("hosNav");
  var navToggle = document.getElementById("hosNavToggle");
  var navBackdrop = document.getElementById("hosNavBackdrop");

  function setNavOpen(open) {
    if (!nav || !navToggle) return;
    nav.classList.toggle("is-open", open);
    navToggle.setAttribute("aria-expanded", open ? "true" : "false");
    navToggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
    if (navBackdrop) navBackdrop.classList.toggle("is-visible", open);
    document.body.style.overflow = open ? "hidden" : "";
  }

  if (navToggle) {
    navToggle.addEventListener("click", function () {
      setNavOpen(!nav.classList.contains("is-open"));
    });
  }

  if (navBackdrop) {
    navBackdrop.addEventListener("click", function () {
      setNavOpen(false);
    });
  }

  document.querySelectorAll(".hos-nav-links a, .hos-nav-cta").forEach(function (link) {
    link.addEventListener("click", function () {
      setNavOpen(false);
    });
  });

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") setNavOpen(false);
  });

  if (nav) {
    window.addEventListener("scroll", function () {
      nav.classList.toggle("scrolled", window.scrollY > 60);
    });
  }

  var page = document.body.getAttribute("data-page");
  document.querySelectorAll(".hos-nav-link").forEach(function (link) {
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

  function toggleServiceRow(item) {
    var detailId = item.getAttribute("data-detail-id");
    var detail = document.getElementById(detailId);
    var toggle = item.querySelector(".hos-service-toggle");
    if (!detail) return;

    var isOpen = detail.classList.contains("open");
    var nextOpen = !isOpen;

    document.querySelectorAll(".hos-service-detail.open").forEach(function (d) {
      d.classList.remove("open");
    });
    document.querySelectorAll(".hos-service-item.is-open").forEach(function (i) {
      i.classList.remove("is-open");
      i.setAttribute("aria-expanded", "false");
      var t = i.querySelector(".hos-service-toggle");
      if (t) t.textContent = "+";
    });

    if (nextOpen) {
      detail.classList.add("open");
      item.classList.add("is-open");
      item.setAttribute("aria-expanded", "true");
      if (toggle) toggle.textContent = "\u2212";
    }
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
