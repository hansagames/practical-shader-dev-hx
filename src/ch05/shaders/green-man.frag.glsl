#version 300 es
precision highp float;

out vec4 outColor;
in vec2 fragUV;

uniform sampler2D greenMan;

void main() {
	vec4 tex = texture(greenMan, fragUV);
	outColor = tex;

	if (outColor.a < 1.0) {
		discard;
	}
}