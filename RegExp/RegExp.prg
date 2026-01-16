* Copyright (C) 2022 Metha Consultoria e Sistemas de Informatica Ltda.
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
* and associated documentation files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge, publish, distribute, 
* sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all copies or 
* substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
* BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
* DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

LPARAMETERS tcTexto AS String, tcPadrao AS String, tlDesconsiderarEspacosADireita AS Boolean
LOCAL lcPadrao AS String, lcTexto AS String
IF m.tlDesconsiderarEspacosADireita
	lcTexto = ALLTRIM(m.tcTexto)
ELSE
	lcTexto = m.tcTexto
ENDIF
DO CASE
CASE UPPER(m.tcPadrao) = 'EMAIL' && ex.correto x@x.com | ex.incorreto: x@.x.com
	lcPadrao = '^([0-9a-zA-Z]+[-._+&])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$'
CASE UPPER(m.tcPadrao) = 'HORA' && ex.correto: 13:30 | ex.incorreto: 23:60
	lcPadrao = '^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$'
CASE UPPER(m.tcPadrao) = 'TELEFONE_COM_SEPARADOR' && ex.correto: 2123-1234 | ex.incorreto: 2123-123
	lcPadrao = '^\d{4,5}-\d{4}$'
OTHERWISE
	lcPadrao = m.tcPadrao
ENDCASE
loRegExp = CREATEOBJECT('VBScript.RegExp')
loRegExp.Pattern = m.lcPadrao
RETURN m.loRegExp.Test(m.lcTexto)
