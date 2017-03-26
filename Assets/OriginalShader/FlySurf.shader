Shader "Custom/FlySurf" {
	Properties {
		_BendScale("Bend Scale", Range(0.0, 1.0)) = 0.2
		_MainTex("Main Texture", 2D) = "white"{}
	}
	SubShader {
		Tags { "RenderType"="Transparent" }
		Tags {"Queue"="Transparent"}
		Cull off Zwrite On
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert alpha vertex:vert
		#define PI 3.14159

		sampler2D _MainTex;
		float _BendScale;

		struct Input {
			float2 uv_MainTex;
			float4 color : Color;
		};

		void vert(inout appdata_full v)
		{
			float bend = sin(PI * _Time.x * 1000 / 45 + v.vertex.y);
			float x = sin(v.texcoord.x * PI) - 1.0;
			float y = sin(v.texcoord.y * PI) - 1.0;
			v.vertex.y += _BendScale * bend * (x + y);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			float4 tex = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = tex.rgb;
			o.Alpha = IN.color.a * tex.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
