'use strict';

//          * * * * * * * * * * * * *
//          * *      WARNING      * *
//          * * * * * * * * * * * * *
// I wrote this alongside someone who happened to be:
//
//   a) Eager and ambitious at the beginning of their
//      Programmer's Journey, and:
//   b) Really keen on Pokémon.
//
// It was fun *training*, but the code's *evolution*
// left it smelling somewhat like *Weezing* (these
// are Pokemon things iirc, C_y I'm not hip anymore).
//
// Enter at your own risk, enjoy, catch 'em all :)
// - rileyjshaw

var colors = ['#f10d00', // Standard ball
'#a63deb', // Master ball
'#5baeff', // Great ball
'#00874b', // Safari ball
'#505301'];

// Editable.
// Ultra ball
var d = 72; // Diameter.
var w = 8; // Inner line width.
var T = 120; // Period, in frames @ 60fps.

// Computed.
var r = d / 2; // Radius.
var r2_max = r / 5; // Max radius of the mid-section.
var l = r * 2 + w; // Canvas side length.

// Constants.
var _Math = Math;
var abs = _Math.abs;
var pi = _Math.PI;

var C_y = 4 / 3; // Simplified from 4/3*tan(θ/4)), since θ=π.
var _document = document;
var body = _document.body;

var bag = document.createElement('div');
bag.id = 'pokeball'
Object.assign(bag.style, {
  top: '200px',
  left: '50%',
  position: 'absolute',
  transform: 'translate3d(-50%, -50%, 0)'
});

var team = colors.map(pokeball);
team.forEach(function (ball) {
  return bag.appendChild(ball.canvas);
});
var loader = document.getElementById('pokeball');
loader.appendChild(bag);

!function loop(t) {
  team.forEach(function (_ref, i, _ref2) {
    var step = _ref.step;
    var length = _ref2.length;
    return step((t + i * T / length) % T);
  });
  requestAnimationFrame(loop.bind(this, t + 1));
}(0);

function pokeball(top) {
  // Constants.
  var canvas = document.createElement('canvas');
  var ctx = canvas.getContext('2d');

  // Prepare the canvas and clip it to a circle.
  canvas.width = canvas.height = l;
  Object.assign(canvas.style, {
    background: '#f0f0f0',
    border: w / 2 + 'px solid #f8f8f8',
    borderRadius: '50%',
    boxShadow: '2px 4px rgba(34, 34, 36, 0.2)',
    height: l / 2 + 'px',
    margin: w + 'px',
    width: l / 2 + 'px'
  });
  ctx.translate(w / 2, w / 2);
  ctx.beginPath();
  ctx.lineWidth = w;
  ctx.arc(r, r, r, 0, 2 * pi);
  ctx.stroke();
  ctx.clip();

  ctx.strokeStyle = '#222224';
  function step(t) {
    // t:     0 -------- T/2 -------- T
    // frame: 0 --------- T --------- 0
    // y:     bottom --- top --- bottom
    //     where bottom: 1 - C_y, top: C_y
    var frame = 2 * (T / 2 - abs(T / 2 - t));
    var y = 1 - C_y + frame / T * (2 * C_y - 1);

    ctx.clearRect(0, 0, d, d);
    ctx.lineWidth = w;

    // Draw a "circle".
    ctx.beginPath();
    ctx.fillStyle = top;
    ctx.moveTo(-w / 2, r);
    ctx.bezierCurveTo(-w / 2, y * d, d + w, y * d, d + w, r);
    ctx.stroke();
    //ctx.arc(r, r, r, 0, pi, true);
    ctx.lineTo(d, 0);
    ctx.lineTo(0, 0);
    ctx.fill();
    ctx.closePath();

    // Draw the center circle.
    var c = d * y / C_y + r2_max * C_y;
    var r2 = r2_max * (1 - abs(1 / 2 - y) / 3);
    var r3 = r2 / 3 * 2;

    ctx.beginPath();
    ctx.lineWidth /= 2;
    ctx.fillStyle = '#f0f0f0';
    ctx.arc(r, c, r2, 0, 2 * pi);
    ctx.fill();
    ctx.stroke();
    ctx.closePath();

    ctx.beginPath();
    ctx.lineWidth /= 2;
    ctx.arc(r, c, r3, 0, 2 * pi);
    ctx.stroke();
    ctx.closePath();
  };
  return { canvas: canvas, step: step };
}
