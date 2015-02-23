* Copyright (C) 2006 Metha Sistemas de Informatica Ltda.
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

* *obs01* - 17/04/2006 - Márcio Gonçalves - Correção erro de lógica
* *obs02* - 30/01/2007 - Flávio Almeida - Correção erro de lógica
* *obs03* - 03/04/2008 - Flávio Almeida - Correção erro de lógica
* *obs04* - 14/05/2008 - Flávio Almeida - Correção erro de lógica

LPARAMETERS tElementoProcurado, tConjunto
DO CASE
CASE VARTYPE(m.tElementoProcurado) = 'N'
	lnElementoProcurado = m.tElementoProcurado
CASE VARTYPE(m.tElementoProcurado) = 'C'
	lnElementoProcurado = VAL(m.tElementoProcurado)
OTHERWISE
	RETURN .F.
ENDCASE
DO CASE
CASE VARTYPE(m.tConjunto) = 'C' AND LEN(m.tConjunto) > 0
	lcConjunto = ALLTRIM(m.tConjunto)
OTHERWISE
	RETURN .F.
ENDCASE
IF UPPER(m.lcConjunto) = 'DIF:'		&& DIF: = diferente de ...
	lcInversor = 'NOT'	&& inverte o resultado
	lcConjuntoOriginal = SUBSTR(m.lcConjunto, 5)
ELSE
	lcInversor = '' 		&& não inverte o resultado
	lcConjuntoOriginal = m.lcConjunto
ENDIF
llResposta = .F.
lcConjunto = m.lcConjuntoOriginal
lnPosPontoVirgula = AT(';', m.lcConjunto)
DO WHILE m.lnPosPontoVirgula # 0
	lnElementoConjunto = Val(Left(m.lcConjunto, m.lnPosPontoVirgula))
	IF m.lnElementoProcurado = m.lnElementoConjunto
		llResposta = .T.
		EXIT
	ENDIF
	lcConjunto = Substr(m.lcConjunto, m.lnPosPontoVirgula + 1)
	lnPosPontoVirgula = At(';', m.lcConjunto)
ENDDO
IF NOT m.llResposta
	lnPosHifen = At('-', m.lcConjunto)
	If m.lnPosHifen = 0
		lnElementoConjunto = VAL(m.lcConjunto)
	Else
		lnElementoConjunto = VAL(LEFT(m.lcConjunto, m.lnPosHifen - 1))
	Endif
	If m.lnElementoProcurado = m.lnElementoConjunto
		llResposta = .T.
	Endif
ENDIF 
IF NOT m.llResposta
	lcConjunto = m.lcConjuntoOriginal
	Do While At('-', m.lcConjunto) # 0
		lnPosHifen = At('-', m.lcConjunto)
		lnPosPontoVirgula = At(';', m.lcConjunto) && obs02
		Do While m.lnPosPontoVirgula # 0 And m.lnPosPontoVirgula < m.lnPosHifen
			lcConjunto = Substr(m.lcConjunto, m.lnPosPontoVirgula + 1)
			lnPosPontoVirgula = At(';', m.lcConjunto) && obs02
			lnPosHifen = At('-', m.lcConjunto) && obs04 só essa linha foi adicionada para a obs04
		Enddo
		lnPosHifen = At('-', m.lcConjunto)
		lcInicio = Left(m.lcConjunto, m.lnPosHifen - 1)
		lcConjunto = Substr(m.lcConjunto, m.lnPosHifen + 1)
		lnTamanhoConjunto = Len(m.lcConjunto)
		lcFim = ''
		Do While Len(m.lcFim) < m.lnTamanhoConjunto
			lcProximoCaracter = Substr(m.lcConjunto, Len(m.lcFim) + 1)
			If Not m.lcProximoCaracter $ '-;'
				m.lcFim = m.lcFim + m.lcProximoCaracter
			Endif
		Enddo
		lnInicio = Val(m.lcInicio)
		lnFim = Val(m.lcFim)
		If Between(m.lnElementoProcurado, m.lnInicio, m.lnFim)
			llResposta = .T.
			EXIT
		Else
			lnPosPontoVirgula = At(';', m.lcConjunto) && *obs02 (linha nova)
			lcConjunto = Substr(m.lcConjunto, m.lnPosPontoVirgula + 1) && *obs02
		Endif
	Enddo
ENDIF
RETURN &lcInversor m.llResposta