#version 300 es
precision highp int;
precision highp float;

in vec2 fragUV;
in vec3 fragNormal;

uniform vec3 lightDir;
uniform vec3 lightCol;
uniform vec3 meshCol;

out vec4 outColor;
void main() {
	vec3 normal = normalize(fragNormal);
	float lightAmt = max(0.0, dot(normal, lightDir));
	vec3 fragLight = lightCol * lightAmt;
	outColor = vec4(meshCol * fragLight, 1.0);
}