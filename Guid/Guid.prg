LPARAMETERS tcVersao AS String, tnSegundos AS Number

LOCAL lcAgora AS String

IF VARTYPE(m.tcVersao) # "C"
	tcVersao = "padrao"
ENDIF

IF VARTYPE(m.tnSegundos) # "N"
	tnSegundos = 0.7
ENDIF

loTypeLib = CREATEOBJECT("Scriptlet.TypeLib")
lcGuid = STREXTRACT(m.loTypeLib.Guid, "{", "}")

DO CASE

CASE m.tcVersao = "padrao"
	
	RETURN m.lcGuid

CASE m.tcVersao = "curto"

	RETURN LEFT(m.lcGuid, 8)

CASE m.tcVersao = "ordenavel"
	
	WAIT "" TIMEOUT (m.tnSegundos)
	lcAgora = TTOC(DATETIME())

	RETURN 	SUBSTR(m.lcAgora, 7, 4) + ;
			SUBSTR(m.lcAgora, 4, 2) + ;
			SUBSTR(m.lcAgora, 1, 2) + ;
			"-" + ;
			SUBSTR(m.lcAgora, 12, 2) + ;
			SUBSTR(m.lcAgora, 15, 2) + ;
			"-" + ;
			SUBSTR(m.lcAgora, 18, 2) + ;
			SUBSTR(m.lcGuid, 17)

OTHERWISE
	
	RETURN "00000000-0000-0000-0000-000000000000"
	
ENDCASE
