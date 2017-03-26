Shader "Custom/Rimlighting" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_Rim("Rim", Range(0, 10)) = 2.5
		_Spec("Specular", Range(2.0, 30.0)) = 10.0
		_Outline("Outline", Range(0, 10.0)) = 1.5
	}
	SubShader{
		Tags{ "RenderType" = "Transparent" }
		Tags{ "Queue" = "Transparent" }
		LOD 200

		CGPROGRAM
		 
		#pragma surface surf SimplePhong alpha:fade
		#pragma target 3.0


		struct Input {
			float3 worldNormal;
			float3 viewDir;
			float3 worldPos;
		};

	fixed4 _Color;
	fixed4 _RimColor;
	float _Rim;
	float _Spec;
	float _Outline;

	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = _Color.rgb;
		float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
		o.Alpha = alpha * _Outline;
		float rim = 1 - saturate(dot(IN.viewDir, IN.worldNormal));
		o.Emission = _RimColor * pow(rim, _Rim);
	}

	half4 LightingSimplePhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
	{
		half NdotL = max(0, dot(s.Normal, lightDir));
		float3 R = normalize(-lightDir + 2.0 * s.Normal * NdotL);
		float3 spec = pow(max(0, dot(R, viewDir)), _Spec);

		half4 c;
		c.rgb = s.Albedo + spec;
		c.a = s.Alpha;
		return c;
	}

	ENDCG
	}
	FallBack "Diffuse"
}
