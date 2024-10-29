shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float amount : hint_range(0.0, 1.0); // Adjust amount to fade effect in and out

void fragment() {
    // Sample the screen texture
    vec4 color = texture(screen_texture, SCREEN_UV);

    // Convert to grayscale using weighted RGB average
    float grayscale = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // Mix the original color with grayscale based on the 'amount' value
    vec3 final_color = mix(color.rgb, vec3(grayscale), amount);

    COLOR = vec4(final_color, color.a);
}
//void fragment() {
    //COLOR = vec4(1.0, 0.0, 0.0, 1.0); // Output red to test

    //vec4 color = texture(TEXTURE, UV);
    //float gray = (color.r + color.g + color.b)/ 3.0;
    //COLOR = vec4(gray, gray, gray, color.a); // Preserve original alpha
//}
//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
