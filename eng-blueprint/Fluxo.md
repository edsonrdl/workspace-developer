![[Pasted image 20260527191916.png]]

A ordem é exatamente a sequência numérica que está no grafo:

```
spec → requirements → contracts → acceptance → plan → tasks
```

O `spec` é o ponto de entrada porque ele é o **porquê** — o problema, o escopo, os consumidores. Sem entender isso primeiro, o agente não tem contexto pra interpretar os requisitos nem o plano.

O `plan` vem penúltimo porque ele é o **como** — e o como só faz sentido depois que o agente já sabe o quê (`requirements`), o que vai produzir (`contracts`) e como vai validar (`acceptance`).

Se o agente lesse o `plan` primeiro ele saberia como construir mas não saberia **o que** construir nem **por que** aquelas decisões foram tomadas.