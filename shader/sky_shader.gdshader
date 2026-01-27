shader_type sky;
uniform vec3 skyColor : source_color;
uniform vec3 horizonColor : source_color;

void sky() {
	float t = (EYEDIR.y + 1.0) * 0.5;

    // Smooth gradient
    t = smoothstep(0.0, 1.0, t);
    //t = smoothstep(0.0, 1.0, t); // extra smooth

    // Fake vertical blur with 3 samples
    float offset = 0.02;
    vec3 c1 = mix(horizonColor, skyColor, clamp(t + offset, 0.0, 1.0));
    vec3 c2 = mix(horizonColor, skyColor, t);
    vec3 c3 = mix(horizonColor, skyColor, clamp(t - offset, 0.0, 1.0));

    vec3 finalColor = (c1 + c2 + c3) / 3.0;

    COLOR = finalColor;
}
