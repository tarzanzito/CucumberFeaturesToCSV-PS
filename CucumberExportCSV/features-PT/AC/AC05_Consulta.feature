#language:pt
@AC05-CON
Funcionalidade: AC05 - Consulta - Perfil '999999'

  Fundo: Login na TR56
    Dado login efetuado no TF
    Quando entra na "AC05"
    Então valida que apresenta transacção

  @AC05-CON-01A
  Cenário: AC05 - Valida que não entra dentro da transacção
    Quando preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54333042020"
    E clica no botão [Confirmar F12]
    Então valida que a "AC05" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
  
  