// Small progressive enhancements for the pre-rendered pages. Everything works as plain HTML without this file,
// except the dialogs and the Rive animations. The playground's motion lives in playground.js.
(function () {
  'use strict';

  var RIVE_VERSION = '2.44.2';
  var RIVE_URL = 'https://cdn.jsdelivr.net/npm/@rive-app/canvas@' + RIVE_VERSION + '/rive.js';
  var reducedMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  // Dialogs: [data-open="id"] opens, [data-close], Escape or a backdrop click closes. Closing plays a short
  // exit animation first (see .closing in styles.css).
  var closeDialog = function (d) {
    if (!d.open || d.classList.contains('closing')) return;
    if (reducedMotion) { d.close(); return; }
    d.classList.add('closing');
    var finished = false;
    var done = function () {
      if (finished) return;
      finished = true;
      d.removeEventListener('animationend', done);
      d.classList.remove('closing');
      d.close();
    };
    d.addEventListener('animationend', done);
    setTimeout(done, 300); // in case the animation never runs
  };
  document.addEventListener('click', function (e) {
    var opener = e.target.closest('[data-open]');
    if (opener) {
      var d = document.getElementById(opener.getAttribute('data-open'));
      if (d && d.showModal) { e.preventDefault(); d.showModal(); }
      return;
    }
    var closer = e.target.closest('[data-close]');
    if (closer) { closeDialog(closer.closest('dialog')); return; }
    if (e.target.tagName === 'DIALOG') closeDialog(e.target);
  });
  document.querySelectorAll('dialog').forEach(function (d) {
    d.addEventListener('cancel', function (e) { e.preventDefault(); closeDialog(d); });
  });

  // Experience labels are rendered at build time; refresh them so they never go stale.
  document.querySelectorAll('.xp[data-start]').forEach(function (el) {
    var days = Math.floor((Date.now() - new Date(el.getAttribute('data-start')).getTime()) / 86400000);
    if (days < 365) { el.textContent = days + ' days experience'; return; }
    var years = Math.round(days / 365);
    el.textContent = years + ' year' + (years === 1 ? '' : 's') + ' experience';
  });

  // Header gets a shadow once the page is scrolled.
  var header = document.querySelector('.site-header');
  if (header) {
    var onScroll = function () { header.classList.toggle('scrolled', window.scrollY > 8); };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  // Fade content in as it scrolls into view. Without IntersectionObserver everything is simply shown.
  var reveals = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window) {
    var revealer = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (!en.isIntersecting) return;
        en.target.classList.add('in');
        revealer.unobserve(en.target);
      });
    }, { rootMargin: '0px 0px -8% 0px' });
    reveals.forEach(function (el) { revealer.observe(el); });
  } else {
    reveals.forEach(function (el) { el.classList.add('in'); });
  }

  // Highlight the section currently on screen in the header.
  var links = document.querySelectorAll('[data-section]');
  if (links.length && 'IntersectionObserver' in window) {
    var visible = {};
    var highlight = function () {
      var current = null;
      links.forEach(function (l) { if (visible[l.getAttribute('data-section')]) current = l; });
      // The last section is too short to reach the middle band, so the bottom of the page counts as it.
      var root = document.documentElement;
      if (root.clientHeight + window.scrollY >= root.scrollHeight - 2) current = links[links.length - 1];
      if (!current) return;
      links.forEach(function (l) { l.classList.toggle('active', l === current); });
    };
    var spy = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) { visible[en.target.id] = en.isIntersecting; });
      highlight();
    }, { rootMargin: '-40% 0px -40% 0px' });
    window.addEventListener('scroll', highlight, { passive: true });
    links.forEach(function (l) {
      var s = document.getElementById(l.getAttribute('data-section'));
      if (s) spy.observe(s);
    });
    links[0].classList.add('active');
  }

  // Rive: only download the runtime once the Publications section is near the viewport.
  // The centre badge (Truth or Drink) is a one-shot animation, so it is replayed whenever it comes into view and
  // whenever the menu is toggled. The faces only play while the menu is open, starting from the beginning each time.
  var menu = document.querySelector('.rive-menu');
  if (menu) {
    var centreButton = menu.querySelector('.rive-centre');
    var centre = null;
    var faces = [];

    var replay = function (r) { if (r) { r.reset(); r.play(); } };
    var syncFaces = function () {
      var open = menu.classList.contains('open');
      faces.forEach(function (r) { if (open) replay(r); else r.pause(); });
    };

    centreButton.addEventListener('click', function () {
      var open = menu.classList.toggle('open');
      centreButton.setAttribute('aria-expanded', open ? 'true' : 'false');
      replay(centre);
      syncFaces();
    });

    var started = false;
    var startRive = function () {
      if (started) return;
      started = true;
      var s = document.createElement('script');
      s.src = RIVE_URL;
      s.onload = function () {
        var rive = window.rive;
        menu.querySelectorAll('canvas[data-rive]').forEach(function (canvas) {
          var isCentre = !!canvas.closest('.rive-centre');
          var r = new rive.Rive({
            src: canvas.getAttribute('data-rive'),
            canvas: canvas,
            autoplay: isCentre || menu.classList.contains('open'),
            layout: new rive.Layout({ fit: rive.Fit.Contain }),
            // Faces load while shrunk inside the closed menu, so sizing to their on-screen box would make them blurry
            // once they fly out; they keep the canvas's own 340px surface instead.
            onLoad: function () { if (isCentre) r.resizeDrawingSurfaceToCanvas(); }
          });
          if (isCentre) centre = r; else faces.push(r);
        });
      };
      document.head.appendChild(s);
    };

    if ('IntersectionObserver' in window) {
      new IntersectionObserver(function (entries, obs) {
        if (entries.some(function (en) { return en.isIntersecting; })) { obs.disconnect(); startRive(); }
      }, { rootMargin: '400px 0px' }).observe(menu);
      // Replay the badge each time it is actually on screen, so its intro isn't spent while scrolled away.
      new IntersectionObserver(function (entries) {
        if (entries.some(function (en) { return en.isIntersecting; })) replay(centre);
      }, { threshold: 0.6 }).observe(centreButton);
    } else {
      startRive();
    }
  }
})();
