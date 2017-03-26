Shader "Custom/Rimlighting" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_Rim("Rim", Range(0, 10)) = 2.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM

		#pragma surface surf Standard Standard
		#pragma target 3.0


		struct Input {
			float3 worldNormal;
			float3 viewDir;
		};

		fixed4 _Color;
		fixed4 _RimColor;
		float _Rim;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
			o.Albedo = _Color.rgb;
			float rim = 1 - saturate(dot(IN.viewDir, IN.worldNormal));
			o.Emission = _RimColor * pow(rim, _Rim);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
