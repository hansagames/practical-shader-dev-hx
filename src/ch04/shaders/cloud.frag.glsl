#version 300 es
precision highp float;

out vec4 outColor;
in vec2 fragUV;

uniform sampler2D cloud;

void main() {
	outColor = texture(cloud, fragUV);
	outColor.a = min(outColor.a, 0.8);
}