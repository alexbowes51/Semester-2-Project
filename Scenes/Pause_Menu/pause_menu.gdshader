shader_type canvas_item;
uniform sampler2D SCREENTEXTURE: hint_screen_texture,filter_linear_mipmap;

uniform float blurr : hint_range(0.0, 5);


void fragment() {
	vec4 color = texture(SCREENTEXTURE,SCREEN_UV,blurr);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
