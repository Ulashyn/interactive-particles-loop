uniform float time;
uniform float progress;
uniform sampler2D uPositions;
uniform vec4 resolution;
varying vec2 vUv;
varying vec3 vPosition;
float PI = 3.141592653589793238;
void main() {
  vec4 pos = texture2D(uPositions, vUv);
  float radius = length(pos.xy);
  float angle = atan(pos.y, pos.x) + 0.1;
  vec3 targetPos = vec3(cos(angle), sin(angle), 0.0) * radius;
  pos.xy += (targetPos.xy - pos.xy) * 0.1;
  // pos.xy += vec2(0.001);
  // vec2 newUV = (vUv - vec2(0.5)) * resolution.zw + vec2(0.5);
  gl_FragColor = vec4(pos.xy,1.,1.);

}