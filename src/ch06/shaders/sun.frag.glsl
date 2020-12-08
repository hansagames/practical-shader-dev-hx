#version 300 es
precision highp float;

out vec4 outColor;
in vec2 fragUV;

uniform sampler2D sun;

void main() {
	outColor = texture(sun, fragUV);
	outColor.a = min(outColor.a, 0.8);
}