shader_type canvas_item;
uniform float max_col_b = 0.1;
float line(float col_b){
	return (1.0/max_col_b)*col_b;
}
void fragment(){
	vec4 col = texture(TEXTURE,UV).rgba;
	if (col.r<=24.0 && col.g<=24.0 &&  col.b <= max_col_b) {
		col.a = line(col.b);
	}
	COLOR=col;
}