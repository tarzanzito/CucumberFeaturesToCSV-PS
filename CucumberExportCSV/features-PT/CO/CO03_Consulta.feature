#language:pt
@CO03-CON
Funcionalidade: CO03 - Consulta - Perfil '999999'

  Fundo: Login na CO03
    Dado login efetuado no TF
    Quando entra na "CO03"
    Então valida que apresenta transacção

  @CO03-CON-03
  Esquema do Cenário: CO03 - Validar que introduzindo o campo chave [Entidade] e [Balcão Titular], a transacção retorna resultados
    Quando preenche o campo chave [Entidade] com "<Entidade>"
    E preenche o campo chave [Balcão Titular] com "<BalcaoTitular>"
    E clica no botão [Consultar F12]
    Então valida que a "CO03" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    #Retirar print do ecrã após F12
    #SELECT *
    #FROM DBSTSTX.COVT01C0_EFAREC
    Exemplos: 
      | Entidade | BalcaoTitular |
      | UCI      |          0231 |
      | UCI      |          5267 |

  @CO03-CON-04
  Cenário: CO03 - Validar que quando a consulta não tem resultados apresenta mensagem de erro de central [NÃO EXISTEM REGISTOS/FIM DE CONSULTA]
    Quando preenche o campo chave [Entidade] com "ALD"
    E preenche o campo chave [Balcão Titular] com "0231"
    E clica no botão [Consultar F12]
    Então valida que a "CO03" apresenta a mensagem de erro de central "1", "NAO EXISTEM REGISTOS/FIM DE CONSULTA"
    #Retirar print do ecrã com a mensagem de erro

    
  @CO03-CON-05
  Cenário: CO03 - Validar que quando a consulta tem resultados, obriga a seleccionar um registo para aceder à transacção destino CO13, apresentado mensagem de erro de local [Por Favor seleccione uma linha]
    Quando preenche o campo chave [Entidade] com "UCI"
    E preenche o campo chave [Balcão Titular] com "0231"
    E clica no botão [Consultar F12]
    Então valida que a "CO03" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
    Quando clica no botão [Estorno]
    Então valida que a "CO03" apresenta a mensagem de erro de local "Por Favor seleccione uma linha"
    #E valida que quando se clica no botão [Estorno] a transacção apresenta a mensagem de erro de local [Por Favor seleccione uma linha]
    #Retirar print do ecrã com a mensagem de erro

    
  #@CO03-CON-06 NEGA a @CO03-CON-06 
  #Cenário: CO03 - Validar que quando a consulta tem resultados, a transacção apresenta um fast-path para a CO13 denominado [Estorno] com o mouse over com o seguinte descritivo [CO13 - Consulta Cobranças Efectuadas - EFAS]
  #  Quando preenche o campo chave [Entidade] com "UCI"
  #  E preenche o campo chave [Balcão Titular] com "0231"
  #  E clica no botão [Consultar F12]
  #  Então valida que a "CO03" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
  #  E valida que quando se coloca o rato por debaixo do botão [Estorno] é apresentado um mouse over com o seguinte descritivo [CO13 - Consulta Cobranças Efectuadas - EFAS]
  
    
