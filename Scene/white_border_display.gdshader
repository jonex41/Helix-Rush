shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    // Check if the pixel is black (or very close to it)
    if (tex_color.rgb == vec3(0.0, 0.0, 0.0) && tex_color.a > 0.0) {
        COLOR = vec4(1.0, 1.0, 1.0, tex_color.a); // Change to white
    } else {
        COLOR = tex_color; // Keep original color
    }
}
