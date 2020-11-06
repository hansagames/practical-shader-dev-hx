#version 300 es
precision highp float;

out vec4 outColor;
in vec2 fragUV;

uniform sampler2D parrotTex;
uniform float brightness;

void main() {
	vec4 tex = texture(parrotTex, fragUV);
	tex.rgb *= brightness;
	outColor = tex;
}