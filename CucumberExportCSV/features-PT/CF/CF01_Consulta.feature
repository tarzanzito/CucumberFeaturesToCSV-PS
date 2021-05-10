#language:pt

@CF01-CON
Funcionalidade: CF01 - Consulta - Perfil '999999'


Fundo: Login na CF01
Dado login efetuado no TF
Quando entra na "CF01"
Então valida que apresenta transacção




@CF01-CON-01
Cenário: CF01 - Validar que quando não existe parâmetro carregado não retorna resultados.
#Quando preenche o campo chave [Nº Conta] com Balcão da conta "0000" e conta "00020357001" [CF01]
Quando preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54331988020" [CF01]
#Balcão da Conta e Conta que exista na CLT18 com DCANCEL ='9999-12-31' e que não exista na CFT15
#SELECT ZCLIENTE, CEMPRESA, CKBALCAO, CKNUMCTA                        
#FROM DBSTSTX.CLVT18C0_CTACLI A                                       
#WHERE DCANCEL = '9999-12-31'                                         
#AND CTITULAR = '1'                                                   
#AND NOT EXISTS (SELECT 1 FROM DBSTSTX.CFVT15A0_PARAM                  
#WHERE CKBALCAO = A.CKBALCAO                                           
#AND CKNUMCTA = A.CKNUMCTA)                                                         	
#Retirar print com os campos chave 
E clica no botão [Consultar F5]
Então valida que a "CF01" apresenta a mensagem de erro de central "6", "TABELA DE PARAMETROS DE CLIENTES SEM REGISTOS"
#Retirar print do resultado obtido com código de erro 6 - TABELA DE PARAMETROS DE CLIENTES SEM REGISTOS.


#    Então valida que a "TR56" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
#    Então valida que a "TR56" apresenta a mensagem de erro de local "Confirme o 1º Titular da Conta:"
#    Então valida que a "CO03" apresenta a mensagem de erro de central "NAO EXISTEM REGISTOS/FIM DE CONSULTA"
	

@CF01-CON-02
Cenário: CF01 - Validar campos chave - Empresa da Conta "31" e Marca da Conta "BT"
Quando preenche o campo chave [Nº Conta] com Balcão da conta "0003" e conta "54336250020" [CF01]
#Balcão da Conta e Conta que exista na CLT18 com CEMPRESA ='31' AND CMARCA ='BT' e que exista na CFT15 
#SELECT A.ZCLIENTE, A.CEMPRESA, A.CKBALCAO, A.CKNUMCTA                         
#FROM DBSTSTX.CLVT18C0_CTACLI A ,                                              
#DBSTSTX.CFVT15A0_PARAM B                                                      
#WHERE A.CKBALCAO = B.CKBALCAO                                                 
#AND A.CKNUMCTA = B.CKNUMCTA                                                   
#AND A.DCANCEL = '9999-12-31'                                                  
#AND CEMPRESA = '31'     
E clica no botão [Consultar F5]
Então valida que a "CF01" apresenta em rodapé a mensagem "Operação efectuada com Sucesso"
E valida que o campo [Empresa] da Conta está preenchido com "31"
E valida que o campo [Marca] da Conta está preenchido com "BT"
#Retirar print do ecrã de forma a confirmar que prencheu os campos Empresa "31" e a Marca "BT".



