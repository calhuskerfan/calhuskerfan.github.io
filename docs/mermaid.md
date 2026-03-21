---
layout: page
title: Mermaid
permalink: /mermaid/
published: false
---

Just Playing around with mermaid in Jekyll

<script type="module">
	import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
	mermaid.initialize({
		startOnLoad: true,
		theme: 'dark'
	});
</script>

<pre class="mermaid">
graph TB;
    A[T] --> B[I1] & C[I2] & D[I3]
    B --> E[F1]
    B --> H[F4]
    C --> F[FG1]
    D --> G[F3]
    F --> I[F5]
    F --> J[F6]
    E --> K[CA1]
    E --> L[CA2]
</pre>

<pre class="mermaid">
flowchart TD
     A-->B
</pre>

<pre class="mermaid">
graph TB
    sq[Square shape] --> ci((Circle shape))

    subgraph A
        od>Odd shape]-- Two line<br/>edge comment --> ro
        di{Diamond with <br/> line break} -.-> ro(Rounded<br>square<br>shape)
        di==>ro2(Rounded square shape)
    end

    %% Notice that no text in shape are added here instead that is appended further down
    e --> od3>Really long text with linebreak<br>in an Odd shape]

    %% Comments after double percent signs
    e((Inner / circle<br>and some odd <br>special characters)) --> f(,.?!+-*ز)

    cyr[Cyrillic]-->cyr2((Circle shape Начало));

     classDef green fill:#9f6,stroke:#333,stroke-width:2px;
     classDef orange fill:#f96,stroke:#333,stroke-width:4px;
     class sq,e green
     class di orange
</pre>
    