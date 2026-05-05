(function () {
  var nav = document.getElementById("hosNav");
  if (nav) {
    window.addEventListener("scroll", function () {
      nav.classList.toggle("scrolled", window.scrollY > 60);
    });
  }

  var page = document.body.getAttribute("data-page");
  var navLinks = document.querySelectorAll(".hos-nav-link");
  for (var i = 0; i < navLinks.length; i++) {
    if (navLinks[i].getAttribute("data-page") === page) {
      navLinks[i].classList.add("active");
    }
  }

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
    for (var j = 0; j < anims.length; j++) obs.observe(anims[j]);
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

    for (var k = 0; k < counters.length; k++) cObs.observe(counters[k]);
  }

  var serviceItems = document.querySelectorAll(".hos-service-item[data-detail-id]");
  serviceItems.forEach(function (item) {
    var detailId = item.getAttribute("data-detail-id");
    var detail = document.getElementById(detailId);
    var toggle = item.querySelector(".hos-service-toggle");
    if (!detail || !toggle) return;

    toggle.addEventListener("click", function (ev) {
      ev.preventDefault();
      ev.stopPropagation();
      var isOpen = detail.classList.contains("open");
      detail.classList.toggle("open", !isOpen);
      toggle.textContent = isOpen ? "+" : "−";
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
