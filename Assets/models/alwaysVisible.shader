﻿Shader "Front/Front Diffuse" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
	}
		SubShader{
		//Using the transparent queue +50 ensures us that this object will be rendered after all other
		//transparent objects, removing any possible alpha depth bugs. Using the transparent queue
		//instead of the geometry queue enables us to ignore zwriting properly
		Tags { "Queue" = "Transparent+50" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 200
		ZTest Always
		ZWrite Off
		Fog { Mode Off }
	CGPROGRAM
	#pragma surface surf Lambert

	sampler2D _MainTex;
	fixed4 _Color;

	struct Input {
		float2 uv_MainTex;
	};

	void surf(Input IN, inout SurfaceOutput o) {
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
	}
	ENDCG
	}

		Fallback "VertexLit"
}
