CLEAR

lcComando = "Guid()"
? m.lcComando + " (formato XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX):  " + &lcComando
?
lcComando = "Guid('curto')"
? m.lcComando + " (formato XXXXXXXX):  " + &lcComando
?
lcComando = "Guid('ordenavel')"
? m.lcComando + " (formato AAAAMMDD-HHMM-SSXX-XXXX-XXXXXXXXXXXX):  " + &lcComando
?
? '10 guids ordenáveis em loop, com pausa insuficiente para evitar repetição de segundos):'
lcComando = "Guid('ordenavel', 0.1)"
FOR i = 1 TO 10
	? m.lcComando + ":  " + &lcComando
ENDFOR
?
? '10 guids ordenáveis em loop, com pausa suficiente para evitar repetição de segundos):'
lcComando = "Guid('ordenavel', 0.7)"
FOR i = 1 TO 10
	? m.lcComando + ":  " + &lcComando
ENDFOR
?
lcComando = "Guid('vazio')"
? m.lcComando + ":  " + &lcComando
?
lcComando = "Guid('parâmetro inválido')"
? m.lcComando + ":  " + &lcComando
