#include "curl.glsl"

uniform float time;
uniform float progress;
uniform sampler2D uPositions;
uniform sampler2D uInfo;
uniform vec4 resolution;
uniform vec2 uMouse;
varying vec2 vUv;
varying vec3 vPosition;
// float PI = 3.141592653589793238;
void main() {
  vec4 pos = texture2D(uPositions, vUv);
  vec4 info = texture2D(uInfo, vUv);
  vec2 mouse = uMouse;
  float radius = length(pos.xy);
  float circularForce = 1. - smoothstep(0.3,1.4,abs(pos.x-radius));
  float angle = atan(pos.y, pos.x) - info.y * 0.3 * mix(0.5,1.,circularForce);
  float targetRadius = mix(
    info.x,
    1.6,
    0.8 + 0.45 * sin(angle * 1.1 - 0.5)
  );
  radius += (targetRadius - radius) * mix(0.2,0.5,circularForce);
  vec3 targetPos = vec3(cos(angle), sin(angle), 0.0) * radius;
  pos.xy += (targetPos.xy - pos.xy) * 0.1;
  pos.xy += curl(pos.xyz * 4., time * 0.1, 0.1).xy * 0.005;
  float dist = length(pos.xy - mouse);
  vec2 dir = normalize(pos.xy - mouse);
  pos.xy += dir * smoothstep(0.3,0.0,dist) * 0.1;
  // pos.xy += vec2(0.001);
  // vec2 newUV = (vUv - vec2(0.5)) * resolution.zw + vec2(0.5);
  gl_FragColor = vec4(pos.xy,1.,1.);

}