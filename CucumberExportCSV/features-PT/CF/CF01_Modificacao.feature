#language:pt

@CF01-MOD
Funcionalidade: CF01 - Modificação - Perfil '999999'


Fundo: Login na CF01
Dado login efetuado no TF
Quando entra na "CF01"
Então valida que apresenta transacção




@CF01-MOD-01
Cenario: CF01 - Validar que quando não existe parâmetro carregado não retorna resultados
Quando preenche o campo chave [Nº Conta] com Balcão da conta "0000" e conta "00020086001" [CF01]
E clica no botão [Modificar F6]
Então valida que a "CF01" apresenta a mensagem de erro de central "6", "TABELA DE PARAMETROS DE CLIENTES SEM REGISTOS"
#Retirar print do ecrã com o resultado obtido com mensagem de erro de central 6 - TABELA DE PARAMETROS DE CLIENTES SEM REGISTOS.



@CF01-MOD-02
Cenario: CF01 - Validar que executa alterações com sucesso
Quando preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54379623020" [CF01]
E clica no botão [Modificar F6]
Então valida que a "CF01" apresenta o botão "Modificar (F12)"
Quando preenche o campo [Balcão Destino] com "0231"
E selecciona o campo Indicador [Tipo Cheque] com "Internacional"
E selecciona o campo Indicador [Impressão Destacável] coma "Não"
E clica no botão [Modificar F12]
Então valida que a "CF01" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
#Retirar print do ecrã com a Pestana [Detalhe 1]




@CF01-MOD-03
Cenario: CF01 - Validar que quando executa alterações com sucesso
Quando preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54379623020" [CF01]
E clica no botão [Modificar F6]
Então valida que a "CF01" apresenta o botão "Modificar (F12)"
#Quando preenche o campo [Balcão Destino] com "   "
Quando preenche o campo [Balcão Destino] com "0003"
E selecciona o campo Indicador [Tipo Cheque] com "Nacional"
E selecciona o campo Indicador [Impressão Destacável] coma "Sim"
E clica no botão [Modificar F12]
Então valida que a "CF01" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
#Retirar print do ecrã com a Pestana [Detalhe 1]








#@CF01-MOD-01
#Cenario: CF01 - Validar que quando não existe parâmetro carregado não retorna resultados
#Dado que preenche o campo chave [Nº Conta] com Balcão da conta "0000" e conta "00020086001"
#Quando clica no botão [Modifica F6]
#Então valida que é disponibilizada uma mensagem de erro de central "6;TABELA DE PARAMETROS DE CLIENTES SEM REGISTOS"
##Retirar print do ecrã com o resultado obtido com mensagem de erro de central 6 - TABELA DE PARAMETROS DE CLIENTES SEM REGISTOS.

#@CF01-MOD-02
#Cenario: CF01 - Validar que executa alterações com sucesso
#Dado que preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54379623020"
#Quando clica no botão [Modifica F6]
#Então valida que a Transacção "CF01" apresenta o botão "Modificar (F12)" visivel
#E preenche o campo [Balcão Destino] com "0231"
#E se altera o Indicador [Tipo Cheque] para "Internacional"
#E se altera o Indicador [Impressão Destacável] para "Não"
#Quando clica no botão [Modificar F12]
#Então valida que a Transacção "CF01" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
##Retirar print do ecrã com a Pestana [Detalhe 1]

#@CF01-MOD-03
#Cenario: CF01 - Validar que quando executa alterações com sucesso
#Dado que preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54379623020"
#Quando clica no botão [Modifica F6]
#E preenche o campo [Balcão Destino] com "   "
#E se altera o Indicador [Tipo Cheque] para "Nacional"
#E se altera o Indicador [Impressão Destacável] para "Sim"
#Quando clica no botão [Modificar F12]
#Então valida que a Transacção "CF01" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
##Retirar print do ecrã com a Pestana [Detalhe 1]
















