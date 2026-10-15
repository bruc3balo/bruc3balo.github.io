// Small progressive enhancements for the pre-rendered pages. Everything works as plain HTML without this file,
// except the dialogs, the Rive animations and the playground motion.
(function () {
  'use strict';

  var RIVE_VERSION = '2.44.2';
  var RIVE_URL = 'https://cdn.jsdelivr.net/npm/@rive-app/canvas@' + RIVE_VERSION + '/rive.js';

  // Dialogs: [data-open="id"] opens, [data-close] or a backdrop click closes.
  document.addEventListener('click', function (e) {
    var opener = e.target.closest('[data-open]');
    if (opener) {
      var d = document.getElementById(opener.getAttribute('data-open'));
      if (d && d.showModal) { e.preventDefault(); d.showModal(); }
      return;
    }
    var closer = e.target.closest('[data-close]');
    if (closer) { closer.closest('dialog').close(); return; }
    if (e.target.tagName === 'DIALOG') e.target.close();
  });

  // Experience labels are rendered at build time; refresh them so they never go stale.
  document.querySelectorAll('.xp[data-start]').forEach(function (el) {
    var days = Math.floor((Date.now() - new Date(el.getAttribute('data-start')).getTime()) / 86400000);
    if (days < 365) { el.textContent = days + ' days experience'; return; }
    var years = Math.round(days / 365);
    el.textContent = years + ' year' + (years === 1 ? '' : 's') + ' experience';
  });

  // Highlight the section currently on screen in the header.
  var links = document.querySelectorAll('[data-section]');
  if (links.length && 'IntersectionObserver' in window) {
    var visible = {};
    var spy = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) { visible[en.target.id] = en.isIntersecting; });
      var current = null;
      links.forEach(function (l) { if (visible[l.getAttribute('data-section')]) current = l; });
      if (!current) return;
      links.forEach(function (l) { l.classList.toggle('active', l === current); });
    }, { rootMargin: '-40% 0px -40% 0px' });
    links.forEach(function (l) {
      var s = document.getElementById(l.getAttribute('data-section'));
      if (s) spy.observe(s);
    });
    links[0].classList.add('active');
  }

  // Rive: only download the runtime once the Publications section is near the viewport.
  var menu = document.querySelector('.rive-menu');
  if (menu) {
    menu.querySelector('.rive-centre').addEventListener('click', function () { menu.classList.toggle('open'); });

    var started = false;
    var startRive = function () {
      if (started) return;
      started = true;
      var s = document.createElement('script');
      s.src = RIVE_URL;
      s.onload = function () {
        menu.querySelectorAll('canvas[data-rive]').forEach(function (canvas) {
          new window.rive.Rive({
            src: canvas.getAttribute('data-rive'),
            canvas: canvas,
            autoplay: true,
            layout: new window.rive.Layout({ fit: window.rive.Fit.Contain }),
            onLoad: function () { this.resizeDrawingSurfaceToCanvas && this.resizeDrawingSurfaceToCanvas(); }
          });
        });
      };
      document.head.appendChild(s);
    };
    if ('IntersectionObserver' in window) {
      new IntersectionObserver(function (entries, obs) {
        if (entries.some(function (en) { return en.isIntersecting; })) { obs.disconnect(); startRive(); }
      }, { rootMargin: '400px 0px' }).observe(menu);
    } else {
      startRive();
    }
  }

  // Playground: technologies drift and bounce off the edges; drag to move one, click to open it.
  var area = document.querySelector('.playground');
  if (area) {
    var SPEED = 20; // px per second, same pace as the Flutter version (10px every 500ms)
    var floaters = Array.prototype.map.call(area.querySelectorAll('.floater'), function (el) {
      return {
        el: el,
        x: Math.random() * Math.max(area.clientWidth - 130, 1),
        y: Math.random() * Math.max(area.clientHeight - 130, 1),
        dx: Math.random() < 0.5 ? -1 : 1,
        dy: Math.random() < 0.5 ? -1 : 1,
        dragging: false
      };
    });

    var last = performance.now();
    var tick = function (now) {
      var dt = Math.min((now - last) / 1000, 0.1);
      last = now;
      var maxX = area.clientWidth - 130;
      var maxY = area.clientHeight - 130;
      floaters.forEach(function (f) {
        if (!f.dragging) {
          if (f.x >= maxX) f.dx = -1; else if (f.x <= 0) f.dx = 1;
          if (f.y >= maxY) f.dy = -1; else if (f.y <= 0) f.dy = 1;
          f.x += f.dx * SPEED * dt;
          f.y += f.dy * SPEED * dt;
        }
        f.el.style.transform = 'translate(' + f.x + 'px,' + f.y + 'px)';
      });
      requestAnimationFrame(tick);
    };
    requestAnimationFrame(tick);

    floaters.forEach(function (f) {
      var startX, startY, moved;
      f.el.addEventListener('pointerdown', function (e) {
        f.dragging = true; moved = false;
        startX = e.clientX - f.x; startY = e.clientY - f.y;
        f.el.setPointerCapture(e.pointerId);
      });
      f.el.addEventListener('pointermove', function (e) {
        if (!f.dragging) return;
        var nx = e.clientX - startX, ny = e.clientY - startY;
        if (Math.abs(nx - f.x) + Math.abs(ny - f.y) > 3) moved = true;
        f.x = nx; f.y = ny;
      });
      f.el.addEventListener('pointerup', function () { f.dragging = false; });
      f.el.addEventListener('click', function (e) { if (moved) { e.preventDefault(); e.stopPropagation(); } }, true);
    });
  }
})();
