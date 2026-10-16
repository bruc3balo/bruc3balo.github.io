// Skills playground: the technologies are circles in a small physics world, and the mode selector changes the
// rules of that world. Bubbles collide like billiard balls, magnets pull one skill's tools together,
// constellations join a skill's stars with lines, the ball pit adds gravity and breakout turns them into bricks.
// The loop pauses while the tab is hidden and whenever a mode has come to rest.
(function () {
  'use strict';

  var root = document.querySelector('.playground');
  if (!root) return;
  var arena = root.querySelector('.pg-arena');
  var lines = root.querySelector('.pg-lines');
  var paddleEl = root.querySelector('.pg-paddle');
  var ballEl = root.querySelector('.pg-ball');
  var scoreEl = root.querySelector('.pg-score');
  var briefs = root.querySelectorAll('.pg-brief');
  var chips = root.querySelectorAll('.pg-chip');
  var modeButtons = root.querySelectorAll('.pg-mode');

  // With reduced motion the technologies stay in the plain wrapped layout from styles.css.
  if (window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    root.classList.add('static');
    return;
  }

  var SVG = 'http://www.w3.org/2000/svg';
  var YEAR = 365 * 24 * 3600 * 1000;
  var W = 0, H = 0;

  var bodies = Array.prototype.map.call(arena.querySelectorAll('.floater'), function (el) {
    return {
      el: el,
      skill: +el.getAttribute('data-skill'),
      years: Math.max((Date.now() - Date.parse(el.getAttribute('data-start'))) / YEAR, 0.3),
      x: 0, y: 0, vx: 0, vy: 0,
      s: 1, ts: 1, // current and target scale
      squash: 0,
      tx: null, ty: null, // spring target, when a mode pins a body somewhere
      alive: true, // false once knocked out in breakout
      entering: false, // dropping in from above the arena in the ball pit
      dragging: false
    };
  });
  var maxYears = Math.max.apply(null, bodies.map(function (b) { return b.years; }));
  var fit = 1; // shrinks everything on small screens so the bodies never fill more than about a third of the arena

  var measure = function () {
    W = arena.clientWidth;
    H = arena.clientHeight;
    bodies.forEach(function (b) {
      var cover = b.el.querySelector('.cover');
      b.ox = cover.offsetLeft + cover.offsetWidth / 2;
      b.oy = cover.offsetTop + cover.offsetHeight / 2;
      b.r0 = cover.offsetWidth / 2 + 6;
      b.el.style.transformOrigin = b.ox + 'px ' + b.oy + 'px';
    });
    var area = bodies.reduce(function (sum, b) { return sum + Math.PI * b.r0 * b.r0; }, 0);
    fit = Math.min(1, Math.sqrt(0.35 * W * H / area));
  };
  var radius = function (b) { return b.r0 * b.s; };

  // Skill pairs, for the constellation lines.
  var pairs = [];
  bodies.forEach(function (a, i) {
    bodies.slice(i + 1).forEach(function (b) {
      if (a.skill !== b.skill) return;
      var line = document.createElementNS(SVG, 'line');
      line.style.stroke = getComputedStyle(a.el).getPropertyValue('--skill');
      lines.appendChild(line);
      pairs.push({ a: a, b: b, line: line });
    });
  });

  var showBrief = function (skill) {
    Array.prototype.forEach.call(briefs, function (el) {
      el.classList.toggle('show', +el.getAttribute('data-skill') === skill);
    });
  };

  // Keeps a free body moving at roughly [speed] px/s, so the drift never dies out or runs away.
  var cruise = function (b, speed, dt) {
    var v = Math.hypot(b.vx, b.vy);
    if (v < 1) { var a = Math.random() * Math.PI * 2; b.vx = Math.cos(a); b.vy = Math.sin(a); v = 1; }
    var k = 1 + (speed / v - 1) * Math.min(dt * 1.5, 1);
    b.vx *= k; b.vy *= k;
  };

  // A critically damped spring towards the body's target.
  var spring = function (b, stiffness, dt) {
    var c = 2 * Math.sqrt(stiffness);
    b.vx += (stiffness * (b.tx - b.x) - c * b.vx) * dt;
    b.vy += (stiffness * (b.ty - b.y) - c * b.vy) * dt;
  };

  var scatter = function (b) {
    var r = radius(b);
    b.x = r + Math.random() * Math.max(W - 2 * r, 1);
    b.y = r + Math.random() * Math.max(H - 2 * r, 1);
  };

  // ----- Modes -----

  var magnet = null; // skill pulled together in magnets mode
  var lit = null; // skill lit up in constellations mode
  var pointer = { x: -1e4, y: -1e4, vx: 0, vy: 0, t: 0 };
  var gravity = { x: 0, y: 1 };

  var modes = {
    bubbles: {
      collide: true, bounce: 1, drag: true,
      enter: function () {
        bodies.forEach(function (b) { b.ts = fit * (0.6 + 0.6 * b.years / maxYears); });
      },
      forces: function (dt) {
        bodies.forEach(function (b) { cruise(b, 45, dt); });
      }
    },

    magnets: {
      collide: true, bounce: 0.6, drag: true,
      enter: function () {
        bodies.forEach(function (b) { b.ts = fit * 0.8; });
      },
      forces: function (dt) {
        var cx = W / 2, cy = H * 0.3;
        var clear = Math.min(W, H) * 0.32; // room the others leave around the cluster
        bodies.forEach(function (b) {
          if (magnet === b.skill) {
            b.tx = cx; b.ty = cy;
            spring(b, 8, dt);
            return;
          }
          cruise(b, magnet === null ? 45 : 30, dt);
          if (magnet !== null) {
            var dx = b.x - cx, dy = b.y - cy, d = Math.hypot(dx, dy) || 1;
            if (d < clear) { b.vx += dx / d * 900 * dt; b.vy += dy / d * 900 * dt; }
          }
        });
      }
    },

    stars: {
      collide: false, bounce: 1, drag: true,
      enter: function () {
        bodies.forEach(function (b) { b.ts = fit * 0.55; });
      },
      forces: function (dt) {
        bodies.forEach(function (b) { cruise(b, 16, dt); });
      },
      after: function () {
        var reach = Math.max(W, H) * 0.3;
        pairs.forEach(function (p) {
          var d = Math.hypot(p.a.x - p.b.x, p.a.y - p.b.y);
          var o = lit === p.a.skill ? 0.95 : lit === null ? Math.max(0, 1 - d / reach) * 0.55 : 0.08;
          p.line.setAttribute('x1', p.a.x); p.line.setAttribute('y1', p.a.y);
          p.line.setAttribute('x2', p.b.x); p.line.setAttribute('y2', p.b.y);
          p.line.style.opacity = o;
        });
      }
    },

    pit: {
      collide: true, bounce: 0.3, drag: true, sleeps: true,
      enter: function () {
        bodies.forEach(function (b, i) {
          b.ts = fit * 0.85;
          b.s = b.ts;
          b.x = radius(b) + Math.random() * Math.max(W - 2 * radius(b), 1);
          b.y = -radius(b) - i * 70;
          b.vx = (Math.random() - 0.5) * 120;
          b.vy = 0;
          b.entering = true;
        });
      },
      forces: function (dt) {
        var g = 1600;
        var push = Date.now() - pointer.t < 120;
        bodies.forEach(function (b) {
          b.vx += gravity.x * g * dt;
          b.vy += gravity.y * g * dt;
          var drag = Math.exp(-0.6 * dt);
          b.vx *= drag; b.vy *= drag;
          if (!push) return;
          var dx = b.x - pointer.x, dy = b.y - pointer.y, d = Math.hypot(dx, dy) || 1, reach = radius(b) + 50;
          if (d < reach) {
            var f = 1 - d / reach;
            b.vx += (dx / d * 500 + pointer.vx * 0.5) * f;
            b.vy += (dy / d * 500 + pointer.vy * 0.5) * f;
          }
        });
      }
    },

    breakout: {
      collide: false, bounce: 0.2, drag: false,
      enter: function () { layoutBricks(); resetBall(); updateScore(); },
      forces: function (dt) {
        bodies.forEach(function (b) {
          if (b.alive) { spring(b, 90, dt); return; }
          b.vy += 1400 * dt; // knocked loose: falls out of the arena
        });
      },
      after: function (dt) { stepBall(dt); }
    }
  };

  // ----- Breakout -----

  var ball = { x: 0, y: 0, vx: 0, vy: 0, r: 9, wait: 0 };
  var paddle = { x: 0, w: 120, h: 12 };
  var paddleY = function () { return H - 28; };

  var layoutBricks = function () {
    var n = bodies.length;
    var cols = Math.max(3, Math.min(n, Math.floor(W / 110)));
    var rows = Math.ceil(n / cols);
    var cellW = W / cols, cellH = Math.min(H * 0.5 / rows, cellW);
    bodies.forEach(function (b, i) {
      var row = Math.floor(i / cols), inRow = Math.min(cols, n - row * cols);
      b.ts = Math.min(fit * 0.6, (Math.min(cellW, cellH) * 0.42) / b.r0);
      b.tx = (W - inRow * cellW) / 2 + (i % cols + 0.5) * cellW;
      b.ty = 24 + (row + 0.5) * cellH;
    });
    paddle.w = Math.max(90, Math.min(160, W * 0.22));
  };

  var resetBall = function () {
    ball.x = paddle.x || W / 2;
    ball.y = paddleY() - ball.r - 2;
    ball.vx = 0; ball.vy = 0;
    ball.wait = 0.8;
  };

  var updateScore = function () {
    var out = bodies.filter(function (b) { return !b.alive; }).length;
    scoreEl.textContent = out + ' / ' + bodies.length;
    root.classList.toggle('cleared', out === bodies.length);
  };

  var stepBall = function (dt) {
    if (!paddle.x) paddle.x = W / 2;
    var py = paddleY();
    var speed = Math.max(320, Math.min(W, H) * 0.75);
    if (ball.wait > 0) {
      ball.wait -= dt;
      ball.x = paddle.x; ball.y = py - ball.r - 2;
      if (ball.wait <= 0 && !root.classList.contains('cleared')) {
        var a = (Math.random() - 0.5) * 0.8;
        ball.vx = speed * Math.sin(a); ball.vy = -speed * Math.cos(a);
      }
      return;
    }
    ball.x += ball.vx * dt; ball.y += ball.vy * dt;
    if (ball.x < ball.r) { ball.x = ball.r; ball.vx = Math.abs(ball.vx); }
    if (ball.x > W - ball.r) { ball.x = W - ball.r; ball.vx = -Math.abs(ball.vx); }
    if (ball.y < ball.r) { ball.y = ball.r; ball.vy = Math.abs(ball.vy); }
    if (ball.y > H + ball.r) { resetBall(); return; }

    // Paddle: where the ball lands on it sets the bounce angle.
    if (ball.vy > 0 && ball.y + ball.r >= py && ball.y < py + paddle.h && Math.abs(ball.x - paddle.x) <= paddle.w / 2 + ball.r) {
      var off = Math.max(-1, Math.min(1, (ball.x - paddle.x) / (paddle.w / 2)));
      ball.vx = speed * Math.sin(off * 1.05);
      ball.vy = -speed * Math.cos(off * 1.05);
      ball.y = py - ball.r;
    }

    bodies.forEach(function (b) {
      if (!b.alive) return;
      var dx = ball.x - b.x, dy = ball.y - b.y, d = Math.hypot(dx, dy) || 1, min = radius(b) + ball.r;
      if (d >= min) return;
      var nx = dx / d, ny = dy / d, vn = ball.vx * nx + ball.vy * ny;
      if (vn < 0) { ball.vx -= 2 * vn * nx; ball.vy -= 2 * vn * ny; }
      ball.x = b.x + nx * min; ball.y = b.y + ny * min;
      b.alive = false;
      b.el.classList.add('knocked');
      b.vx = -nx * 150 + (Math.random() - 0.5) * 100;
      b.vy = -260;
      b.squash = 1;
      updateScore();
    });
  };

  // ----- Simulation -----

  var mode = modes.bubbles;
  var modeName = 'bubbles';

  var collideAll = function () {
    var e = mode.bounce;
    for (var i = 0; i < bodies.length; i++) {
      var a = bodies[i];
      for (var j = i + 1; j < bodies.length; j++) {
        var b = bodies[j];
        var dx = b.x - a.x, dy = b.y - a.y, min = radius(a) + radius(b);
        if (dx * dx + dy * dy >= min * min) continue;
        var d = Math.sqrt(dx * dx + dy * dy) || 0.01, nx = dx / d, ny = dy / d;
        // Mass grows with area; a dragged body acts as if it were immovable.
        var ia = a.dragging ? 0 : 1 / (radius(a) * radius(a)), ib = b.dragging ? 0 : 1 / (radius(b) * radius(b));
        if (ia + ib === 0) continue;
        var push = (min - d) / (ia + ib);
        a.x -= nx * push * ia; a.y -= ny * push * ia;
        b.x += nx * push * ib; b.y += ny * push * ib;
        var vn = (b.vx - a.vx) * nx + (b.vy - a.vy) * ny;
        if (vn >= 0) continue;
        var jn = -(1 + e) * vn / (ia + ib);
        a.vx -= jn * ia * nx; a.vy -= jn * ia * ny;
        b.vx += jn * ib * nx; b.vy += jn * ib * ny;
        if (-vn > 80) { a.squash = Math.min(1, -vn / 600); b.squash = a.squash; }
      }
    }
  };

  var walls = function (b) {
    var r = radius(b), e = mode.bounce;
    if (modeName === 'breakout' && !b.alive) return; // falls out through the floor
    if (b.x < r) { b.x = r; if (b.vx < 0) b.vx = -b.vx * e; }
    if (b.x > W - r) { b.x = W - r; if (b.vx > 0) b.vx = -b.vx * e; }
    if (b.entering) { if (b.y > r) b.entering = false; } else if (b.y < r) { b.y = r; if (b.vy < 0) b.vy = -b.vy * e; }
    if (b.y > H - r) { b.y = H - r; if (b.vy > 0) b.vy = -b.vy * e; }
  };

  var render = function () {
    bodies.forEach(function (b) {
      var q = b.squash * 0.18;
      b.el.style.transform = 'translate(' + (b.x - b.ox) + 'px,' + (b.y - b.oy) + 'px) scale(' +
        b.s * (1 + q) + ',' + b.s * (1 - q) + ')';
    });
    if (modeName === 'breakout') {
      paddleEl.style.transform = 'translate(' + (paddle.x - paddle.w / 2) + 'px,' + paddleY() + 'px)';
      paddleEl.style.width = paddle.w + 'px';
      ballEl.style.transform = 'translate(' + (ball.x - ball.r) + 'px,' + (ball.y - ball.r) + 'px)';
    }
  };

  var running = false, last = 0, still = 0;
  var tick = function (now) {
    if (!running) return;
    var dt = Math.min((now - last) / 1000, 1 / 30);
    last = now;
    mode.forces(dt);
    var moving = false;
    bodies.forEach(function (b) {
      b.s += (b.ts - b.s) * Math.min(dt * 6, 1);
      b.squash *= Math.exp(-9 * dt);
      b.px = b.x; b.py = b.y;
      if (b.dragging) return;
      b.x += b.vx * dt;
      b.y += b.vy * dt;
    });
    // A few passes keep stacks in the ball pit from sinking into each other.
    if (mode.collide) for (var k = 0; k < (mode.sleeps ? 3 : 1); k++) collideAll();
    bodies.forEach(walls);
    // Judge rest by how far things actually moved: in the pit gravity keeps adding speed that contact cancels.
    bodies.forEach(function (b) { if (Math.abs(b.x - b.px) + Math.abs(b.y - b.py) > 0.3) moving = true; });
    if (mode.after) mode.after(dt);
    render();
    // The ball pit stops the loop once everything has settled; any push wakes it again.
    still = moving || bodies.some(function (b) { return b.dragging; }) ? 0 : still + dt;
    if (mode.sleeps && still > 1) { running = false; return; }
    requestAnimationFrame(tick);
  };
  var wake = function () {
    still = 0;
    if (running || document.hidden) return;
    running = true;
    last = performance.now();
    requestAnimationFrame(tick);
  };
  document.addEventListener('visibilitychange', function () {
    if (document.hidden) running = false; else wake();
  });

  var setMode = function (name) {
    if (!modes[name]) name = 'bubbles';
    modeName = name;
    mode = modes[name];
    root.setAttribute('data-mode', name);
    root.classList.remove('cleared', 'pulling');
    Array.prototype.forEach.call(modeButtons, function (btn) {
      btn.setAttribute('aria-pressed', String(btn.getAttribute('data-mode') === name));
    });
    bodies.forEach(function (b) {
      b.tx = b.ty = null;
      b.entering = false;
      b.el.classList.remove('knocked', 'lit');
      if (!b.alive || b.y > H + radius(b)) scatter(b);
      b.alive = true;
    });
    magnet = null; lit = null;
    setChips();
    showBrief(null);
    measure(); // this mode's controls may have changed the arena's height
    mode.enter();
    if (history.replaceState) history.replaceState(null, '', '#' + name);
    wake();
  };

  var setChips = function () {
    Array.prototype.forEach.call(chips, function (c) {
      c.setAttribute('aria-pressed', String(+c.getAttribute('data-skill') === magnet));
    });
  };

  // ----- Input -----

  Array.prototype.forEach.call(modeButtons, function (btn) {
    btn.addEventListener('click', function () { setMode(btn.getAttribute('data-mode')); });
  });

  Array.prototype.forEach.call(chips, function (c) {
    c.addEventListener('click', function () {
      var s = +c.getAttribute('data-skill');
      magnet = magnet === s ? null : s;
      root.classList.toggle('pulling', magnet !== null);
      bodies.forEach(function (b) { b.el.classList.toggle('lit', b.skill === magnet); });
      setChips();
      showBrief(magnet);
      wake();
    });
  });

  root.querySelector('.pg-shake').addEventListener('click', function () {
    bodies.forEach(function (b) {
      b.vx += (Math.random() - 0.5) * 900;
      b.vy -= 700 + Math.random() * 700;
    });
    wake();
  });

  root.querySelector('.pg-reset').addEventListener('click', function () { setMode('breakout'); });

  // Constellations: hovering or focusing a star lights up its skill.
  bodies.forEach(function (b) {
    var light = function (on) {
      if (modeName !== 'stars') return;
      lit = on ? b.skill : null;
      bodies.forEach(function (o) { o.el.classList.toggle('lit', lit !== null && o.skill === lit); });
      showBrief(lit);
    };
    b.el.addEventListener('pointerenter', function () { light(true); });
    b.el.addEventListener('pointerleave', function () { light(false); });
    b.el.addEventListener('focus', function () { light(true); });
    b.el.addEventListener('blur', function () { light(false); });
  });

  // Dragging: drag a body around, and in the free modes let go to fling it. A drag never opens the dialog.
  bodies.forEach(function (b) {
    var grabX, grabY, moved, lastX, lastY, lastT;
    b.el.addEventListener('pointerdown', function (e) {
      if (!mode.drag) return;
      b.dragging = true; moved = false;
      b.el.classList.add('dragging');
      grabX = e.clientX - b.x; grabY = e.clientY - b.y;
      lastX = e.clientX; lastY = e.clientY; lastT = performance.now();
      b.vx = b.vy = 0;
      b.el.setPointerCapture(e.pointerId);
      wake();
    });
    b.el.addEventListener('pointermove', function (e) {
      if (!b.dragging) return;
      var nx = e.clientX - grabX, ny = e.clientY - grabY, now = performance.now(), dt = Math.max(now - lastT, 1) / 1000;
      if (Math.abs(nx - b.x) + Math.abs(ny - b.y) > 3) moved = true;
      // Smoothed pointer velocity, used for the fling.
      b.vx = b.vx * 0.5 + (e.clientX - lastX) / dt * 0.5;
      b.vy = b.vy * 0.5 + (e.clientY - lastY) / dt * 0.5;
      lastX = e.clientX; lastY = e.clientY; lastT = now;
      b.x = Math.max(radius(b), Math.min(W - radius(b), nx));
      b.y = Math.max(radius(b), Math.min(H - radius(b), ny));
      wake();
    });
    var drop = function () {
      if (!b.dragging) return;
      b.dragging = false;
      b.el.classList.remove('dragging');
      var v = Math.hypot(b.vx, b.vy), max = 1600;
      if (v > max) { b.vx *= max / v; b.vy *= max / v; }
      if (performance.now() - lastT > 80) b.vx = b.vy = 0; // held still before letting go
      wake();
    };
    b.el.addEventListener('pointerup', drop);
    b.el.addEventListener('pointercancel', drop);
    b.el.addEventListener('click', function (e) { if (moved) { e.preventDefault(); e.stopPropagation(); } }, true);
  });

  // The pointer shoves bodies in the ball pit and steers the paddle in breakout.
  arena.addEventListener('pointermove', function (e) {
    var rect = arena.getBoundingClientRect(), x = e.clientX - rect.left, y = e.clientY - rect.top, now = Date.now();
    var dt = Math.max(now - pointer.t, 8) / 1000;
    if (now - pointer.t < 200) { pointer.vx = (x - pointer.x) / dt; pointer.vy = (y - pointer.y) / dt; }
    pointer.x = x; pointer.y = y; pointer.t = now;
    if (modeName === 'pit') wake();
    if (modeName === 'breakout') paddle.x = Math.max(paddle.w / 2, Math.min(W - paddle.w / 2, x));
  });

  document.addEventListener('keydown', function (e) {
    if (modeName !== 'breakout' || document.querySelector('dialog[open]')) return;
    if (e.key === 'ArrowLeft' || e.key === 'ArrowRight') {
      e.preventDefault();
      paddle.x = Math.max(paddle.w / 2, Math.min(W - paddle.w / 2, paddle.x + (e.key === 'ArrowLeft' ? -40 : 40)));
    }
  });

  // Tilting a phone tips the ball pit's gravity.
  window.addEventListener('deviceorientation', function (e) {
    if (e.beta === null || e.gamma === null) return;
    var gx = Math.sin(e.gamma * Math.PI / 180), gy = Math.sin(e.beta * Math.PI / 180);
    var len = Math.hypot(gx, gy);
    if (len < 0.15) return; // lying flat: keep gravity pointing down the screen
    var nx = gx / len, ny = gy / len;
    if (Math.abs(nx - gravity.x) + Math.abs(ny - gravity.y) < 0.05) return;
    gravity.x = nx; gravity.y = ny;
    if (modeName === 'pit') wake();
  });

  // The arena changes size with the window and with each mode's controls above it.
  var resized = function () {
    if (arena.clientWidth === W && arena.clientHeight === H) return;
    measure();
    if (modeName === 'breakout') layoutBricks();
    else if (modeName !== 'pit') mode.enter();
    bodies.forEach(walls);
    wake();
  };
  if (window.ResizeObserver) new ResizeObserver(resized).observe(arena);
  else window.addEventListener('resize', resized);

  // ----- Start -----

  root.classList.add('live'); // positions the bodies absolutely, so measure the covers after this
  measure();
  bodies.forEach(function (b) {
    b.s = fit * 0.8;
    scatter(b);
    var a = Math.random() * Math.PI * 2;
    b.vx = Math.cos(a) * 45; b.vy = Math.sin(a) * 45;
  });
  setMode(location.hash.slice(1));
})();
