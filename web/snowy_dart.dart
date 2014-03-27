import 'dart:html';
import 'dart:math' as math;
import 'dart:async';

class Flake{
  double _x, _y, _r, _d;
  Flake(double x, double y, double r, double d){
    this._x = x;
    this._y = y;
    this._r = r;
    this._d = d;
  }
}

var flakes = [];
const int maxFlakes= 60; //max number of flakes 
const int speed = 5; // snowfall speed
// Duration of the animation
const thirtyMills = const Duration(milliseconds:30);
CanvasRenderingContext2D ctx;
var W = window.innerWidth;
var H = window.innerHeight;
var rng = new math.Random();


void snowFall(){
  // draw background on canvas
  ctx.fillStyle="#000";
  ctx.fillRect(0,0,W,H);
  
  //drawing intitial snowflakes on canvas
  ctx.fillStyle = "#fff";
  // rain 
  ctx.beginPath();
  
  for(var i = 0; i < maxFlakes; i++){
    var f = flakes[i];
    ctx.moveTo(f._x, f._y);
    ctx.arc(f._x, f._y, f._r, 0, math.PI*2, true);
  }
  ctx.fill();
  
  //moving snow flakes
  var angl=0;
  for(var i=0; i < maxFlakes; i++){
    angl+=0.1;
    var f=flakes[i];
    f._x +=math.sin(angl).abs() + 0.1 ;
    f._y += math.cos(angl).abs() * speed;
    //resetting snowflakes when they are out of frame
    if(f._x > W || f._x < 0 || f._y > H){
      f._x = rng.nextDouble() * W;
      f._y=-10.0;
    }
  }
  
}

void main() {
  var canvas = querySelector('#stage');
  ctx = canvas.getContext('2d');
  
  // resize canvas
  canvas.width = W;
  canvas.height = H;
  
  // create random flakes
  for(int i = 0; i < maxFlakes; i++){
    flakes.add(
        new Flake(
          rng.nextDouble() * W,
          rng.nextDouble() * H,
          rng.nextDouble() * 3,
          rng.nextDouble() * maxFlakes
        )
    );
  }
    
  // make the magic happen
  new Timer.periodic(thirtyMills, (Timer t) => snowFall());
}
