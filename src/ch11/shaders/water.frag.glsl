#version 300 es
precision highp int;
precision highp float;

in vec3 fragWorldPos;
in vec2 fragUV;
in vec2 fragUV2;
in mat3 TBN;

uniform vec3 lightDir;
uniform vec3 lightCol;
uniform vec3 cameraPosition;
uniform sampler2D normalTex;
uniform samplerCube cubeTexture;

out vec4 outColor;

void main() {
	vec3 normal = texture(normalTex, fragUV).rgb;
    normal = normalize(normal * 2.0 - 1.0);

	vec3 normal2 = texture(normalTex, fragUV2).rgb;
    normal2 = normalize(normal2 * 2.0 - 1.0);

    normal = normalize((normal + normal2));
    
    vec3 viewDir = normalize(cameraPosition - fragWorldPos);
    vec3 halfVec = normalize(viewDir + lightDir);

    float diffuseAmount = max(0.0, dot(normal, lightDir));
    vec3 diffuseColor = texture(cubeTexture, reflect(-viewDir, normal)).xyz * lightCol * diffuseAmount;

    float specularAmount = max(0.0, dot(halfVec, normal));
    float specularBrightnes = pow(specularAmount, 512.0);
    vec3 specularColor = lightCol * specularBrightnes;

	outColor = vec4(diffuseColor + specularColor, 1.0);
}