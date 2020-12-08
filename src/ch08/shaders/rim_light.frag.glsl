#version 300 es
precision highp int;
precision highp float;

in vec3 fragNormal;
in vec3 fragWorldPos;

uniform vec3 cameraPosition;
uniform vec3 lightDir;
uniform vec3 lightCol;
uniform vec3 meshCol;

out vec4 outColor;
void main() {
	vec3 normal = normalize(fragNormal);
	vec3 toCam = normalize(cameraPosition - fragWorldPos);
	float rimAmt = 1.0 - max(0.0, dot(normal, toCam));
	rimAmt = pow(rimAmt, 2.0);
	float lightAmt = max(0.0, dot(normal, lightDir));
	vec3 fragLight = lightCol * lightAmt;
	outColor = vec4(meshCol * fragLight + rimAmt, 1.0);
}