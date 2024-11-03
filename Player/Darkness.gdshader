shader_type canvas_item;
uniform vec4 base_color; // Base color of the object
uniform float light_intensity = 0.7; // Control light intensity

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    vec3 light_contribution = vec3(1.0) * light_intensity; // Assuming the light is white
    COLOR = tex_color * base_color * vec4(light_contribution, 1.0);

}
