#language:pt
@TR56-CON
Funcionalidade: TR56 - Consulta - Perfil '999999'

  Fundo: Login na TR56
    Dado login efetuado no TF
    Quando entra na "TR56"
    Então valida que apresenta transacção

  @TR56-CON-01A
  Cenário: TR56 - Validar que caso se introduza uma Conta DO Ativa, o NIB e IBAN é calculado.
    Quando preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54333042020"
    E clica no botão [Confirmar F12]
    Então valida que a "TR56" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
    E valida que o [NIB] é preenchido com "0018" acrescido do Balcão da Conta, Conta e mais dois digitos.
    #Retirar print do ecrã de forma a confirmar que o NIB e IBAN são automaticamente calculados por um algoritmo de check digit
    
  @TR56-CON-01B
  Esquema do Cenário: TR56 - Validar que caso se introduza uma Conta DO Ativa, o NIB e IBAN é calculado.
    Quando preenche o campo chave [Nº Conta] com Balcão da conta "<BalcaoConta>" e conta "<Conta>"
    E clica no botão [Confirmar F12]
    Então valida que a "TR56" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
    E valida que o [NIB] é preenchido com "0018" acrescido do Balcão da Conta, Conta e mais dois digitos.

    #Retirar print do ecrã de forma a confirmar que o NIB e IBAN são automaticamente calculados por um algoritmo de check digit
    #SELECT A.CKBALCAO, A.CKNUMCTA
    #FROM DBSTSTX.CLVT18C0_CTACLI A,
    #DBSTSTX.MIVT15C2_CTAMIS B
    #WHERE A.CKBALCAO = B.CKBALCAO
    #AND A.CKNUMCTA = B.CKNUMCTA
    #AND A.DCANCEL = '9999-12-31'
    #AND A.CTITULAR = '1'
    #AND B.CSUBTIPO = 'DO'
    #FETCH FIRST 10 ROW ONLY
    Exemplos: 
      | BalcaoConta | Conta       |
      |        0000 | 00020086001 |
      |        0000 | 00020192001 |
      |        0000 | 00265669001 |

  @TR56-CON-02
  Cenário: TR56 - Validar que caso se introduza uma Conta DO Ativa com mais do que um Titular é apresentada mensagem de erro de alerta.
    Quando preenche o campo chave [Nº Conta] com Balcão da conta "0000" e conta "00020357001"
    E clica no botão [Confirmar F12]
    Então valida que a "TR56" apresenta a mensagem de erro de local "Confirme o 1º Titular da Conta:"
    #Retirar print do ecrã com a mensagem de erro de local "Confirme o 1º Titular da Conta:" acrescido do nome do Titular
    E clica no botão [OK]
    E clica no botão [Confirmar F12]
    Então valida que o [NIB] é preenchido com "0018" acrescido do Balcão da Conta, Conta e mais dois digitos.
  
