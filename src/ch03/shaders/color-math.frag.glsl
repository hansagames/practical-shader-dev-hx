#version 300 es
precision highp float;

out vec4 outColor;
in vec2 fragUV;

uniform sampler2D parrotTex;
uniform vec4 multiplay;
uniform vec4 add;

void main() {
	outColor = texture(parrotTex, fragUV) * multiplay + add;
}