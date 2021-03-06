#version 300 es
precision highp int;
precision highp float;

uniform vec3 lightCol;

uniform float lightRadius;
uniform vec3 lightPos;

uniform sampler2D normalTex;
uniform sampler2D diffuseTex;
uniform sampler2D specTex;
uniform samplerCube cubeTexture;

uniform vec3 cameraPosition;

in vec3 fragWorldPos;
in vec2 fragUV;
in mat3 TBN;

out vec4 outColor;

@import ./light;

void main() {
    vec3 normal = texture(normalTex, fragUV).rgb;
    normal = normalize(normal * 2.0 - 1.0);
    normal = normalize(TBN * normal);
    vec3 viewDir = normalize(cameraPosition - fragWorldPos);

    vec3 envSample = texture(cubeTexture, reflect(-viewDir, normal)).xyz;
    vec3 sceneLight = mix(lightCol, envSample + lightCol * 0.5, 0.5);

    vec3 toLight = lightPos - fragWorldPos;
    vec3 lightDir = normalize(toLight);
    float distToLight = length(toLight);
    float falloff = max(0.0, 1.0 - distToLight / lightRadius);
    float specMask = texture(specTex, fragUV).x;

    float diffAmt = diffuse(lightDir, normal) * falloff;
    float specAmt = specular(lightDir, viewDir, normal, 4.0) * specMask * falloff;

    vec3 diffCol = texture(diffuseTex, fragUV).rgb * sceneLight * diffAmt;


    vec3 specCol = specMask * sceneLight * specAmt;


	outColor = vec4(diffCol + specCol, 1.0);
}