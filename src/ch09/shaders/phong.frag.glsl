#version 300 es
precision highp int;
precision highp float;

in vec3 fragNormal;
in vec3 fragWorldPos;

uniform vec3 lightDir;
uniform vec3 lightCol;
uniform vec3 meshCol;
uniform vec3 meshSpecCol;
uniform vec3 ambientCol;
uniform vec3 cameraPosition;

out vec4 outColor;

void main() {
	vec3 normal = normalize(fragNormal);
    vec3 reflection = reflect(-lightDir, normal);
    vec3 viewDir = normalize(cameraPosition - fragWorldPos);

    float diffuseAmount = max(0.0, dot(normal, lightDir));
    vec3 diffuseColor = meshCol * lightCol * diffuseAmount;

    float specularAmount = max(0.0, dot(reflection, viewDir));
    float specularBrightnes = pow(specularAmount, 16.0);
    vec3 specularColor = meshSpecCol * lightCol * specularBrightnes;

    vec3 ambient = ambientCol * meshCol;

	outColor = vec4(diffuseColor + specularColor + ambient, 1.0);
}